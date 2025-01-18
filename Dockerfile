
# https://moebuta.org/posts/using-github-actions-to-build-linux-kernels/?utm_source=chatgpt.com
# ATTRIBUTION-AI: ChatGPT  4o , o1  2025-01-18 .

FROM debian:bookworm

# Build arguments to set UID and GID at build time:
# e.g. docker build --build-arg HOST_UID=$(id -u) --build-arg HOST_GID=$(id -g) -t my_image:latest .
ARG HOST_UID=1000
ARG HOST_GID=1000
ARG USERNAME=containeruser

# Create a matching group and user, and a corresponding home directory
RUN groupadd --gid $HOST_GID $USERNAME && \
    useradd --uid $HOST_UID --gid $HOST_GID --create-home --shell /bin/bash $USERNAME

# Set this user as default
USER $USERNAME

# Set HOME explicitly (usually set automatically, but good for clarity)
ENV HOME=/home/$USERNAME

RUN mkdir -p /home/$USERNAME
RUN chown $USERNAME:$USERNAME /home/$USERNAME



COPY <<"EOF" /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main
deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian-security/ bookworm-security main
deb-src http://deb.debian.org/debian-security/ bookworm-security main

deb http://deb.debian.org/debian bookworm-updates main
deb-src http://deb.debian.org/debian bookworm-updates main
EOF



RUN <<"EOF"
sudo -n apt-get update
sudo -n apt-get install build-essential wget git -y
sudo -n apt-get build-dep linux -y

##xz btrfs-tools grub-mkstandalone mkfs.vfat mkswap mmd mcopy mksquashfs

#gpg pigz curl gdisk lz4 mawk jq gawk build-essential autoconf pkg-config bsdutils findutils patch tar gzip bzip2 sed lua-lpeg axel aria2 gh rsync pv expect libfuse2 udftools debootstrap cifs-utils dos2unix xxd debhelper p7zip nsis jp2a btrfs-progs btrfs-compsize zstd zlib1g coreutils util-linux kpartx openssl growisofs udev gdisk parted bc e2fsprogs xz-utils libreadline8 mkisofs genisoimage byobu xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils

##dnsutils bind9-dnsutils bison libelf-dev elfutils flex libncurses-dev libudev-dev dwarves pahole cmake sockstat liblinear4 liblua5.3-0 nmap nmap-common socat dwarves pahole libssl-dev cpio libgtk2.0-0 libwxgtk3.0-gtk3-0v5 wipe iputils-ping nilfs-tools python3 sg3-utils cryptsetup php
##qemu-system-x86
##qemu-user qemu-utils

sudo -n apt-get install -y sudo gpg wget pigz dnsutils bind9-dnsutils curl gdisk parted lz4 mawk jq gawk build-essential bison libelf-dev elfutils flex libncurses-dev autoconf libudev-dev dwarves pahole cmake pkg-config bsdutils findutils patch tar gzip bzip2 flex sed sockstat liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common socat axel aria2 gh rsync libssl-dev cpio pv expect libfuse2 cifs-utils dos2unix xxd debhelper p7zip iputils-ping btrfs-progs btrfs-compsize zstd zlib1g nilfs-tools coreutils python3 util-linux kpartx openssl udev cryptsetup bc e2fsprogs xz-utils libreadline8 byobu squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils trousers tpm-tools

sudo -n apt-get install -y rustc cargo
EOF


RUN <<"EOF"

cd /
sudo -n wget https://raw.githubusercontent.com/mirage335-colossus/ubiquitous_bash/master/ubiquitous_bash.sh
sudo -n chmod 755 /ubiquitous_bash.sh
/ubiquitous_bash.sh _setupUbiquitous.bat
sudo -n /ubiquitous_bash.sh _setupUbiquitous.bat
sudo -n /ubiquitous_bash.sh _custom_splice_opensslConfig
EOF

WORKDIR /currentPWD

#COPY . /app


#ENTRYPOINT ["/usr/local/bin/ubiquitous_bash.sh", "_drop_docker"]
#ENTRYPOINT ["bash", "-c", "echo ls / ; ls / ; echo ls ; ls ; echo $PWD"]
ENTRYPOINT ["/ubiquitous_bash.sh", "_bin"]



















