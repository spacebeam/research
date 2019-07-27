#!/bin/bash

echo "spacebeam" > /etc/hostname

apt update

apt install --install-recommends \
    libsctp1\
    tcpdump\
    sngrep\
    libnotify-bin\
    git\
    g++\
    libgtk-3-dev\
    gtk-doc-tools\
    gnutls-bin\
    valac\
    intltool\
    libpcre2-dev\
    libglib3.0-cil-dev\
    libgnutls28-dev\
    libgirepository1.0-dev\
    libxml2-utils\
    wget\
    mksh\
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
    vifm\
    calcurse\
    pv\
    network-manager-gnome\
    network-manager-openvpn-gnome\
    network-manager-pptp-gnome\
    network-manager-vpnc-gnome\
    i3lock\
    compton\
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
    xdg-utils\
    lxrandr\
    sxiv\
    build-essential\
    gnome-calculator\
    gpicview\
    xarchiver\
    audacity\
    git\
    gnome-themes-standard\
    fonts-lyx\
    python3-apt\
    python3-dev\
    python3-pip\
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
    pcmanfm\
    transmission\
    jq\
    screenkey\
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
    pandoc\
    pandoc-citeproc\
    texlive-full\
    gfortran\
    albatross-gtk-theme\
    bc\
    blackbird-gtk-theme\
    bluebird-gtk-theme\
    cron\
    exim4\
    exim4-base\
    exim4-config\
    exim4-daemon-light\
    gir1.2-atk-1.0\
    gir1.2-freedesktop\
    gir1.2-gdkpixbuf-2.0\
    gir1.2-gtk-3.0\
    gir1.2-pango-1.0\
    greybird-gtk-theme\
    gtk2-engines-murrine\
    guile-2.0-libs\
    libgdk-pixbuf2.0-dev\
    libgsasl7\
    libkyotocabinet16v5\
    libmailutils5\
    libntlm0\
    libpangoxft-1.0-0\
    librsvg2-bin\
    libsass0\
    libxml2-utils\
    mailutils\
    mailutils-common\
    murrine-themes\
    optipng\
    parallel\
    python3-pil\
    sassc\
    sysstat\
 -y

apt clean

apt remove yelp -y

apt autoremove -y

pip3 install riak queries py3status jupyter pywal

#wget https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_21.2-1~debian~stretch_amd64.deb

#dpkg -i esl-erlang_21.2-1~debian~stretch_amd64.deb

#rm esl-erlang_21.2-1~debian~stretch_amd64.deb

#git clone https://github.com/torch/distro.git /opt/torch --recursive

#bash /opt/torch/install-deps

#cd /opt/torch/

#./install.sh

cd /usr/src/

wget https://github.com/themix-project/oomox/releases/download/1.11/oomox_1.11-3-gde075379_18.10+.deb

dpkg -i oomox_1.11-3-gde075379_18.10+.deb
