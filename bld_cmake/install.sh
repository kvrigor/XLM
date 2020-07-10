#!/bin/bash -e
rm -rvf bld
if [ ! -d src ]; then
    source get_src_files.sh
    copy_source_files
fi

export NETCDF_C_PATH=/usr/local
export NETCDF_Fortran_PATH=/usr/local
export PnetCDF_PATH=/usr/local
cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpif90 -DCMAKE_INSTALL_PREFIX=/p/project/XLM/bld_cmake/_build -DCMAKE_MODULE_PATH=/p/project/XLM/bld_cmake/cmake #--trace
#cmake --build bld
cmake --build bld --target cesm --verbose --clean-first
#cmake --build bld --target rof --verbose --clean-first
cmake --install bld

#cmake --graphviz=test.dot .
# rm cmake_buildlog && ./install.sh |& tee -a cmake_buildlog