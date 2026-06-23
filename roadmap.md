# Dev Container Workspace Roadmap

Two viable paths for the shared devcontainer setup. Both keep `homelab` as the single source for the container image, Nix profile, and dotfiles — they differ in how VS Code opens projects on top of it.

**A note on the Nix profile.** The profile in `.devcontainer/profile/flake.nix` is the *base OS layer* of the image — shell, git, ssh, coreutils-style things you'd expect installed on any dev machine, plus a couple of always-on tools (claude-code, rust-analyzer). It is not a toolchain manager. Language toolchains (rustc, node, python, etc.) belong either in the profile as an Option-A-specific augmentation (one ambient version for everything) or in per-project `.envrc` flake shells (Option B). The choice between A and B is largely a choice about *where toolchains live*, not whether the profile exists.

---

## Option A: Do Nothing (Single Workspace, All of Developer)

Keep one devcontainer that mounts `~/Developer` into the container. One VS Code window holds the whole tree as a workspace.

### Shape

- `homelab/.devcontainer/` builds the image (Nix, dotfiles, profile).
- Workspace file lists `Developer` as the only folder. `homelab` shows up as a child like any other project — no double-load.
- `~/Developer` bind-mounted into the container; switching projects = `cd` into a sibling folder.
- One container, one VS Code window, one indexer, one file watcher tree.

### What needs to be done

- [ ] Drop the `homelab` entry from `homelab.code-workspace` (or replace the workspace file with one at `Developer/Developer.code-workspace` listing just `Developer`).
- [ ] Set `workspaceFolder` in `devcontainer.json` to `/root/Developer` so terminals, tasks, and the file explorer default to the broader tree.
- [ ] Re-enable the `~/Developer → /root/Developer` bind mount (currently commented out).
- [ ] **Augment the Nix profile with the ambient toolchain.** Move `cargo`, `rustc`, `rustfmt`, `clippy` from `flake.nix`'s `devShells.default` into `.devcontainer/profile/flake.nix`'s `packages` list so they sit alongside the base OS packages (shell, git, ssh, etc.) and land on `PATH` for every shell and language server. This is Option A's defining choice: treat the toolchain as part of the OS rather than per-project state, which is what makes direnv-at-workspace-root being broken a non-issue.
- [ ] Add workspace-level excludes for known-heavy paths: `**/target`, `**/node_modules`, `**/.direnv`, `**/result`, `**/.git/objects`. Set under `files.watcherExclude`, `search.exclude`, and `files.exclude`.
- [ ] Pin language servers to explicit project lists where possible:
  - `rust-analyzer.linkedProjects` listing only `Cargo.toml` files you're actively working in.
  - Disable `rust-analyzer.cargo.autoreload` and `checkOnSave` until needed.
- [ ] Document the "open one project at a time mentally" discipline — language servers will still try to chew on everything reachable.

### Tradeoffs

- **Pro:** zero ceremony to start a new project (drop a folder in `Developer`, it's already in the container).
- **Pro:** one container to keep warm, fast project switching.
- **Pro:** ambient toolchain from the profile means rust-analyzer Just Works in any subfolder without per-project `.envrc` activation.
- **Con:** indexer/file-watcher cost grows with `Developer`. Bigger trees → laggier window.
- **Con:** language servers don't respect "I'm only working on one thing" — they scan everything reachable unless explicitly pinned.
- **Con:** workspace settings become a battleground of excludes.
- **Con:** one toolchain version for all projects. If two projects need different rustc versions, the ambient approach can't express that.

### When this stops working

Two signals:
- `Developer` grows past ~5–10 active projects, or any single project has a large build output that can't be excluded cleanly — indexing latency dominates.
- Two projects need *different* toolchain versions (Rust nightly vs stable, different rustc pins, etc.) — the ambient profile can only carry one.

Either signal points to Option B.

### Aside: the abandoned "homelab as workspace folder" idea

Briefly considered: keep `homelab` AND `Developer` as two workspace folders, let `mkhl.direnv` activate `homelab/.envrc` and ambient-hoist the toolchain via direnv into the window environment. This worked accidentally before the cleanup. The profile-install approach above achieves the same effect without the double-folder workspace, the double-indexing of `homelab`, or the dependency on the direnv extension's behavior. Noted here so future-me doesn't re-derive it.

---

## Option B: One Window Per Project, Same Long-Running Container

One devcontainer (the homelab one), running indefinitely, with `~/Developer` mounted. Multiple VS Code windows attach to it — each window's workspace is scoped to a single project folder, so indexing and file-watching are per-window, not per-container.

### Shape

- `homelab/.devcontainer/` is the only devcontainer. Build it once, leave it running.
- `~/Developer → /root/Developer` bind-mounted, same as Option A.
- VS Code window 1 opens `/root/Developer/projectA` as its folder/workspace.
- VS Code window 2 opens `/root/Developer/projectB` against the same running container.
- Each window only watches/indexes its own project tree. The container sees everything; the editor only looks at one slice.
- Switching projects = open another window (`code /root/Developer/projectB` from a terminal already inside the container), not rebuilding anything.

### What needs to be done

- [ ] Same baseline as Option A: re-enable the `~/Developer` bind mount, set `workspaceFolder` sensibly, drop the duplicate homelab folder from any multi-root workspace file.
- [ ] Establish the "spawn a new window" workflow. From a terminal inside the running container: `code /root/Developer/<project>` opens a new VS Code window attached to the same container, scoped to that folder. Verify this works end-to-end and document it.
- [ ] Optional: drop a thin `<project>.code-workspace` file in each project's root if you want per-project excludes / recommended extensions / `rust-analyzer.linkedProjects`. The workspace file lists only that one folder.
- [ ] Decide on language-server scoping at the *window* level rather than globally — each project's `.vscode/settings.json` or `.code-workspace` pins its own `rust-analyzer.linkedProjects`, exclude globs, etc.
- [ ] Document the "one container, many windows" model in `devx.md` so it's clear the container is infrastructure and the windows are views.
- [ ] Optional convenience: a small shell function (`devopen <project>`) inside the container that resolves the path and calls `code` on it.

### Tradeoffs

- **Pro:** no per-project `.devcontainer/` files. Container config stays centralized in homelab.
- **Pro:** each VS Code window is small — only one project's tree is watched/indexed.
- **Pro:** one warm container shared across all open windows. No rebuild cost when switching projects.
- **Pro:** shared caches (nix store, dotfiles, ssh) are set up exactly once.
- **Con:** discoverability — opening a project from macOS Finder or a fresh `code` invocation won't auto-attach to the running container; you have to spawn windows from *inside* the container (or use "Attach to Running Container" manually).
- **Con:** if the container dies, every window loses its connection at once.
- **Con:** language servers still need per-window pinning to stay lazy. Multi-root inside a single window would defeat the point.

### When this is the right shape

The primary reason to switch from A to B is **divergent per-project toolchains**. Option A's ambient profile install carries one rustc, one cargo, one set of tools. Option B lets each project's `.envrc` activate independently per window — different toolchain versions, different language versions, different env vars, all isolated.

Secondary reasons:
- Indexer/file-watcher cost in a single window becomes painful (large Developer tree).
- You want per-project VS Code settings without polluting a global workspace file.

### When this stops working

Two signals to watch for:
- Projects start needing genuinely different container environments (different base packages, different mounts, different users). At that point a project deserves its own `.devcontainer/` extending the homelab base — a hybrid of A/B and the "shared base image" pattern.
- The "spawn from inside the container" workflow becomes annoying enough (e.g. you frequently open projects from outside VS Code). At that point per-project `.devcontainer/devcontainer.json` files referencing the homelab image make "Reopen in Container" Just Work from any entry point.

---

## Recommendation

Start with **Option A** — the unfinished work is small (drop the duplicate workspace folder, re-enable the Developer mount, hoist the toolchain into the profile, add excludes). It's the lowest-friction shape and good enough until either indexing latency or divergent-toolchain needs force the issue.

**Option B is the same container** — no rebuild, no migration step. Switching is purely a usage pattern: instead of opening one window on `Developer`, you start opening one window per project (from inside the container terminal with `code <path>`). The infrastructure doesn't change; the editor's scope does. The toolchain story does shift though: under B, you remove the Option-A augmentation and the profile shrinks back to base OS packages only. Each project's `.envrc` provides its own toolchain; there is no shared toolchain layer to fall back to.

A and B aren't really separate destinations — B is a discipline you can adopt incrementally once A is in place. The only B-specific work is documenting the spawn-a-window workflow and optionally adding per-project `.code-workspace` files with their own excludes and language-server pins.
