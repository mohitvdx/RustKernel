# Use debian as base for better cross-platform support
FROM --platform=linux/amd64 debian:bullseye AS builder

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install necessary packages in one command to reduce layers
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        ca-certificates \
        qemu-system-x86 \
        xorriso \
        grub2 \
        python3 \
        git \
        pkg-config \
        libssl-dev \
        cmake \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set up nightly toolchain and required components
RUN rustup default nightly && \
    rustup component add rust-src llvm-tools-preview && \
    cargo install bootimage

# Create working directory
WORKDIR /rust_kernel

# Copy project files
COPY . .

# Build the kernel
RUN cargo build

# Create runtime image
FROM --platform=linux/amd64 debian:bullseye-slim

# Install only necessary runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        qemu-system-x86 \
    && rm -rf /var/lib/apt/lists/*

# Copy the built kernel from builder
COPY --from=builder /rust_kernel/target/x86_64-RustKernel/debug/bootimage-RustKernel.bin /kernel/

# Create run script
RUN echo '#!/bin/bash\n\
qemu-system-x86_64 -drive format=raw,file=/kernel/bootimage-RustKernel.bin -nographic' > /run.sh && \
chmod +x /run.sh

WORKDIR /kernel

ENTRYPOINT ["/run.sh"]
CMD []