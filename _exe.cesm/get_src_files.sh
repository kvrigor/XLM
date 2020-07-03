#!/usr/bin/env bash

copy_cesm () {
    # Paths taken from ../cime/src/build_scripts/buildlib.clm
    mkdir -p src
    cp ../cime/src/drivers/mct/main/* src
    # Remove unnecessary files
    rm src/CMakeLists.txt

    # Generate file list 
    find src \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^src/||" > src/srcFiles.txt
    echo "Number of source files: $(wc -l src/srcFiles.txt)"
    ls -a src
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rf src
    echo "Removed src directory"
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rf src
    copy_cesm
    echo "Copied clm src files"
else
    copy_cesm
fi

# find src \( -iname "*.F90" -or -iname "*.c" \) -exec basename {} \; | sort
