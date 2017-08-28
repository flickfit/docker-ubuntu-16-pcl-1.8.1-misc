FROM flickfit/ubuntu-16-pcl-1.8.1:latest

MAINTAINER Kenji Nomura <atatb23@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      libopencv-dev \
      libusb-1.0-0-dev \
      libboost-all-dev libproj-dev \
      && rm -rf /var/lib/apt/lists/*

# Build librealsense
RUN \
    git clone --branch v1.12.1 https://github.com/IntelRealSense/librealsense.git --depth 1 && \
    cd librealsense && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j 2 && make install && make clean && \
    cd ../../ && rm -rf librealsense

# Build lib_aruco
RUN \
    git clone https://git.code.sf.net/p/aruco/aruco-git aruco-aruco-git --depth 1 && \
    cd aruco-aruco-git && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j 2 && make install && \
    cd ../../ && rm -rf aruco-aruco-git

RUN ldconfig
