# AWSTensorflowKerasv2

A Fuss-Free Guide to install updated Tensorflow V1.0.1 and Keras V2.0.2 on a p2.xlarge instance from AWS

## Pre-setup

First you'll need a p2.xlarge (or g2.2xlarge) instance to use with at least 16GB of storage. Once you've made it, connect to it and type the following command:

```
git clone https://github.com/abhmul/AWSTensorflowKerasv2
```

Then run the following command:

```
mv AWSTensorflowKerasv2/step* .
```

## Step 1

Just run:

```
sh step1.sh
```

It's really that easy. When the script finishes the machine will reboot, so you'll get disconnected. Wait for a couple minutes, refresh your EC2 Console webpage, and reconnect to your instance

## Step 2

Just run:

```
sh step2.sh
```

Again, the script will reboot the machine when it's finished, so same deal as in Step 1

### Step 3:

Just run:

```
sh step3.sh
```

This one will require some user input. 

1. For the NVIDIA driver installation (the screen will look blue with some prompts) click "Accept" and "OK" whenever it asks.

2. For the CUDA installation
   * You'll have to hold "Enter" until you reach the end of the EULA, and then type "accept" 
   * Click "Enter" to accept the default CUDA install path
   * Click "Enter to accept the default desktop menu shortcuts
   * Click "Enter" to do the default symbolic link creation between /usr/local/cuda-8.0 and /usr/local/cuda

3. three
   * nested

