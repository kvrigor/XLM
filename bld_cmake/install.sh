#!/bin/bash

if [ ! -d src ]; then
    source get_src_files.sh
    copy_source_files
fi

if [ -f /etc/FZJ/systemname ]; then
    machine=$(cat /etc/FZJ/systemname)
else
    machine=$(hostname)
fi

if [ $machine = "jureca" ] || [ $machine = "juwels" ]; then
    module purge
    module use $OTHERSTAGES
    module load Stages/2019a
    module load Intel
    module load ParaStationMPI
    module load ESMF
    module load NCO
    module load Perl
    module load CMake
    module load parallel-netcdf
    module load imkl
    module load NCL
    module li
    export NCARG_ROOT=$EBROOTNCL
    export PATH=$NCARG_ROOT/bin:$PATH
    export NETCDF=$EBROOTNETCDF
    export NETCDF_C=$EBROOTNETCDFMINCPLUSPLUS4
    export NETCDF_FORTRAN=$EBROOTNETCDFMINFORTRAN
    export INC_NETCDF=$EBROOTNETCDFMINFORTRAN/include
    export LIB_NETCDF=$EBROOTNETCDFMINFORTRAN/lib
    export PNETCDF=$EBROOTPARALLELMINNETCDF
    export ESMFBIN_PATH=$EBROOTESMF/bin
else
    # Settings for CLM5 Docker
    export NETCDF_C_PATH=/usr/local
    export NETCDF_Fortran_PATH=/usr/local
    export PnetCDF_PATH=/usr/local
fi

rm -rf bld run
cmake -S src -B bld -DCMAKE_C_COMPILER=mpicc \
                    -DCMAKE_Fortran_COMPILER=mpif90 \
                    -DCMAKE_INSTALL_PREFIX=$(pwd)/run \
                    -DCMAKE_MODULE_PATH=$(pwd)/cmake #-LA --trace
cmake --build bld --clean-first #--verbose
#cmake --build bld --target cesm --clean-first
cmake --install bld


# === Dependency graph generation ===
# dot requires graphviz package. 
# On Ubuntu, run `sudo apt-get install graphviz`
#cd bld
#cmake --graphviz=graphfile.dot .
#dot -T svg -o ~/cesm_depgraph.svg graphfile.dot 