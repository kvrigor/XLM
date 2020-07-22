#!/usr/bin/env bash
set -Eeo pipefail

if [ ! -d src ]; then
    ./get_src_files.sh
fi
if [ -z $CESM_BUILD_PATH ]; then
    CESM_BUILD_PATH=$(pwd)
fi
mkdir -vp $CESM_BUILD_PATH
echo "Build artifacts will be saved to $CESM_BUILD_PATH"

cmake -S src -B $CESM_BUILD_PATH/bld -DCMAKE_C_COMPILER=mpicc \
                    -DCMAKE_Fortran_COMPILER=mpif90 \
                    -DCMAKE_INSTALL_PREFIX=$CESM_BUILD_PATH/run \
                    -DCMAKE_MODULE_PATH=$(pwd)/cmake #-LA --trace
time cmake --build $CESM_BUILD_PATH/bld #--clean-first #--parallel --verbose
cd $CESM_BUILD_PATH/bld
make install
