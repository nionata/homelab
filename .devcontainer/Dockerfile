FROM debian:trixie-slim

# Remove slim exclusions so man pages work
RUN rm -f /etc/dpkg/dpkg.cfg.d/docker-clean \
    && rm -f /etc/dpkg/dpkg.cfg.d/excludes

# Boot strap the nix install
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \ 
    && rm -rf /var/lib/apt/lists/*

# Install Nix in daemon mode
RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes

# Install only the locale we want
RUN apt-get update && apt-get install -y \
    locales \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen

# Minimal package install for vscode extensions
RUN apt-get update && apt-get install -y \
    openssh-client \
    git \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*

# Source Nix environment for all zsh shells. `/etc/profile.d/` works automatically for bash sessions
# This must happen after installing zsh so the /etc/zsh directory has been created properly
# For multi-user: /etc/profile.d/nix.sh
# For single-user: ~/.nix-profile/profiles/default/etc/profile.d/nix.sh
# ENV NIX_PROFILE_SH="/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
# RUN mkdir -p /etc/zsh && echo 'source /nix/var/nix/profiles/default/etc/profile.d/nix.sh' >> /etc/zsh/zshenv

# Configure nix features
RUN mkdir -p /etc/nix && printf '%s\n' \
    'experimental-features = nix-command flakes' \
    'builders-use-substitutes = true' \
    'builders = @/etc/nix/machines' \
    > /etc/nix/nix.conf
# Configure remote builders
RUN printf '%s\n' \
    'eu.nixbuild.net x86_64-linux - 100 1 big-parallel,benchmark' \
    'eu.nixbuild.net aarch64-linux - 100 1 big-parallel,benchmark' \
    > /etc/nix/machines
# Configure remote builders SSH
RUN mkdir -p /etc/ssh && echo "Host eu.nixbuild.net\n\
    PubkeyAcceptedKeyTypes ssh-ed25519\n\
    ServerAliveInterval 60\n\
    IPQoS throughput\n\
    IdentityFile /root/.ssh/id_ed25519" >> /etc/ssh/ssh_config
# Configure remote builders known host
RUN echo "eu.nixbuild.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM" >> /etc/ssh/ssh_known_hosts

# No CMD here as dev container handles this by default to keep the container alive
