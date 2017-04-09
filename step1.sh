#!/bin/bash

# The CUDA part is mostly based on this excellent blog post:
# http://tleyden.github.io/blog/2014/10/25/cuda-6-dot-5-on-aws-gpu-instance-running-ubuntu-14-dot-04/

# Install various packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y build-essential python3-pip python3-dev git python3-numpy swig python3-dev

# Blacklist Noveau which has some kind of conflict with the nvidia driver
echo -e "blacklist nouveau\nblacklist lbm-nouveau\noptions nouveau modeset=0\nalias nouveau off\nalias lbm-nouveau off\n" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u
sudo reboot # Reboot (annoying you have to do this in 2015!)
