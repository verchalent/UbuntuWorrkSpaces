#!/usr/bin/env bash

# Ensure script running elevated
if [ $(id -u) -ne 0 ]
  then echo "This script must be run with elevated rights"
  exit
fi

export NEEDRESTART_MODE=a
export DEBIAN_FRONTEND=noninteractive
# Fix for kde escilation bug - just in case
echo '
[super-user-command]
super-user-command=su'|tee /etc/xdg/kdesurc

# Switch to Apt for Firefox
# - Allows Gnome Extension install to work again
# - Enables default Downloads folder instead of nested snap one
snap remove --purge firefox
add-apt-repository -y ppa:mozillateam/ppa
apt remove -y firefox
apt install -y --target-release 'o=LP-PPA-mozillateam' firefox

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | tee /etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# Add Docker CE repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update
apt update -y && apt upgrade -y

packagelist=(
    # Gnome Tools
    gnome-shell-extension-manager 
    gnome-tweaks
    # Flatpak Support
    flatpak 
    gnome-software-plugin-flatpak
    # Appimage support
    libfuse2
    # Useful Utils
    vim
    zsh
    adsys
    # Codecs and Fonts
    ubuntu-restricted-extras
    # Docker Support
    docker-ce 
    docker-ce-cli 
    containerd.io
)

DEBIAN_FRONTEND=noninteractive apt install -y ${packagelist[@]}

# Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Gnome
# Switch to Location bar. Allows user edit/input in path
dconf write /org/gnome/nautilus/preferences/always-use-location-entry true

# Cleanup
apt autoremove -y
