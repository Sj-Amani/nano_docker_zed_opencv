#!/bin/bash
set -e

# This is a shell script that configures the build arguments to the Dockerfile
# and builds a Docker image for Jetson Nano with a default tag. 

#Build Arguments
# Check https://www.stereolabs.com/developers/release/3.6/ for the versions
ZED_SDK_MAJOR=3 		# ZED SDK major version 
ZED_SDK_MINOR=6			# ZED SDK minor version
JETPACK_MAJOR=4         # Jetpack major version
JETPACK_MINOR=6         # Jetpack minor version
L4T_MINOR_VERSION=7 	#L4T Minor version
OPENCV_VERSION=4.5.5	#OpenCV Version

# Source: https://forums.developer.nvidia.com/t/suggestion-to-solve-tegra-nvidia-docker-issues/117522/15
#
# this script copies development files and headers from the target host
# into the packages dir, which get used during building some containers
#

mkdir -p packages/usr/include
mkdir -p packages/usr/include/aarch64-linux-gnu
mkdir -p packages/usr/lib/python3.6/dist-packages

#cp /usr/include/cublas*.h packages/usr/include
cp /usr/include/cudnn*.h packages/usr/include

cp /usr/include/aarch64-linux-gnu/Nv*.h packages/usr/include/aarch64-linux-gnu

cp -r /usr/lib/python3.6/dist-packages/tensorrt* packages/usr/lib/python3.6/dist-packages
cp -r /usr/lib/python3.6/dist-packages/graphsurgeon* packages/usr/lib/python3.6/dist-packages
cp -r /usr/lib/python3.6/dist-packages/uff* packages/usr/lib/python3.6/dist-packages


# Default Tag based on the selected versions
TAG="${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}-all-tools-devel-l4t-r32.${L4T_MINOR_VERSION}"          
           
echo "Building '${TAG}'" 

docker build --build-arg L4T_MINOR_VERSION=${L4T_MINOR_VERSION} \
		     --build-arg ZED_SDK_MAJOR=${ZED_SDK_MAJOR} \
			 --build-arg ZED_SDK_MINOR=${ZED_SDK_MINOR} \
             --build-arg JETPACK_MAJOR=${JETPACK_MAJOR} \
             --build-arg JETPACK_MINOR=${JETPACK_MINOR} \
			 --build-arg OPENCV_VERSION=${OPENCV_VERSION} \
			 -t "${TAG}" -f Dockerfile.all .
