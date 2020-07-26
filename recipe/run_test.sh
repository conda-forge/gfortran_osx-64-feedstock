#!/bin/bash

if [[ "$target_platform" == osx-64 ]]; then
  RUN_EXE=""
else
  RUN_EXE="echo"
  FC="$FC -c"
fi


$FC -o hello hello.f90 -v
$RUN_EXE ./hello

$FC -o hello hello.f90 ${LDFLAGS} -v
$RUN_EXE ./hello

$FC -o hello ${FFLAGS} hello.f90 -v
$RUN_EXE ./hello

$FC -o hello ${FFLAGS} hello.f90 -v -L$CONDA_BUILD_SYSROOT/usr/lib
$RUN_EXE ./hello

$FC -o hello ${FFLAGS} hello.f90 ${LDFLAGS} -v
$RUN_EXE ./hello

rm -f hello

$RUN_EXE $FC -O3 -fopenmp -ffast-math -o maths maths.f90 -v
$RUN_EXE ./maths
rm -f maths

if [[ ! $FFLAGS ]]
then
    exit 1
fi

if [[ ! $LDFLAGS ]]
then
    exit 1
fi
