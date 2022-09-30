# Ubuntu WorrkSpaces

This is a collection of scripts to automate the setup of Ubuntu Amazon WorkSpaces.

## FixWorkSpace.sh
This is a quick setup script to add usability tools and add common Linux desktop functionality.

### Added Applications
- gnome-shell-extension-manager 
    - Enables modification Gnome Shell extensions added by Ubuntu
    - Allows for searching of available extensions wihtout needing a browser
- gnome-tweaks
    - Additional settings for common items in Gnome
- ubuntu-restricted-extras
    - Additional codecs and fonts
- vim
    - replace included with more functional version
- zsh
    - ZSH shell for users that prefer. This is not set defulat, only installed.

### Added Functionality
- Docker
    - Installs Docker-ce repo
    - Installs engine 
    - Adds cli and other container tools
- Flatpak
    - Adds support for Flatpak
    - Adds Flatpak repo (flathub)
    - Adds Gnome hooks for Flatpak
- Adsys
    - Adds functionality for group policy
- libfuse2
    - Adds support for appimage packages

### Other
- Firefox
    - Removes snap version
    - Adds Firefox repo
    - Adjusts priority to ensure deb used going forward
    - This allows gnome extension management from the browser
    - This ensures downloads go to ~/Downloads

- Nautalus
    - Modifies location bar behavior to allow users to type the path