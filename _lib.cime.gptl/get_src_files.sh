#!/usr/bin/env bash

gptl_dir=../cime/src/share/timing
if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    rm -rvf src
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    rm -rvf src
    mkdir -p src && cp -vf $gptl_dir/* "$_"
else
    mkdir -p src && cp -vf $gptl_dir/* "$_"
fi