#!/bin/bash -e
rm -rvf bld
if [ ! -d src ]; then
  mkdir -p src && cp -vf ../cime/src/share/timing/* "$_"
  rm -v src/CMakeLists.txt
fi
cp -v CMakeLists.txt src/
cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpifort -DCMAKE_INSTALL_PREFIX=bld
cmake --build bld
cmake --install bld
