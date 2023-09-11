#!/bin/bash
# Create a new User and Install Docker on Debian / Ubuntu
# Define Variables
USERNAME=
PUBLIC_KEY=''

# Check if run as root
if [ $EUID -ne 0 ]; then
	echo "This script needs to be run as root"
	exit 1
fi

# Needed for Ubuntu 22.04
export NEEDRESTART_MODE=a

# Update package cache
apt update

# Create a new user called 'melvin'
adduser --disabled-password --gecos "" ${USERNAME}

# Set up the public ssh key for USERNAME
mkdir /home/${USERNAME}/.ssh
echo ${PUBLIC_KEY} | tee -a /home/${USERNAME}/.ssh/authorized_keys
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
chmod 700 /home/${USERNAME}/.ssh
chmod 600 /home/${USERNAME}/.ssh/authorized_keys

# Install Docker
curl -fsSL https://get.docker.com -o install-docker.sh
sh install-docker.sh

# Add user to docker group and make him admin
usermod -aG docker,sudo $USERNAME
