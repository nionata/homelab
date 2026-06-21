#!/bin/zsh
set -e

NIX_PROFILE_PATH="$HOME/.nix-profile/etc/profile.d/nix.sh"

if [ ! -d "/nix/store" ]; then
    echo "⚙️ /nix volume is a blank slate. Bootstrapping Nix..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon --unattended
    
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    
    # Bring nix profile into path enough to install nixos-rebuild
    $NIX_PROFILE_PATH nix profile install nixpkgs#nixos-rebuild
else
    echo "✔ /nix volume already populated."
fi

# No global sourcing here. Defer to image adding it to zshenv.
# Non-zsh shells won't have nix env, which is likely fine.
exec "$@"


#!/bin/zsh
set -e

# ---------------------------------------------------------
# PHASE 1: CORE DATA STATE CHECK
# ---------------------------------------------------------
if [ ! -d "/nix/store" ]; then
    echo "⚙️ /nix volume is empty. Bootstrapping Nix database..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon --unattended
else
    echo "✔ /nix persistent volume detected."
fi

# We source the profile here so the current script process knows where 'nix' lives
[ -f "$NIX_PROFILE_SH" ] && . "$NIX_PROFILE_SH"

# ---------------------------------------------------------
# PHASE 2: REQUIRED TOOLING CHECK (Idempotent)
# ---------------------------------------------------------
# We use 'command -v' to check if the binary is actually available in our path.
# This works whether the volume is brand new OR migrating from an older version.
if ! command -v nixos-rebuild > /dev/null 2>&1; then
    echo "⚙️ Installing missing deployment tool: nixos-rebuild..."
    nix profile install nixpkgs#nixos-rebuild
else
    echo "✔ nixos-rebuild is already installed."
fi

exec "$@"