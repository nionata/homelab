
| Component | Single-User Installation | Multi-User Installation |
| :--- | :--- | :--- |
| **Global Store** | `/nix/store` *(Owned by your user)* | `/nix/store` *(Owned by `root`)* |
| **Main Config** | `~/.config/nix/nix.conf` | `/etc/nix/nix.conf` |
| **Active User Profile** | `~/.nix-profile` | `~/.nix-profile` *(Points to `/nix/var/nix/profiles/per-user/`)* |
| **Profile Storage** | `~/.local/state/nix/profiles/` | `/nix/var/nix/profiles/per-user/<username>/` |
| **Daemon Socket** | *None (Nix runs directly)* | `/nix/var/nix/daemon-socket/socket` |
| **Shell Setup Script** | `~/.nix-profile/etc/profile.d/nix.sh` | `/etc/profile.d/nix.sh` *(System-wide)* |
