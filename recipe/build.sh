#!/bin/bash

CHOST=${macos_machine}
# We do not use -fopenmp here even though it *may* be possible to.
FFLAGS="-march=nocona -mtune=core2 -ftree-vectorize -fPIC -fstack-protector -O2 -pipe"
DEBUG_FFLAGS="-march=nocona -mtune=core2 -ftree-vectorize -fPIC -fstack-protector -O2 -pipe -Og -g -Wall -Wextra -fcheck=all -fbacktrace -fimplicit-none -fvar-tracking-assignments"

# pushd ${PREFIX}/bin
#   # It is expected this will be built on macOS only:
#   ln -s gfortran ${BUILD}-gfortran
# popd

if [[ "$target_platform" == "osx-64" ]]; then
  export CONDA_BUILD_CROSS_COMPILATION=""
else
  export CONDA_BUILD_CROSS_COMPILATION="1"
fi

find "${RECIPE_DIR}" -name "*activate*.sh" -exec cp {} . \;

find . -name "*activate*.sh" -exec sed -i.bak "s|@CHOST@|${CHOST}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@FFLAGS@|${FFLAGS}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@DEBUG_FFLAGS@|${DEBUG_FFLAGS}|g" "{}" \;
find . -name "*activate*.sh" -exec sed -i.bak "s|@CONDA_BUILD_CROSS_COMPILATION@|${CONDA_BUILD_CROSS_COMPILATION}|g" "{}" \;

mkdir -p ${PREFIX}/etc/conda/{de,}activate.d
cp "${SRC_DIR}"/activate-gfortran.sh ${PREFIX}/etc/conda/activate.d/activate-${PKG_NAME}.sh
cp "${SRC_DIR}"/deactivate-gfortran.sh ${PREFIX}/etc/conda/deactivate.d/deactivate-${PKG_NAME}.sh

# Stop conda-build from following links
rm ${PREFIX}/bin/clang
touch ${PREFIX}/bin/clang

ln -s ${PREFIX}/bin/${CHOST}-ar       $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/ar
ln -s ${PREFIX}/bin/${CHOST}-as       $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/as
ln -s ${PREFIX}/bin/clang             $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/clang
ln -s ${PREFIX}/bin/${CHOST}-nm       $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/nm
ln -s ${PREFIX}/bin/${CHOST}-ranlib   $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/ranlib
ln -s ${PREFIX}/bin/${CHOST}-strip    $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/strip
ln -s ${PREFIX}/bin/${CHOST}-ld       $PREFIX/lib/gcc/${CHOST}/${PKG_VERSION}/ld

