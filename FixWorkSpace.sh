#!/usr/bin/env bash

# Ensure script running elevated

# Temp fix for wks/gnome escilation bug
mv /etc/polkit-1/localauthority.conf.d/01-ws-admin-user.conf /etc/polkit-1/localauthority.conf.d/zz-ws-admin-user.conf

# Update
apt update -y && apt upgrade -y

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

packagelist=(
# Gnome
gnome-shell-extension-manager 
gnome-tweaks

#Flatpak
flatpak 
gnome-software-plugin-flatpak

#Utils
vim
#adsys needs sssd
)

apt install -y ${packagelist[@]}

# Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
