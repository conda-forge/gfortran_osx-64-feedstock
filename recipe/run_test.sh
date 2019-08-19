#!/bin/bash

$FC -o hello hello.f90 -Wl,-rpath,${PREFIX}/lib -v
./hello
rm -f hello

$FC -O3 -fopenmp -ffast-math -o maths maths.f90 -Wl,-rpath,${PREFIX}/lib -v
./maths
rm -f maths

if [[ ! $FFLAGS ]]
then
    exit 1
fi
