#!/usr/bin/env bash

set -Eeo pipefail

if [ ! -d src ]; then
    ./get_src_files.sh
fi

outpath="$SCRATCH/$USER/XLM_build/$machine"
mkdir -vp $outpath
echo "Build artifacts will be saved to $outpath"
#rm -rf $outpath/bld $outpath/run
cmake -S src -B $outpath/bld -DCMAKE_C_COMPILER=mpicc \
                    -DCMAKE_Fortran_COMPILER=mpif90 \
                    -DCMAKE_INSTALL_PREFIX=$outpath/run \
                    -DCMAKE_MODULE_PATH=$(pwd)/cmake #-LA --trace
cmake --build $outpath/bld #--clean-first #--parallel --verbose
cmake --install $outpath/bld


# === Dependency graph generation ===
# dot requires graphviz package. 
# On Ubuntu, run `sudo apt-get install graphviz`
#cd bld
#cmake --graphviz=graphfile.dot .
#dot -T svg -o ~/cesm_depgraph.svg graphfile.dot 
