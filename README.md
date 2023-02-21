# nano_docker_zed_opencv
This repo has the docker file for build an image including ZED SDK and Opencv for Jetson Nano

## PART 1: Write image and install OS

## PART 2: Config pc:
Connect the ethernet cable and open a terminal:
```
	sudo apt update
	sudo apt-mark hold systemd		from	--> 	[Due to an issue: Jetson Nano blank screen during and after boot] 
								Ref: https://forums.developer.nvidia.com/t/jetson-nano-blank-screen-during-and-after-boot/160356
	sudo apt upgrade
	sudo reboot
```	
	
Install the USB WIFI (Buffalo 11ac):		from --> 	https://github.com/morrownr/8821au-20210708

```
connect the USB wifi to a USB port port on Jetson Nano
	sudo apt install -y build-essential dkms git 
	mkdir -p ~/app
	cd app
	git clone https://github.com/morrownr/8821au-20210708.git
	cd 8821au-20210708
	./ARM64_RPI.sh				[Although, this is meant for Rasberry Pi devices, it is an option that works in this case for a Jetson Nano.]
						Ref: https://gist.github.com/TOTON95/b445509399a0d0314d2bc4079527f5a8
						Note: If that not works, check this two links for modifications to fix:
						https://forums.developer.nvidia.com/t/make-usb-wifi-dongle-rtl8812au-works-on-nano/74372/8
						https://github.com/morrownr/8821au-20210708#step-9-run-a-script-to-reconfigure-for-arm-or-arm64-based-systems
	
	sudo ./install-driver.sh
		Do you want to edit the driver options file now? [y/n] n
		Do you want to reboot now? [y/n] y
		if not reboot --> sudo reboot

```

## PART 3: Run docker:
```
sudo nvpmodel -m 1
sudo xhost +si:localuser:root
sudo docker run --gpus all -it --rm --net=host --runtime nvidia --privileged  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix 3.6-all-tools-withgtk-devel-l4t-r32.7:latest
sudo docker run --gpus all -it --rm --net=host --runtime nvidia --privileged  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix sjamani/3.6-all-tools-withgtk-devel-l4t-r32.7:latest
nvidia-smi
nvcc --version
apt-get update && apt-get install cmake -y
apt-get install libcanberra-gtk* -y			# this is new. Yesterday I did NOT use it. Failed to load module "canberra-gtk-module"
cd home/
git clone https://github.com/Sj-Amani/zed-examples.git
cd zed-examples/object\ detection/custom\ detector/cpp/tensorrt_yolov5_v6.0/
mkdir build && cd build
cmake .. && make
cd ..
wget https://download.stereolabs.com/sample_custom_objects/yolov5s_v6.0.wts.zip
unzip yolov5s_v6.0.wts.zip && rm yolov5s_v6.0.wts.zip
./build/yolov5_zed -s yolov5s.wts yolov5s.engine s
ls  --> should see "yolov5s.engine"
./build/yolov5_zed -d yolov5s.engine ZED_input_option  ➡️  Perfect




apt-get install vim -y

init_params.camera_resolution = RESOLUTION::HD720;
init_params.camera_fps = 30;
```
