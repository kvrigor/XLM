#!/usr/bin/env bash

copy_clm () {
    # Paths taken from ../cime/src/build_scripts/buildlib.clm
    clm_dirs=(
        main
        biogeophys
        biogeochem
        soilbiogeochem
        dyn_subgrid
        init_interp
        fates/main
        fates/biogeophys
        fates/biogeochem
        fates/fire
        fates/parteh
        utils
        cpl
    )
    for src_dir in ${clm_dirs[*]}; do
        dest_dir=src/$src_dir
        mkdir -p $dest_dir
        cp -rf ../src/$src_dir/* $dest_dir
    done

    mkdir -p src/include
    cp ../cime/src/share/include/* src/include
    # Remove unnecessary files

    find src -type f -iname CMakeLists.txt -delete
    rm -rf src/unit_test_shr src/unit_test_stubs
    find src -type d -iname test -exec rm -rf {} +
    genf90=`realpath ../cime/src/externals/genf90/genf90.pl`
    (
    cd src
    #$genf90 config.h.in > config.h
    for file in $(find . -type f -iname "*.F90.in"); do
        $genf90 $file > ${file%.in}
        echo "genf90 > ${file%.in}"
    done
    )

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
    copy_clm
    echo "Copied clm src files"
else
    copy_clm
fi

# find src \( -iname "*.F90" -or -iname "*.c" \) -exec basename {} \; | sort
