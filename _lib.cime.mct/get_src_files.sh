#!/usr/bin/env bash

copy_mct_mpeu () {
    mkdir -p src/mct src/mpeu
    cp -rf ../cime/src/externals/mct/mct/* src/mct
    cp -rf ../cime/src/externals/mct/mpeu/* src/mpeu
    find src \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^src/||" > src/srcFiles.txt
    echo "Number of source files: $(wc -l src/srcFiles.txt)"
    tree src -dL 4
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rf src
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rf src
    copy_mct_mpeu
else
    copy_mct_mpeu
fi