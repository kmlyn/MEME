#!/usr/bin/bash

module load mpich

mpirun -np 16 meme_main
