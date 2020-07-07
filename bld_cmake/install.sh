#!/bin/bash -e
rm -rvf bld
if [ ! -d src ]; then
    source get_src_files.sh
    #copy_source_files
fi

#cp -vf CMakeLists.txt src/
#cp -vf CMakeLists_gptl.txt src/gptl/CMakeLists.txt
#cp -vf CMakeLists_mct.txt src/mct/CMakeLists.txt
#cp -vf CMakeLists_pio.txt src/pio/CMakeLists.txt
#cp -vf CMakeLists_csm_share.txt src/csm_share/CMakeLists.txt

cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpif90 -DCMAKE_INSTALL_PREFIX=/p/project/XLM/bld_cmake/_build -DCMAKE_MODULE_PATH=/p/project/XLM/bld_cmake/cmake
cmake --build bld
cmake --install bld