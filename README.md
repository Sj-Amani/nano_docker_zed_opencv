# nano_docker_zed_opencv
This repo has the docker file for build an image including ZED SDK and Opencv for Jetson Nano

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
