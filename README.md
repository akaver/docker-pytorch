# docker-pytorch

Pytorch and other libraries in docker image. Used in ML/DL research.

Mainly used in two ways:
* as remote python interpreter in local DL machine or laptop, using PyCharm
* converted into Singular image and running experiments in remote DL server/HPC. Job scheduling is done via Slurm.

Everything is done/tested in linux (Ubuntu) and on M1 Max macbook. Not used/tested on Windows.  

As of winter 2022 my local DL machine has single Nvidia RTX3090(24gb), 64gb ram, 1x Intel Core i9 - 4 cores, 8 threads.  
My main remote DL has 8x Nvidia A100 (48gb per card), 1Tb ram, 2x AMD Epyc 7742 cpus (2x64 cores, 256 threads).  
https://taltech.ee/en/itcollege/hpc-centre  

Thus many experiments in my other repositories have two setups - with minimal data/config for local testing and full setup for training in HPC. Most of my experiments/research is in NLP and audio, so typically lots of data and days of training even on 8x A100 gpus.


Docker image built from this repo is available in docker hub as:  
akaver/pytorch:latest  
https://hub.docker.com/r/akaver/pytorch/tags  


Libraries installed in the image at any given time vary based on my current need. No guarantees.  
There are many conflicting libraries and their dependencies being balanced all the time. YMMV.  

## Build instructions

Modify /etc/docker/daemon.json to use default nvidia runtime - used during image setup to build Apex (it checks for GPU support during installation).

~~~json
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "default-runtime": "nvidia"
}
~~~

To build the image:

~~~bash
docker build -t akaver/pytorch:latest .
~~~

To publish the image to docker hub:

~~~bash
docker push akaver/pytorch:latest
~~~

## Singularity

HPC does not support docker - docker containers have root level access to system, thus many security problems. Singularity supports docker images and runs them in userspace.  
Singularity has many weird quirks and differences compared to the docker:  
* to persist data, mounted directories have to be precreated in image (currently  in this image: /data for datasets and results and /project for python files).
* WORKDIR is not supported - execution starts from default home directory mountpoint.  

Look into singularity directory for some of my examples. Scripts folder contains testing run scripts for linux and osx.

## Docker

Docker container settings in my personal PyCharm  
--entrypoint -v /home/akaver/!Dev/speechbrain:/project -v /mnt/ml-stuff2:/data --rm --gpus all
