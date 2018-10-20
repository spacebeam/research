#!/bin/bash

echo "capuchino" > /etc/hostname

#sed -i 's/$/ universe/' /etc/apt/sources.list

#sed -i 's/$/ contrib/' /etc/apt/sources.list

apt update

apt install --install-recommends \
    tcpdump\
    wget\
    openssh-client\
    openssh-server\
    xserver-xorg-core\
    xserver-xorg\
    xinit\
    pciutils\
    usbutils\
    ntfs-3g\
    hfsprogs\
    dosfstools\
    pv\
    network-manager-gnome\
    network-manager-openvpn-gnome\
    network-manager-pptp-gnome\
    network-manager-vpnc-gnome\
    i3lock\
    compton\
    geany\
    htop\
    urlview\
    mupdf\
    e2fsprogs\
    xfsprogs\
    feh\
    cmus\
    pavucontrol\
    vlc\
    jfsutils\
    ntfs-3g\
    fuse\
    gvfs\
    gvfs-fuse\
    fusesmb\
    libnss-mdns\
    gvfs-bin\
    gvfs-backends\
    dconf-service\
    dconf-cli\
    dconf-editor\
    gksu\
    xdg-utils\
    lxrandr\
    build-essential\
    gnome-calculator\
    gpicview\
    xarchiver\
    audacity\
    git\
    gnome-themes-standard\
    thunderbird\
    calendar-google-provider\
    fonts-lyx\
    python3-apt\
    python3-dev\
    python3-pip\
    zsh\
    lxappearance\
    mpv\
    python-wxgtk3.0\
    python3-venv\
    linux-image-amd64\
    live-boot\
    systemd-sysv\
    curl\
    vim\
    less\
    tmux\
    i3\
    lightdm\
    ranger\
    pcmanfm\
    transmission\
    chromium\
    rxvt-unicode-256color\
    jq\
    uuid-dev\
    uuid\
    odbcinst\
    unixodbc\
    unixodbc-dev\
    make\
    cmake\
    libncurses5-dev\
    protobuf-compiler\
    libsdl2-dev\
    libsdl2-image-dev\
    pelican\
    libasound2-dev\
    libpulse-dev\
    automake\
    libtool\
    inkscape\
    evince\
    pandoc\
    gfortran\
    luajit\
 -y

apt clean

apt remove yelp -y

apt autoremove -y
