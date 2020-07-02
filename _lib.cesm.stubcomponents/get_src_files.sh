#!/usr/bin/env bash

copy_stubs () {
    mkdir -p src 
    cp -v ../cime/src/components/stub_comps/sglc/cpl/glc_comp_mct.F90 src
    cp -v ../cime/src/components/stub_comps/socn/cpl/ocn_comp_mct.F90 src
    cp -v ../cime/src/components/stub_comps/sesp/cpl/esp_comp_mct.F90 src
    cp -v ../cime/src/components/stub_comps/sice/cpl/ice_comp_mct.F90 src
    cp -v ../cime/src/components/stub_comps/swav/cpl/wav_comp_mct.F90 src
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rvf src
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rvf src
    copy_stubs
else
    copy_stubs
fi