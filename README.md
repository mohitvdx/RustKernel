To Run, up to latest [commit](https://github.com/mohitvdx/RustKernel/commits/master/), run the following commands:

Note: assuming you have rust installed, if not, install it from https://rustup.rs/

make sure you have rust nightly installed:
```rustup override set nightly```

to build the project:
```cargo build```

to make a bootable disk image:
```cargo bootimage```

to install qemu:
```brew install qemu```

to run the disk image on qemu:
```qemu-system-x86_64 -drive format=raw,file=target/x86_64-RustKernel/debug/bootimage-RustKernel.bin```