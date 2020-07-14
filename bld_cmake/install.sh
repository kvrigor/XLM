#!/usr/bin/env bash

set -Eeo pipefail

if [ ! -d src ]; then
    ./get_src_files.sh
fi

rm -rf bld run
cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc \
                    -DCMAKE_Fortran_COMPILER=mpif90 \
                    -DCMAKE_INSTALL_PREFIX=$(pwd)/run \
                    -DCMAKE_MODULE_PATH=$(pwd)/cmake #-LA --trace
cmake --build bld --clean-first #--parallel --verbose
#cmake --build bld --target csm_share --clean-first
cmake --install bld


# === Dependency graph generation ===
# dot requires graphviz package. 
# On Ubuntu, run `sudo apt-get install graphviz`
#cd bld
#cmake --graphviz=graphfile.dot .
#dot -T svg -o ~/cesm_depgraph.svg graphfile.dot 
