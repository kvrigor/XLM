#!/usr/bin/env bash

copy_pio () {
    mkdir -p src _cmake2
    cp -rf ../cime/src/externals/pio1/pio/* src
    cp -rf ../cime/src/externals/pio2/cmake/* _cmake2
    # Convert .in files to valid Fortran files
    genf90=`realpath ../cime/src/externals/genf90/genf90.pl`
    (
    cd src
    #$genf90 config.h.in > config.h
    for file in ./*.F90.in; do
        $genf90 $file > ${file%.in}
    done
    rm CMakeLists.txt fdepends.awk README.config Makefile.conf.in
    )
    find src \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^src/||" > src/srcFiles.txt
    echo "Number of source files: $(wc -l src/srcFiles.txt)"
    ls -1 src
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rf src _cmake2
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rf src _cmake2
    copy_pio
else
    copy_pio
fi