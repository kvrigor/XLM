#!/usr/bin/env bash
# usage: source loadenvs.sh

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