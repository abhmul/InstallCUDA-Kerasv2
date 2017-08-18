#!/bin/bash

# Install latest Linux headers
sudo apt-get install -y linux-source linux-headers-`uname -r` 

# Install CUDA 8.0 (note – don't use any other version)
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
mv cuda_8.0.61_375.26_linux-run cuda_8.0.61_375.26_linux.run
chmod +x cuda_8.0.61_375.26_linux.run
./cuda_8.0.61_375.26_linux.run -extract=`pwd`/nvidia_installers
cd nvidia_installers
sudo ./NVIDIA-Linux-x86_64-375.26.run
sudo modprobe nvidia
sudo ./cuda-linux64-rel-8.0.61-21551265.run
cd ..

# Install CUDNN 8.0 (note – don't use any other version)
wget https://s3.amazonaws.com/kaggle-stuff/cudnn-8.0-linux-x64-v5.1.tgz
tar -xzf cudnn-8.0-linux-x64-v5.1.tgz 
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo cp -P cuda/include/cudnn.h /usr/local/cuda/include/

# Set up the CUDA home, path, and library path
echo 'export CUDA_HOME=/usr/local/cuda' >> ~/.bashrc
echo 'export PATH=$PATH:$CUDA_HOME/bin' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64' >> ~/.bashrc


# Do some cleanup
sudo rm cuda_8.0.61_375.26_linux.run
sudo rm cudnn-8.0-linux-x64-v5.1.tgz
sudo rm -rf cuda
sudo rm -rf nvidia_installers

# Install tensorflow
sudo pip3 install --upgrade pip
export TF_BINARY_URL=https://pypi.python.org/packages/f0/2e/49c8cf629dfd4bc4932$
sudo pip3 install --ignore-installed --upgrade $TF_BINARY_URL
export TF_GPU_BINARY_URL=https://pypi.python.org/packages/f2/5e/a51a5df287753c6$
sudo pip3 install --ignore-installed --upgrade $TF_GPU_BINARY_URL
#sudo pip3 install tensorflow-gpu

# Install keras
sudo pip3 install keras
sudo pip3 install h5py

# Install some other useful packages
sudo pip3 install pillow
sudo pip3 install scikit-learn
sudo pip3 install opencv-python

# One final reboot
sudo reboot
