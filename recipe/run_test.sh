#!/bin/bash

$FC -o hello hello.f90 -v
./hello

$FC -o hello hello.f90 ${LDFLAGS} -v
./hello

$FC -o hello ${FFLAGS} hello.f90 -v
./hello

$FC -o hello ${FFLAGS} hello.f90 -v -L$CONDA_BUILD_SYSROOT/usr/lib
./hello

$FC -o hello ${FFLAGS} hello.f90 ${LDFLAGS} -v
./hello

rm -f hello

$FC -O3 -fopenmp -ffast-math -o maths maths.f90 -v
./maths
rm -f maths

# Verify Fortran / C / C++ interface
cmake .
make
./VerifyFortranC
rm -rf VerifyFortranC CMakeFiles libVerifyFortran.a cmake_install.cmake Makefile CMakeCache.txt

if [[ ! $FFLAGS ]]
then
    exit 1
fi

if [[ ! $LDFLAGS ]]
then
    exit 1
fi
