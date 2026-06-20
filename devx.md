# Developer Environment Strategy: The "Zero-Compromise" Rust Dev Container

This development architecture bridges the gap between local macOS file convenience and isolated, bare-metal speed on Apple Silicon.

---

## 1. The Ergonomics: Bounded Host Synchronization
* **The Setup:** The project source code (`.rs` files, `Cargo.toml`) lives directly on the Mac's native APFS filesystem and is shared with the Linux container via a highly optimized bind mount.
* **The Benefit:** The Dev Container feels invisible. You can use native macOS IDEs, leverage local Git credentials, and browse your project directory in Finder just like any normal folder on your machine.

---

## 2. The Muscle: Hardware-Accelerated Virtualization
* **The Setup:** OrbStack leverages Apple’s native `Virtualization.framework` to spin up a lightweight Linux kernel directly on the M-series CPU.
* **The Benefit:** Because the host machine and the container are both ARM64 architectures, source code compilation runs via **native CPU virtualization**, completely bypassing slower emulators like QEMU. Hardware-level extensions execute ARM64 Linux instructions directly on the silicon.

---

## 3. The Secret Sauce: I/O Offloading via Docker Volumes
* **The Setup:** While source code is shared across the OS boundary, high-frequency, heavy-I/O directories—specifically the Rust compiler's `target/` directory and the `.cargo` dependency cache—are isolated inside **native Linux Docker volumes**.
* **The Benefit:** This bypasses the expensive macOS-to-Linux filesystem translation layer (`VirtioFS`) where it hurts most. When Cargo performs thousands of rapid file reads and writes during a build, it executes them at near-native speeds inside an isolated Linux storage pool (`ext4`/`xfs`), eliminating the classic "Mac Docker disk bottleneck."

---

## Architectural Data Flow

```text
   [ macOS Host ]                    [ Linux VM (OrbStack) ]
 ──────────────────                ───────────────────────────
  Source Code  ────────(Bind Mount)──────► /workspace (Low I/O)
                                                │
                                    (Isolated Volume Mount)
                                                ▼
                                           /target (High I/O)
