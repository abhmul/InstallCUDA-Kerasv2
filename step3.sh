#!/bin/bash

# Install latest Linux headers
sudo apt-get install -y linux-source linux-headers-`uname -r` 

# Install CUDA 8.0 (note – don't use any other version)
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
mv cuda_8.0.61_375.26_linux-run cuda_8.0.61_375.26_linux.run
chmod +x cuda_8.0.61_375.26_linux.run
./cuda_8.0.61_375.26_linux.run -extract=`pwd`/nvidia_installers
cd nvidia_installers
# sudo ./NVIDIA-Linux-x86_64-375.26.run
sh NVIDIA-Linux-x86_64-375.26.run --extract-only
cd NVIDIA-Linux-x86_64-375.26
# Get the patch for the GCP fix and apply it
wget https://gist.githubusercontent.com/tpruzina/939ca3170d1aa48a601228b7773e2bb1/raw/8ed7ac1cd1615d8e858d9b152aa1cc2da91b6cb1/gistfile1.txt
mv gistfile1.txt gistfile1.patch
patch -p1 < gistfile1.patch
# Install the drivers
sudo ./nvidia-installer
# Install CUDA 8
sudo modprobe nvidia
sudo ./cuda-linux64-rel-8.0.61-21551265.run
cd ..

# Install the CUDA 8 Patch
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run
mv cuda_8.0.61.2_linux-run cuda_8.0.61.2_linux.run
sudo sh cuda_8.0.61.2_linux.run

# Install CUDNN 6.0 (note – don't use any other version)
wget https://s3.amazonaws.com/kaggle-stuff/cudnn-8.0-linux-x64-v6.0.tgz
tar -xzf cudnn-8.0-linux-x64-v6.0.tgz 
sudo cp -P cuda/lib64/* /usr/local/cuda/lib64
sudo cp -P cuda/include/* /usr/local/cuda/include/

# Set up the CUDA home, path, and library path
echo 'export CUDA_HOME=/usr/local/cuda' >> ~/.bashrc
echo 'export PATH=$PATH:$CUDA_HOME/bin' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64' >> ~/.bashrc

# Do some cleanup
sudo rm cuda_8.0.61_375.26_linux.run
sudo rm cuda_8.0.61.2_linux.run
sudo rm cudnn-8.0-linux-x64-v6.0.tgz
sudo rm -rf cuda
sudo rm -rf nvidia_installers

# Install tensorflow
sudo pip3 install --upgrade pip
sudo pip3 install tensorflow-gpu==1.3.0

# Install keras
sudo pip3 install keras
sudo pip3 install h5py

# Install PyTorch and PyJet
sudo pip install http://download.pytorch.org/whl/cu80/torch-0.2.0.post2-cp35-cp35m-manylinux1_x86_64.whl
sudo pip install torchvision
git clone https://github.com/abhmul/PyJet
sudo pip install -e .

# Install some other useful packages
sudo pip3 install pillow
sudo pip3 install scikit-learn
sudo pip3 install opencv-python

# One final reboot
sudo reboot
