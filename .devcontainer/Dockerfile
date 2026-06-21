FROM debian:trixie-slim

# Remove slim exclusions so man pages work
RUN rm -f /etc/dpkg/dpkg.cfg.d/docker-clean \
    && rm -f /etc/dpkg/dpkg.cfg.d/excludes

# Core utilities
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    bash \
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

# Install only the locale we care about
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen

# Install custom shell environment
RUN apt-get update && apt-get install -y \
    zsh \
    fzf \
    starship \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*

# Source Nix environment for all zsh shells. `/etc/profile.d/` works automatically for bash sessions
# This must happen after installing zsh so the /etc/zsh directory has been created properly
# For multi-user: /etc/profile.d/nix.sh
# For single-user:
ENV NIX_PROFILE_SH="/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
RUN echo 'source /nix/var/nix/profiles/default/etc/profile.d/nix.sh' >> /etc/zsh/zshenv

# Configure nix for features and remote builders
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes\n\
builders-use-substitutes = true\n\
builders = ssh://eu.nixbuild.net x86_64-linux,aarch64-linux - 100 1 big-parallel,benchmark,kvm - -" > /etc/nix/nix.conf

# Configure remote builders SSH
RUN echo "Host eu.nixbuild.net\n\
    StrictHostKeyChecking accept-new\n\
    IdentityFile ~/.ssh/id_ed25519" >> /etc/ssh/ssh_config

# Install the entrypoint script to handle provisioning of mounted `/nix` volume
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT /usr/local/bin/entrypoint.sh

# Entry with zsh
RUN chsh -s /bin/zsh