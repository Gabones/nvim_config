# Dockerfile

# Use the Debian slim image as the base
FROM debian:stable-slim

# Set environment variable for terminal
ENV TERM xterm-256color

# Set working directory
WORKDIR /root

# Install required packages
RUN apt update && \
    apt install -y git gcc make unzip ripgrep curl build-essential nodejs npm && \
    \
    # Install Rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . "$HOME/.cargo/env" && \
    \
    # Install Neovim
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
    tar -C /opt -xzf nvim-linux64.tar.gz && \
    rm nvim-linux64.tar.gz && \
    ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim && \
    \
    # Clone Neovim config
    git clone https://github.com/Gabones/nvim_config.git ~/.config/nvim


# Define entrypoint
ENTRYPOINT ["/bin/sh"]
