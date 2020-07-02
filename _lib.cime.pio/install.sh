#!/bin/bash -e
rm -rvf bld
if [ ! -d src ]; then
    source get_src_files.sh
    copy_pio
fi
cp -v CMakeLists.txt src
export NETCDF_C_PATH=/usr/local
export NETCDF_Fortran_PATH=/usr/local
export PnetCDF_PATH=/usr/local
#cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpif90 -DCMAKE_INSTALL_PREFIX=bld -DUSER_CMAKE_MODULE_PATH:LIST=/p/project/XLM/_lib.cime.pio/_cmake2 --trace-source=CMakeLists.txt
cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpif90 -DCMAKE_INSTALL_PREFIX=/p/project/XLM/_build -DCMAKE_MODULE_PATH=/p/project/XLM/_lib.cime.pio/_cmake2 -DCMAKE_PREFIX_PATH=/p/project/XLM/_build

cmake --build bld
cmake --install bld