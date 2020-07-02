#!/usr/bin/env bash

copy_csm_share () {
    # Paths taken from ../cime/src/build_scripts/buildlib.csm_share
    csm_share_dirs=(
        drivers/mct/shr
        share/streams
        share/util
        share/RandNum/src
    )
    for src_dir in ${csm_share_dirs[*]}; do
        dest_dir=src/$src_dir
        mkdir -p $dest_dir
        cp -rf ../cime/src/$src_dir/* $dest_dir
    done

    # copy include files
    mkdir -p src/include
    cp ../cime/src/share/include/* src/include
    cp ../cime/src/share/RandNum/include/* src/include

    # Remove unnecessary files
    find src -type f -iname CMakeLists.txt -delete

    # Convert .in files to valid Fortran files
    genf90=`realpath ../cime/src/externals/genf90/genf90.pl`
    (
    cd src/share/util
    $genf90 shr_assert_mod.F90.in > shr_assert_mod.F90
    $genf90 shr_frz_mod.F90.in > shr_frz_mod.F90
    $genf90 shr_infnan_mod.F90.in > shr_infnan_mod.F90
    # rm shr_assert_mod.F90.in
    # rm shr_frz_mod.F90.in
    # rm shr_infnan_mod.F90.in
    )

    # Generate file list 
    find src \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^src/||" > src/srcFiles.txt
    find src -iname "*.in" | sort > src/inFiles.txt
    echo "Number of source files: $(wc -l src/srcFiles.txt)"
    tree src -dL 4
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rf src
    echo "Removed src directory"
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rf src
    copy_csm_share
    echo "Copied csm_share src files"
else
    copy_csm_share
fi

# find src \( -iname "*.F90" -or -iname "*.c" \) -exec basename {} \; | sort
