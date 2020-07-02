#!/usr/bin/env bash

copy_datm () {
    mkdir -p src 
    cp -v ../cime/src/components/data_comps/datm/datm_shr_mod.F90 src
    cp -v ../cime/src/components/data_comps/datm/datm_comp_mod.F90 src
    cp -v ../cime/src/components/data_comps/datm/mct/atm_comp_mct.F90 src
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rvf src
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rvf src
    copy_datm
else
    copy_datm
fi