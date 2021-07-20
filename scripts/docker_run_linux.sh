#!/bin/sh

docker run -v /home/akaver/!Dev/xvector_speakerid:/opt/project -v /mnt/ml-stuff2:/data  -it --rm --gpus all akaver/pytorch bash
