# nano_docker_zed_opencv
This repo has the docker file for building an image, including ZED SDK and Opencv for Jetson Nano.
I am using this repo for my workshop attendees.
Later, I will complete the instructions used here.

### Tip: 
Just do the **PART 2: Run docker** on your Jetson's terminal to see the final results. Be careful to connect a `Stereolabs` camera with a depth feature before opening your terminal!

I tested on:
* Jetson:  Nano and NX
* Camera:  ZED2 and ZED min

## PART 1: Data Annotation via CVAT [Intel & OpenCV]:
Connect to the internet and open a terminal:
```
git clone https://github.com/cvat-ai/cvat
cd cvat
sudo docker-compose up -d
sudo docker exec -it cvat_server bash -ic 'python3 ~/manage.py createsuperuser'
	Username: 	 --> Wirte 'test' and Press Enter.
	Email:		 --> Press Enter
	Password: 	 --> 1234
	Password(again): --> 1234
	Bypass...:	 --> y
```	
Open the installed Google Chrome browser and go to **localhost:8080**. Type your login/password for the superuser on the login page and press the Login button. Now you should be able to create a new annotation task. Please read the [CVAT manual](https://opencv.github.io/cvat/docs/manual/) for more details.

![Annotation_gif](videos/Annotation.gif)

## PART 2: Run docker:
```
sudo xhost +si:localuser:root
sudo docker run --gpus all -it --rm --net=host --runtime nvidia --privileged  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix sjamani/3.6-all-tools-withgtk-devel-l4t-r32.7:latest
nvcc --version
apt-get update && apt-get install cmake -y
apt-get install libcanberra-gtk* -y
cd home/
git clone https://github.com/Sj-Amani/zed-examples.git
cd zed-examples/object\ detection/custom\ detector/cpp/tensorrt_yolov5_v6.0/
mkdir build && cd build
cmake .. && make
cd ..
wget https://download.stereolabs.com/sample_custom_objects/yolov5s_v6.0.wts.zip
unzip yolov5s_v6.0.wts.zip && rm yolov5s_v6.0.wts.zip
./build/yolov5_zed -s yolov5s.wts yolov5s.engine s
ls		--> should see "yolov5s.engine"
./build/yolov5_zed -d yolov5s.engine ZED_input_option		--> END
```	

![AI_Detection_Result_gif](videos/AI_Detection_Result.gif)


