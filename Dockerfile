ARG BASE_IMG=rust:slim
FROM ${BASE_IMG}

LABEL MAINTAINER="rustsbi"

ARG DESKTOP_MACHINE=no
ARG TEMP_DIR=/tmp
ARG QEMU_VER=7.1.0
ARG QEMU_TARGET=riscv64-softmmu

ARG SCRIPT=qemu.sh

COPY scripts /tmp/

RUN /bin/bash "tmp/${SCRIPT}" \
    && apt clean autoclean \
    && apt autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/*