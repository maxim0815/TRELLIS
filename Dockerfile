FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

####################################################
# NO ENVIRONMENT RIGHT NOW
####################################################

ARG DEBIAN_FRONTEND=noninteractive

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Update and install debian stuff
RUN apt-get update && apt-get -y install \
    wget \
    unzip \
    git \
    curl \
    lsb-release \
    manpages-dev \
    build-essential \
    libgl1-mesa-glx \
    mesa-utils\
    libboost-dev \
    libxerces-c-dev \
    libeigen3-dev\
    python3.10 \
    python3-pip \
    python3-tk \
    && rm -rf /var/lib/apt/lists/*
    
# Install torch stuff
RUN pip install torch==2.3.0+cu118 torchvision==0.18.0+cu118 -f https://download.pytorch.org/whl/torch_stable.html

COPY setup.sh .
RUN ./setup.sh --basic --flash-attn --kaolin --nvdiffrast --demo 