#FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-devel
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

WORKDIR /setup

RUN apt-get update

# RUN apt-get -y upgrade

# install packages
RUN apt-get install -y git ffmpeg parallel mc python3-magic rsync

# install apex
# RUN git clone https://github.com/NVIDIA/apex && cd apex && pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

# install speechbrain
# RUN git clone https://github.com/akaver/speechbrain.git && cd speechbrain && pip install -r requirements.txt
# && pip install --editable .

RUN pip3 install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio==0.10.2+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

RUN pip install -U https://s3-us-west-2.amazonaws.com/ray-wheels/latest/ray-2.0.0.dev0-cp37-cp37m-manylinux2014_x86_64.whl

RUN mkdir /data && mkdir /project

COPY requirements.txt /setup/requirements.txt
RUN pip install -r requirements.txt

# RUN pip install --upgrade --force-reinstall torchtext

WORKDIR /project
