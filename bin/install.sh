#!/bin/bash
# Create a new User and Install Docker on Debian / Ubuntu
# Define Variables
USERNAME=melvin
PUBLIC_KEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+uWLZPlXOw9IpWqsovuzUYvZVvWgGYZWygedrcAt8wCJ7pGxgZ1cds+2lwS5fogJZJZex/+fOBVN0u00rS14SNSqqB1HKmAJWPHqJ5Hi6VrTGNvy9QPzZ+xxVPFdxOyz0J7GRf/fWklWLMunOe5jsyiZS5p18z8D1bX3IITO8T++uGlGH7ltXODJCAztzLpNMfCqhXq951A9q4MZrzh9aoOPzlgz5h1lVUwQ6qmZmgFOXVtcdKbPxICs3xJdHK+Z7UM4dM+tpAeKwQoi+adspGKO0shqxSQ2Zc8wZJf5Y7rUSx5/2BUezgsJAYLB35Lnz4PDWTS27aRlHAGkY5g2aHDP6O2Dubjxf5D97+2jwzPQQqFrp7WF1jDJl3slB37938sOHxRbb6oPC+U9u27ZgCJ2CtqsMVdUo67Des4pzW1zUIx/shOlc2pCqjyVxYkEbvx6cM8QkwhhWiEAP8pw0xaV2QnQ3DyG8bLxxHQ11Jaki+TCl/19MC7lg/8waBDc= melro@MELZ-PC'

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
