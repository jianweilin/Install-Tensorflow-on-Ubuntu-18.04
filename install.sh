#!/bin/bash

echo "~~~NOT TESTED~~~"
read -p "Press Enter to continue"

echo "The GPU driver should be higher than version 390"
echo "Checking..."

nvidia-smi

echo "The output should be like the following:
Wed Aug 22 19:25:07 2018 
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.48                 Driver Version: 390.48                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 950M    Off  | 00000000:01:00.0 Off |                  N/A |
| N/A   53C    P0    N/A /  N/A |    237MiB /  4046MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+"

read -p "Press Enter to continue"

mkdir tmp-install-tensorflow
cd tmp-install-tensorflow

echo "Installing CUDA Toolkit 9.0"

wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
sudo chmod +x cuda_9.0.176_384.81_linux.run
echo "NOTE! Say YES to installing with an unsupported configuration and say NO to Installing NVIDIA Accelerated Graphics Driver!"
./cuda_9.0.176_384.81_linux.run --override

echo "export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> ~/.bashrc
source ~/.bashrc

echo "Installing cuDNN 7.0.5"

wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.0_20171129/cudnn-9.0-linux-x64-v7
tar -zxvf cudnn-9.0-linux-x64-v7.tgz
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/
sudo cp  cuda/include/cudnn.h /usr/local/cuda-9.0/include/
sudo chmod a+r /usr/local/cuda-9.0/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

echo "Installing Anaconda"

wget https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
sh Anaconda3-5.2.0-Linux-x86_64.sh

echo "Creating an Anaconda environment named tf"
conda create -n tf pip python=3.6
source activate tf

echo "To activate the installation, run: source activate tf"
echo "To deactivate the instalation, run: source deactivate tf"
read -p "Press Enter to continue"

echo "Installing TensorFlow GPU 1.5"

pip install tensorflow-gpu==1.5

echo "Installing Keras"

pip install keras

cd ..
rm -rf tmp-install-tensorflow

