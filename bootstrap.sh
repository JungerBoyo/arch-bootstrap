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
    libxinerama
}

init_config_files() {
    cp .alarcritty.yml .bashrc vimrc .xinitrc $HOME/
    mkdir $HOME/Pictures
    cp WP2-1920-1080.png $HOME/Pictures
    sudo cp config.ini /etc/ly/
}

init_services() {
    sudo systemctl enable acpid.service
    sudo systemctl enable ly.service
    sudo systemctl disable getty@tty2.service
}

init_git_packages() {
    local PREV_DIR = $(pwd)
    
    # enter home
    cd $HOME

    # set up ly display manager
    git clone --recurse-submodules https://github.com/fairyglade/ly
    cd ly
    sudo make install installsystemd

    # set up dwmstatus 
    git clone git://git.suckless.org/dwmstatus
    make -C dwmstatus

    # set up dmenu
    git clone git://git.suckless.org/dmenu
    make -C dmenu 
    
    # set up dwm
    git clone https://github.com/JungerBoyo/dwm.git                 
    make -C dwm
    
    # set up symbolic links for dwmstatus,dmenu,dwm execs
    local LINK_DIR="usr/local/bin"
    local EXECS=(
        "dwmstatus/dwmstatus"
        "dwmstatus/dwmstatus-restart"
        "dwm/dwm"
        "dmenu/dmenu"
        "dmenu/dmenu_path"
        "dmenu/dmenu_run"
        "dmenu/dmenu_stest"
    )
    for e in EXECS 
        do
            sudo ln -s $(HOME)/${e} ${LINK_DIR}/$(basename $e)
        done 

    cd $PREV_DIR
}

init_packages
init_git_packages
init_services
init_config_files
