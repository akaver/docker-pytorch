#FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-devel
FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel

WORKDIR /setup

RUN apt-get update

# install packages
run apt-get install -y git ffmpeg parallel mc python3-magic

# install apex
RUN git clone https://github.com/NVIDIA/apex && cd apex && pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

# install speechbrain
RUN git clone https://github.com/akaver/speechbrain.git && cd speechbrain && pip install -r requirements.txt
# && pip install --editable .

RUN mkdir /data && mkdir /opt/project

COPY requirements.txt /setup/requirements.txt
RUN pip install -r requirements.txt

# RUN pip install --upgrade --force-reinstall torchtext

WORKDIR /opt/project
