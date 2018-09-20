#!/bin/bash

echo "~~~NOT TESTED~~~"
read -p "Press Enter to continue"

echo "***The GPU driver should be higher than version 390***"
echo "Checking the GPU driver version..."

nvidia-smi

echo -e "\n\nThe output should be like the following:
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

echo -e "\n"
read -p "Press Enter to continue or press Ctrl+C to abort"

mkdir tmp-install-tensorflow
cd tmp-install-tensorflow

echo -e "\n\nInstalling CUDA Toolkit 9.0 ..."

wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
sudo chmod +x cuda_9.0.176_384.81_linux-run
echo -e "***\n\nNOTE! Say YES to installing with an unsupported configuration and say NO to Installing NVIDIA Accelerated Graphics Driver!***"
read -p "Press Enter to continue"
./cuda_9.0.176_384.81_linux-run --override

echo "export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> ~/.bashrc
source ~/.bashrc

echo -e "\nInstalling cuDNN 7.0.5 ..."
# wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.0_20171129/cudnn-9.0-linux-x64-v7
# tar -zxvf cudnn-9.0-linux-x64-v7.tgz
# sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/
# sudo cp  cuda/include/cudnn.h /usr/local/cuda-9.0/include/
#sudo chmod a+r /usr/local/cuda-9.0/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
CUDNN_PKG="libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb"
wget https://github.com/ashokpant/cudnn_archive/raw/master/v7.0/${CUDNN_PKG}
sudo dpkg -i ${CUDNN_PKG}
sudo apt-get update

echo -e "\n\nInstalling Anaconda ..."

curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
sh Anaconda3-5.2.0-Linux-x86_64.sh
echo "export PATH=~/anaconda3/bin:$PATH" >> ~/.bashrc
source ~/.bashrc

echo -e "\n\nCreating an Anaconda environment named tf ..."
conda create -n tf pip python=3.6
source activate tf

read -p "Press Enter to continue"

echo -e "\nInstalling TensorFlow GPU 1.5 ..."

pip install tensorflow-gpu==1.5

echo -e "\n\nInstalling Keras"

pip install keras

source deactivate tf

cd ..
rm -rf tmp-install-tensorflow

