#!/bin/sh

docker run -v /mnt/ml-stuff2:/data  -it --rm --gpus all akaver/pytorch bash
