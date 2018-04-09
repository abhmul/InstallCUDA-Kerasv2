# InstallCUDA-Kerasv2

 A Fuss-Free 3-step Guide to install updated Tensorflow V1 and Keras V2 on Ubuntu 16.04 with a GPU

## Pre-setup

First you'll need an instance on Ubuntu 16.04 LTS with an Nvidia GPU (p2.xlarge AWS, g2.2xlarge AWS, GPU Google Cloud, etc.) to use with at least **20GB of storage**. Once you've made it, connect to it and type the following command:

```
git clone https://github.com/abhmul/InstallCUDA-Kerasv2
```
**Note**: If you're using Google Cloud (GCP) you'll want to run `git checkout abhmul-gcp-patch` from the repository directory to fix a low-level incompatibility bug between GCP and the Nvidia Drivers.

**Note**: If you're using Ubuntu desktop you'll want to run `git checkout abhmul-ubuntu-desktop-patch` from the repository directory to properly install without getting xserver issues. Also use the README from that branch.

Then run the following command:

```
mv InstallCUDA-Kerasv2/step* .
```

## Step 1

Just run:

```
sh step1.sh
```

It's really that easy. When the script finishes the machine will reboot, so you'll get disconnected. Wait for a couple minutes, refresh your EC2 Console webpage, and reconnect to your instance.

**Note**: If you see a prompt that about */boot/grub/menu.lst*, select *Install the package maintainer's version*.

## Step 2

Just run:

```
sh step2.sh
```

Again, the script will reboot the machine when it's finished, so same deal as in Step 1.

## Step 3:

Just run:

```
sh step3.sh
```

This one will require some user input. 

For the NVIDIA driver installation (the screen will look blue with some prompts) click "Accept" and "OK" whenever it asks (any warnings you get are okay as long as it says it successfully installed in the end).
 
 The script will do one last reboot, so same deal as in Step 1.

## Step 4 (Optional):

Now we can verify if everything properly installed with the example included in the repo. The example trains a pre-trained version of InceptionV3 to discern between images of cats and dogs. Run the following commands to test our installation:

```
cd InstallCUDA-Kerasv2
tar -zxvf CatDogDataset.tar.gz
python3 bottleneck_example.py
```

If everything worked properly, after Tensorflow finishes loading up we should see the model training at around 123s/epoch for the first epoch. By the 2nd or 3rd epoch the model should be training at around 103s/epoch. The python file will save the best model weights after every epoch.

## Step 5 (Cleanup)

Now that we've got everything installed, we can clean up our storage by deleting all the files we downloaded using the commmands:

```
cd ..
sudo rm -rf InstallCUDA-Kerasv2
sudo rm step*
```

### That's it! You're instance is ready for whatever deep learning tasks you throw at it!
