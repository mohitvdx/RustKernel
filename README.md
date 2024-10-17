
---

# RustKernel

## Getting Started

Follow these steps to build and run the RustKernel project. Ensure that you have Rust installed on your system. If not, you can install it from [rustup.rs](https://rustup.rs/).

### Prerequisites

Make sure you have the nightly version of Rust installed:

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

To run the disk image on QEMU, use the command:

```bash
qemu-system-x86_64 -drive format=raw,file=target/x86_64-RustKernel/debug/bootimage-RustKernel.bin
```

### Running Tests

To run all the tests, use the command:

```bash
cargo test
```

### Running the OS

To run the operating system in QEMU, use the command:

```bash
cargo run
```

---

## References

- [The Rust Programming Language](https://doc.rust-lang.org/book/)
- [Operating System Concepts (10th Edition, 2018)](https://os.ecci.ucr.ac.cr/slides/Abraham-Silberschatz-Operating-System-Concepts-10th-2018.pdf)
- [OSDev: Writing an Operating System in Rust](https://os.phil-opp.com)
- [Learn About Operating Systems in Depth](https://www.freecodecamp.org/news/learn-about-operating-systems-in-depth/)
- [Multitasking Operating System - JavaTpoint](https://www.javatpoint.com/multitasking-operating-system)

---
