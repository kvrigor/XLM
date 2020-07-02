#!/usr/bin/env bash

copy_mosart () {
    mkdir -p src
    cp -rf ../components/mosart/src/cpl src
    cp -rf ../components/mosart/src/riverroute src
    find src \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^src/||" > src/srcFiles.txt
    echo "Number of source files: $(wc -l src/srcFiles.txt)"
    tree src -dL 3
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rvf src
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rvf src
    copy_mosart
else
    copy_mosart
fi