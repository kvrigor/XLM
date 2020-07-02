#!/usr/bin/env bash

copy_esmf () {
    # Paths taken from ../cime/src/build_scripts/buildlib.csm_share
    mkdir -p src/include
    cp -r ../cime/src/share/esmf_wrf_timemgr/* src
    cp ../cime/src/share/esmf_wrf_timemgr/ESMF_TimeMgr.inc src/include
    cp ../cime/src/share/esmf_wrf_timemgr/ESMF_Macros.inc src/include
    # Generate file list 
    find src \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^src/||" > src/srcFiles.txt
    echo "Number of source files: $(wc -l src/srcFiles.txt)"
    tree src -dL 4
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rf src
    echo "Removed src directory"
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rf src
    copy_esmf
    echo "Copied esmf src files"
else
    copy_esmf
fi

# find src \( -iname "*.F90" -or -iname "*.c" \) -exec basename {} \; | sort
