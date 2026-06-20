FROM debian:trixie-slim

# Remove slim exclusions so man pages work
RUN rm -f /etc/dpkg/dpkg.cfg.d/docker-clean \
    && rm -f /etc/dpkg/dpkg.cfg.d/excludes

# Bootstrap: minimum to install Nix
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    bash \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*

# Install Nix in multi-user (daemon) mode for consistent behavior with standard Nix installations
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon
# Enable the latest and greatest from nix
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Core utilities
RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    man-db \
    less \
    vim \
    wget \
    unzip \
    ca-certificates \
    procps \
    lsof \
    net-tools \
    iputils-ping \
    locales \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*

RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen

# Shell
RUN apt-get update && apt-get install -y \
    zsh \
    fzf \
    starship \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*

# Source Nix environment for all zsh shells. `/etc/profile.d/` works automatically for bash sessions
# This must happen after installing zsh so the /etc/zsh directory has been created properly
RUN echo 'source /etc/profile.d/nix.sh' >> /etc/zsh/zshenv

RUN chsh -s /bin/zsh