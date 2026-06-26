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

# TODO: move this to the profile pkgs
# Install only the locale we want
RUN apt-get update && apt-get install -y \
    locales \
    # Remove apt package index cache after install - not needed at runtime and keeps image smaller
    && rm -rf /var/lib/apt/lists/*
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen

# TODO: move all of these config files into their own files

# Configure nix features

# TODO: add these. right now they're in the container's home nix.conf

# experimental-features = nix-command flakes auto-allocate-uids cgroups
# auto-allocate-uids = true
# extra-system-features = uid-range
# sandbox = true

RUN mkdir -p /etc/nix && printf '%s\n' \
    'experimental-features = nix-command flakes auto-allocate-uids cgroups' \
    'auto-allocate-uids = true' \
    'extra-system-features = uid-range' \
    'sandbox = true' \
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

# Install packages into the profile via nix so the base image has a solid dev environment
# The packages here will satisfy the installed vscode extensions
COPY . /tmp/repo/
RUN bash -l -c "nix shell nixpkgs#git --builders '' -c \
    nix profile install \
    --profile /nix/var/nix/profiles/devcontainer \
    '/tmp/repo/.devcontainer/profile' \
    --builders ''"
RUN rm -rf /tmp/repo

# TODO: do we really need this? shouldn't something else be doing this for us?
ENV PATH="/nix/var/nix/profiles/devcontainer/bin:/nix/var/nix/profiles/default/bin:$PATH"

# Source Nix environment for all zsh shells. `/etc/profile.d/` works automatically for bash sessions
# Add direnv so we activate the current folder when entering
RUN mkdir -p /etc/zsh && \
    echo '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >> /etc/zsh/zshenv && \
    echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshenv

# Set ZSH as the default shell
RUN ZSH_PATH="/nix/var/nix/profiles/devcontainer/bin/zsh" && \
    echo "$ZSH_PATH" >> /etc/shells && \
    chsh -s "$ZSH_PATH"

# Route all direnv layout caches to the isolated container cache instead of the host-mounted workspace
RUN mkdir -p /root/.config/direnv && \
    echo 'strict_env_string' > /root/.config/direnv/direnvrc && \
    echo 'direnv_layout_dir() { echo "$HOME/.cache/direnv/layouts/$(echo -n "$PWD" | sha1sum | cut -d " " -f 1)"; }' >> /root/.config/direnv/direnvrc

# Run the nix daemon in the container indefinitely
CMD ["/nix/var/nix/profiles/default/bin/nix-daemon"]