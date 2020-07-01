#!/bin/bash -e
rm -rvf bld
if [ ! -d src ]; then
    source get_src_files.sh
    copy_mct_mpeu
fi
cp -v CMakeLists.txt src/
cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpif90 -DCMAKE_INSTALL_PREFIX=/p/project/XLM/_build
cmake --build bld
cmake --install bld
