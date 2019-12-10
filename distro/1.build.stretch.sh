#!/bin/bash

echo export LC_ALL="en_US.UTF-8"
echo export LANG="en_US.UTF-8"
echo export LANGUAGE="en_US.UTF-8"

apt update

apt install --install-recommends \
    apt-transport-https\
    debootstrap\
    gnupg2\
    software-properties-common\
    curl\
    libyaml-0-2\
    libyaml-dev\
    libsdl2-ttf-dev\
    libssl-dev\
    zlib1g-dev\
    libncurses5-dev\
    libgdbm-dev\
    libnss3-dev\
    libssl-dev\
    libreadline-dev\
    libffi-dev\
    uuid-dev\
    libgpgme11-dev\
    libseccomp-dev\
    pkg-config\
    squashfs-tools\
    cryptsetup\
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
    libtool\
    libpcre2-dev\
    libgnutls28-dev\
    libgirepository1.0-dev\
    libxml2-utils\
    gperf\
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
    build-essential\
    gnome-calculator\
    gpicview\
    xarchiver\
    audacity\
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
    sudo\
    make\
    cmake\
    libncurses5-dev\
    protobuf-compiler\
    libsdl2-dev\
    libsdl2-image-dev\
    libasound2-dev\
    libpulse-dev\
    automake\
    gfortran\
    bc\
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

apt install --install-recommends\
    libglib3.0-cil-dev\
    libtool\
 -y

git clone --recursive https://github.com/thestinger/termite.git
git clone https://github.com/thestinger/vte-ng.git

echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
cd vte-ng && ./autogen.sh && make && sudo make install
cd ../termite && make && sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x; sudo ln -s \
/usr/local/share/terminfo/x/xterm-termite \
/lib/terminfo/x/xterm-termite

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60


# MISSING SINGULARITY AND FUCKING GO!


dpkg --add-architecture i386

wget -nc https://dl.winehq.org/wine-builds/winehq.key

apt-key add winehq.key

apt-add-repository 'deb https://dl.winehq.org/wine-builds/debian/ stretch main'

apt update && rm winehq.key

apt install --install-recommends\
    libgnutls30:i386\
    libldap-2.4-2:i386\
    libgpg-error0:i386\
    libxml2:i386\
    libasound2-plugins:i386\
    libsdl2-2.0-0:i386\
    libfreetype6:i386\
    libdbus-1-3:i386\
    libsqlite3-0:i386\
    libgl1-mesa-glx:i386\
    libgl1-mesa-dri:i386\
    mesa-vulkan-drivers\
    xvfb\
    winehq-staging\
 -y

pip3 install riak queries py3status jupyter pywal ueberzug

chsh -s /bin/mksh

rm /root/.mkshrc

cp extra/mkshrc /root/.mkshrc

wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_22.1.8-1~debian~stretch_amd64.deb

dpkg -i esl-erlang_22.1.8-1~debian~stretch_amd64.deb && rm esl-erlang_22.1.8-1~debian~stretch_amd64.deb

git clone https://github.com/torch/distro.git /opt/torch --recursive

bash /opt/torch/install-deps

cd /opt/torch/

./install.sh
