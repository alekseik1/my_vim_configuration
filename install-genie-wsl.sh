#!/bin/bash
set -o pipefail
set -eux
systemctl set-default multi-user.target
sudo apt install lsb-release
sudo wget -O /etc/apt/trusted.gpg.d/wsl-transdebian.gpg https://arkane-systems.github.io/wsl-transdebian/apt/wsl-transdebian.gpg

sudo chmod a+r /etc/apt/trusted.gpg.d/wsl-transdebian.gpg

sudo cat << EOF > /etc/apt/sources.list.d/wsl-transdebian.list
deb https://arkane-systems.github.io/wsl-transdebian/apt/ $(sudo lsb_release -cs) main
deb-src https://arkane-systems.github.io/wsl-transdebian/apt/ $(sudo lsb_release -cs) main
EOF

sudo apt update
sudo apt install -y systemd-genie
# HACKS
sudo e2label /dev/sdb cloudimg-rootfs
sudo ssh-keygen -A
sudo systemctl disable multipathd
cat << EOF > /etc/systemd/network/10-eth0.network
[Match]
Name=eth0

[Link]
Unmanaged=yes

[Network]
DHCP=no

[DHCP]
UseDNS=false
EOF
set +x
echo "execute: systemctl edit systemd-sysusers.service"
echo "add there"
echo "[Service]"
echo "LoadCredential="
echo "see here https://github.com/arkane-systems/genie/wiki/Systemd-units-known-to-be-problematic-under-WSL#systemd-sysusersservice"
