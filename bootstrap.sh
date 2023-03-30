#!/bin/sh

init_packages() {
    sudo pacman -S acpi\
    acpi\
    acpid\
    alacritty\
    alsa-utils\
    autoconf\
    automake\
    debugedit\
    fakeroot\
    firefox\
    feh\
    flex\
    graphicsmagick\
    grub\
    htop\
    make\
    man-db\
    neofetch\
    patch\
    pkgconf\
    ranger\
    texinfo\
    ttf-jetbrains-mono\
    xclip\
    xorg-server\
    xorg-xinit\
    libxft\
    libxinerama\
    zig
}

init_config_files() {
    sudo cp vimrc /etc/
    cp .alacritty.yml .bashrc .xinitrc $HOME/
    mkdir $HOME/Pictures
    cp WP2-1920x1080.png $HOME/Pictures
    sudo cp config.ini /etc/ly/
}

init_services() {
    sudo systemctl enable acpid.service
    sudo systemctl enable ly.service
    sudo systemctl disable getty@tty2.service
}

init_git_packages() {
    local PREV_DIR=$(pwd)
    
    # enter home
    cd $HOME

    # set up ly display manager
    git clone --recurse-submodules https://github.com/fairyglade/ly
    sudo make install installsystemd -C ly

    # set up dwmstatus 
    git clone git://git.suckless.org/dwmstatus
    make -C dwmstatus

    # set up zi-status        
    git clone https://github.com/JungerBoyo/zi-status.git
    cd zi-status/
    zig build -Drelease-fast=true
    cd ../

    # set up dmenu
    git clone git://git.suckless.org/dmenu
    make -C dmenu 
    
    # set up dwm
    git clone https://github.com/JungerBoyo/dwm.git                 
    make -C dwm
    
    # set up symbolic links for dwmstatus,dmenu,dwm execs
    local LINK_DIR="/usr/local/bin"
    local EXECS=(
        "zi-status/zig-out/bin/zi-status"
        "dwm/dwm"
        "dmenu/dmenu"
        "dmenu/dmenu_path"
        "dmenu/dmenu_run"
        "dmenu/stest"
    )
    for e in "${EXECS[@]}"
        do
            sudo ln -s ${HOME}/${e} ${LINK_DIR}/$(basename $e)
        done 

    cd $PREV_DIR
}

init_packages
init_git_packages
init_services
init_config_files
