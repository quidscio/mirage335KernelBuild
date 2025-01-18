
# https://moebuta.org/posts/using-github-actions-to-build-linux-kernels/?utm_source=chatgpt.com
# ATTRIBUTION-AI: ChatGPT  4o , o1  2025-01-18 .

FROM debian:12.1 AS deb-src
COPY <<"EOF" /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main
deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian-security/ bookworm-security main
deb-src http://deb.debian.org/debian-security/ bookworm-security main

deb http://deb.debian.org/debian bookworm-updates main
deb-src http://deb.debian.org/debian bookworm-updates main
EOF


FROM deb-src AS install-dependency
RUN <<"EOF"
apt-get update
apt-get install build-essential wget git -y
apt-get build-dep linux -y

##xz btrfs-tools grub-mkstandalone mkfs.vfat mkswap mmd mcopy mksquashfs

#gpg pigz curl gdisk lz4 mawk jq gawk build-essential autoconf pkg-config bsdutils findutils patch tar gzip bzip2 sed lua-lpeg axel aria2 gh rsync pv expect libfuse2 udftools debootstrap cifs-utils dos2unix xxd debhelper p7zip nsis jp2a btrfs-progs btrfs-compsize zstd zlib1g coreutils util-linux kpartx openssl growisofs udev gdisk parted bc e2fsprogs xz-utils libreadline8 mkisofs genisoimage byobu xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils

##dnsutils bind9-dnsutils bison libelf-dev elfutils flex libncurses-dev libudev-dev dwarves pahole cmake sockstat liblinear4 liblua5.3-0 nmap nmap-common socat dwarves pahole libssl-dev cpio libgtk2.0-0 libwxgtk3.0-gtk3-0v5 wipe iputils-ping nilfs-tools python3 sg3-utils cryptsetup php
##qemu-system-x86
##qemu-user qemu-utils

apt-get install -y sudo gpg wget pigz dnsutils bind9-dnsutils curl gdisk parted lz4 mawk jq gawk build-essential bison libelf-dev elfutils flex libncurses-dev autoconf libudev-dev dwarves pahole cmake pkg-config bsdutils findutils patch tar gzip bzip2 flex sed sockstat liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common socat axel aria2 gh rsync libssl-dev cpio pv expect libfuse2 cifs-utils dos2unix xxd debhelper p7zip iputils-ping btrfs-progs btrfs-compsize zstd zlib1g nilfs-tools coreutils python3 util-linux kpartx openssl udev cryptsetup bc e2fsprogs xz-utils libreadline8 byobu squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils trousers tpm-tools

apt-get install -y rustc cargo
EOF

FROM install-dependency AS debianStable
RUN <<"EOF"

mkdir -p "$HOME"
cd "$HOME"
git clone --depth 1 --recursive https://github.com/mirage335-colossus/ubiquitous_bash.git
cd ubiquitous_bash
bash ./_setupUbiquitous.bat
./ubiquitous_bash.sh _custom_splice_opensslConfig
EOF

WORKDIR /app

#COPY . /app


#ENTRYPOINT ["/usr/local/bin/ubiquitous_bash.sh", "_drop_docker"]
#ENTRYPOINT ["./ubiquitous_bash.sh", "_bin"]
ENTRYPOINT ["bash", "-c", "echo ls / ; ls / ; echo ls ; ls ; echo $PWD"]



















