

# RustKernel

## Getting Started

Follow these steps to build and run the RustKernel project. Ensure that you have Rust installed on your system. If not, you can install it from [rustup.rs](https://rustup.rs/).

### Prerequisites

Make sure you have Rust nightly installed:

```bash
rustup override set nightly
```

### Building the Project

To build the project, run:

```bash
cargo build
```

### Creating a Bootable Disk Image

To create a bootable disk image, use the following command:

```bash
cargo bootimage
```

### Installing QEMU

If you don't have QEMU installed, you can install it using Homebrew:

```bash
brew install qemu
```

### Running the Disk Image on QEMU

Finally, to run the disk image on QEMU, use the command:

```bash
qemu-system-x86_64 -drive format=raw,file=target/x86_64-RustKernel/debug/bootimage-RustKernel.bin
```

add the command to run the kernel

---
