#!/bin/bash

set -exuo pipefail

# tmp space for building
: "${TEMP_DIR:=/tmp}"

mkdir -p "$TEMP_DIR"

apt update -q
apt install -y --no-install-recommends \
    wget \
    ca-certificates \
    build-essential \
    libglib2.0-dev \
    libfdt-dev \
    libpixman-1-dev \
    zlib1g-dev \
    ninja-build \
    python3 \
    python3-venv
# end of list

# qemu version
: "${QEMU_VER:=7.1.0}"
: "${QEMU_TARGET:=riscv64-softmmu}"

# Enable venv
python3 -m venv .env
source .env/bin/activate

# Get qemu
wget https://download.qemu.org/qemu-$QEMU_VER.tar.xz -O "$TEMP_DIR/qemu-$QEMU_VER.tar.xz"
tar -xJf "$TEMP_DIR/qemu-$QEMU_VER.tar.xz"
cd qemu-$QEMU_VER
./configure --target-list=$QEMU_TARGET
make -j$(nproc)
make install
cd ..

rm $TEMP_DIR/qemu-$QEMU_VER.tar.xz
rm -rf qemu-$QEMU_VER
