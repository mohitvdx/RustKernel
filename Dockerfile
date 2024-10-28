# Use Ubuntu as base image for better QEMU support
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages and clean up
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    qemu-system-x86 \
    python3 \
    git \
    xauth \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Rust and clean up
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH="/root/.cargo/bin:${PATH}"

# Set to nightly Rust
RUN rustup default nightly && \
    rustup component add rust-src && \
    rustup component add llvm-tools-preview && \  
    cargo install bootimage

# Create working directory
WORKDIR /rust-kernel

# Copy project files
COPY . .

# Install any project-specific dependencies
RUN cargo build

# Expose QEMU ports
# VGA display
EXPOSE 5900
# Monitor
EXPOSE 55555
# GDB
EXPOSE 1234

# Create a script to run QEMU with proper display forwarding
RUN echo '#!/bin/bash\n\
cargo bootimage && \
qemu-system-x86_64 \
    -drive format=raw,file=target/x86_64-RustKernel/debug/bootimage-RustKernel.bin \
    -display vnc=:0 \
    -monitor tcp:0.0.0.0:55555,server,nowait \
    -gdb tcp:0.0.0.0:1234 \
    "$@"' > /usr/local/bin/run-kernel && \
    chmod +x /usr/local/bin/run-kernel

# Set the default command
CMD ["run-kernel"]