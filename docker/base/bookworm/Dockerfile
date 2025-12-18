# Base developer-friendly image (Debian bookworm-slim)
FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="DevRunner Base" \
      org.opencontainers.image.source="https://github.com/chaitin/DevRunner" \
      org.opencontainers.image.description="Base toolbox image for DevRunner stacks"

ARG DEBIAN_FRONTEND=noninteractive

# Switch to Tsinghua University's mirror to improve package availability in China
RUN cat >/etc/apt/sources.list <<'EOF'
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware

# 以下安全更新软件源使用 Tsinghua 镜像
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        locales \
        curl \
        git \
        gnupg \
        build-essential \
        pkg-config \
        unzip \
        zip \
        less \
        vim-tiny \
        procps \
        python3 \
        python3-pip \
    && ln -sf /usr/bin/vim.tiny /usr/bin/vim \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    PATH=/root/.local/bin:${PATH} \
    WORKSPACE=/workspace

WORKDIR /workspace
