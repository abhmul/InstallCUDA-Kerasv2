#!/bin/bash

# Install latest Linux headers
sudo apt-get install -y linux-source linux-headers-`uname -r`

# Install the drivers through aptitude
sudo apt-get purge nvidia*
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get install nvidia-384

# Install CUDA 9.0 (note – don't use any other version)
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
mv cuda_9.0.176_384.81_linux-run cuda_9.0.176_384.81_linux.run
chmod +x cuda_9.0.176_384.81_linux.run
./cuda_9.0.176_384.81_linux.run -extract=`pwd`/nvidia_installers
cd nvidia_installers
sudo modprobe nvidia
sudo ./cuda-linux.9.0.176-22781540.run -noprompt
cd ..

# Install CUDNN 7.0 (note – don't use any other version)
wget https://s3.amazonaws.com/kaggle-stuff/cudnn-9.0-linux-x64-v7.tgz
tar -xzf cudnn-9.0-linux-x64-v7.tgz
sudo cp -P cuda/lib64/* /usr/local/cuda/lib64
sudo cp -P cuda/include/* /usr/local/cuda/include/

# Set up the CUDA home, path, and library path
echo 'export CUDA_HOME=/usr/local/cuda' >> ~/.bashrc
echo 'export PATH=$PATH:$CUDA_HOME/bin' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64' >> ~/.bashrc

# Do some cleanup
sudo rm cuda_9.0.176_384.81_linux.run
sudo rm cudnn-9.0-linux-x64-v7.tgz
sudo rm -rf cuda
sudo rm -rf nvidia_installers

# Install anaconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo pip3 install --upgrade pip
conda update conda
conda create -n dl anaconda
source activate dl


# Install tensorflow
sudo pip3 install tensorflow-gpu==1.5.0rc1

# Install keras
sudo pip3 install keras
sudo pip3 install h5py

# Install PyTorch and PyJet
sudo pip3 install http://download.pytorch.org/whl/cu90/torch-0.3.0.post4-cp35-cp35m-linux_x86_64.whl
sudo pip3 install torchvision
git clone https://github.com/abhmul/PyJet
cd PyJet
sudo pip3 install -e .
cd ..

# Install some other useful packages
sudo pip3 install pillow
sudo pip3 install scikit-learn
sudo pip3 install opencv-python

# One final reboot
sudo reboot
