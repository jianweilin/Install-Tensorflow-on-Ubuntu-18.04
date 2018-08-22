# Install-Tensorflow-on-Ubuntu-18.04

## Step 1: Update your GPU drivers

The GPU driver should be higher than version 390. You can check what graphics driver you have installed with the following command:

```
nvidia-smi
```

The output should be like the following:

```
Wed Aug 22 19:25:07 2018 
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.48                 Driver Version: 390.48                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 950M    Off  | 00000000:01:00.0 Off |                  N/A |
| N/A   53C    P0    N/A /  N/A |    237MiB /  4046MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0      1071      G   /usr/lib/xorg/Xorg                            24MiB |
|    0      1165      G   /usr/bin/gnome-shell                          48MiB |
|    0      1561      G   /usr/lib/xorg/Xorg                            93MiB |
|    0      1747      G   /usr/bin/gnome-shell                          66MiB |
+-----------------------------------------------------------------------------+
```

## Step 2: Install the CUDA Toolkit (9.0)


Go to https://developer.nvidia.com/cuda-90-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1704&target_type=runfilelocal and download the toolkit for `Linux` - `x86_64` - `Ubuntu` - `17.04` - `runfile (local)` - `Base installer`.

Once you’ve got that file, navigate to where the file was downloaded. Open a terminal and run the following commands:


```
sudo chmod +x cuda_9.0.176_384.81_linux.run
./cuda_9.0.176_384.81_linux.run --override
```

#### Note
Accept the term and conditions.
```
Do you accept the previously read EULA?
accept/decline/quit: accept
```

Say yes to installing with an unsupported configuration.
```
You are attempting to install on an unsupported configuration. Do you wish to continue?
(y)es/(n)o [ default is no ]: yes
```

Say no to installing NVIDIA Accelerated Graphics Driver.
```
Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?
(y)es/(n)o/(q)uit: no
```

Say yes to install the CUDA 9.0 Toolkit.
```
Install the CUDA 9.0 Toolkit?
(y)es/(n)o/(q)uit: yes
```
