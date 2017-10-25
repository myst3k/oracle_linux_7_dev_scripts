#!/usr/bin/env bash

#set -o xtrace
set -o nounset
set -o errexit

sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config
yum -y remove wpa_supplicant iprutils iwl*firmware libertas* ivtv* alsa-* btrfs-progs* aic94xx-firmware kexec-tools NetworkManager* microcode_ctl
systemctl enable network
systemctl start network
plymouth-set-default-theme details
dracut -f
yum -y install open-vm-tools wireshark man rng-tools unzip bind-utils yum-utils chrony
yum-config-manager --enable ol7_optional_latest
yum-config-manager --enable ol7_addons
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install htop screen tmux byobu rpmconf
yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
yum -y install ripgrep
systemctl enable chronyd