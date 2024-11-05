# Dockerfile

# Use the Debian slim image as the base
FROM debian:stable-slim

# Set environment variable for terminal
ENV TERM xterm-256color

# Set working directory
WORKDIR /root

# Install required packages
RUN apt update
RUN apt install -y git gcc make unzip ripgrep curl build-essential

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN sleep 3
RUN bash -c 'export NVM_DIR="${XDG_CONFIG_HOME:-${HOME}/.nvm}" && \
    mkdir -p "$NVM_DIR" && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install --lts'
    
# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . "$HOME/.cargo/env"
    
# Install Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN tar -C /opt -xzf nvim-linux64.tar.gz
RUN rm nvim-linux64.tar.gz
RUN ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

# Clone Neovim config
RUN git clone https://github.com/Gabones/nvim_config.git ~/.config/nvim

SHELL ["/bin/bash", "-i", "-c"]

ENTRYPOINT ["/bin/bash", "-i"]
