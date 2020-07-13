#!/usr/bin/env bash

set -Eeo pipefail
cime_src=../cime/src
genf90=`realpath $cime_src/externals/genf90/genf90.pl`

copy_cmake_modules() {
    mkdir -p cmake
    cp -rf $cime_src/externals/pio2/cmake/* cmake
    echo "Imported CMake modules"
}

copy_gptl () {
    lib_folder=src/gptl
    mkdir -p $lib_folder && cp $cime_src/share/timing/* "$_"
    echo "Imported GPTL source files"
}

copy_mct () {
    lib_folder=src/mct
    mkdir -p $lib_folder/mct $lib_folder/mpeu 
    cp -rf $cime_src/externals/mct/mct/* $lib_folder/mct
    cp -rf $cime_src/externals/mct/mpeu/* $lib_folder/mpeu

    # Hack script in order to generate config.h
    (
        mkdir -p $lib_folder/temp
        cp -rf $cime_src/externals/mct/* $lib_folder/temp
        cd $lib_folder/temp
        ./configure 1>/dev/null
        mv config.h ../mpeu/config.h 
        cd ..
        rm -rf $lib_folder/temp
    )
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    echo "Imported MCT source files"
}

copy_pio () {
    lib_folder=src/pio
    mkdir -p $lib_folder
    cp -rf $cime_src/externals/pio1/pio/* $lib_folder
    
    (
    cd $lib_folder
    #$genf90 config.h.in > config.h
    for file in ./*.F90.in; do
        $genf90 $file > ${file%.in}
    done
    rm CMakeLists.txt fdepends.awk README.config Makefile.conf.in
    )
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    find $lib_folder -iname "*.in" | sort > $lib_folder/inFiles.txt
    echo "Imported PIO source files"
}

copy_esmf () {
    lib_folder=src/4_esmf
    mkdir -p $lib_folder/include
    cp -r $cime_src/share/esmf_wrf_timemgr/* $lib_folder
    cp $cime_src/share/esmf_wrf_timemgr/ESMF_TimeMgr.inc $lib_folder/include
    cp $cime_src/share/esmf_wrf_timemgr/ESMF_Macros.inc $lib_folder/include
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    echo "Imported ESMF source files"
}

copy_csm_share () {
    lib_folder=src/csm_share
    csm_share_dirs=(
        drivers/mct/shr
        share/streams
        share/util
        share/RandNum/src
        share/esmf_wrf_timemgr
    )
    for src_dir in ${csm_share_dirs[*]}; do
        dest_dir=$lib_folder/$src_dir
        mkdir -p $dest_dir
        cp -rf $cime_src/$src_dir/* $dest_dir
    done

    # copy include files
    mkdir -p $lib_folder/include
    cp $cime_src/share/include/* $lib_folder/include
    cp $cime_src/share/RandNum/include/* $lib_folder/include
    cp $cime_src/share/esmf_wrf_timemgr/ESMF_TimeMgr.inc $lib_folder/include
    cp $cime_src/share/esmf_wrf_timemgr/ESMF_Macros.inc $lib_folder/include

    # Remove unnecessary files
    find $lib_folder -type f -iname CMakeLists.txt -delete
    rm -rf $cime_src/share/esmf_wrf_timemgr/unittests

    # Convert .in files to valid Fortran files
    (
    cd $lib_folder/share/util
    $genf90 shr_assert_mod.F90.in > shr_assert_mod.F90
    $genf90 shr_frz_mod.F90.in > shr_frz_mod.F90
    $genf90 shr_infnan_mod.F90.in > shr_infnan_mod.F90
    # rm shr_assert_mod.F90.in
    # rm shr_frz_mod.F90.in
    # rm shr_infnan_mod.F90.in
    )

    # Generate file list 
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    find $lib_folder -iname "*.in" | sort > $lib_folder/inFiles.txt
    echo "Imported CSM share source files"
}

copy_clm () {
    lib_folder=src/clm
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
        dest_dir=$lib_folder/$src_dir
        mkdir -p $dest_dir
        cp -rf ../src/$src_dir/* $dest_dir
    done

    mkdir -p $lib_folder/include
    cp $cime_src/share/include/* $lib_folder/include
    # Remove unnecessary files

    find $lib_folder -type f -iname CMakeLists.txt -delete
    rm -rf $lib_folder/unit_test_shr $lib_folder/unit_test_stubs
    find $lib_folder -type d -iname test -exec rm -rf {} +
    (
    cd $lib_folder
    for file in $(find . -type f -iname "*.F90.in"); do
        $genf90 $file > ${file%.in}
    done
    )
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    find $lib_folder -iname "*.in" | sort > $lib_folder/inFiles.txt
    echo "Imported CLM source files"
}

copy_stubs () {
    lib_folder=src/stubs
    mkdir -p $lib_folder 
    cp $cime_src/components/stub_comps/sglc/cpl/glc_comp_mct.F90 $lib_folder
    cp $cime_src/components/stub_comps/socn/cpl/ocn_comp_mct.F90 $lib_folder
    cp $cime_src/components/stub_comps/sesp/cpl/esp_comp_mct.F90 $lib_folder
    cp $cime_src/components/stub_comps/sice/cpl/ice_comp_mct.F90 $lib_folder
    cp $cime_src/components/stub_comps/swav/cpl/wav_comp_mct.F90 $lib_folder
    echo "Imported stub components source files"
}

copy_datm () {
    lib_folder=src/datm
    mkdir -p $lib_folder
    cp $cime_src/components/data_comps/datm/datm_shr_mod.F90 $lib_folder
    cp $cime_src/components/data_comps/datm/datm_comp_mod.F90 $lib_folder
    cp $cime_src/components/data_comps/datm/mct/atm_comp_mct.F90 $lib_folder
    echo "Imported datm source files"
}

copy_mosart () {
    lib_folder=src/mosart
    mkdir -p $lib_folder
    cp -rf ../components/mosart/src/cpl $lib_folder
    cp -rf ../components/mosart/src/riverroute $lib_folder
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    echo "Imported mosart source files"
}

copy_cesm () {
    lib_folder=src/cesm
    mkdir -p $lib_folder
    cp $cime_src/drivers/mct/main/* $lib_folder
    # Remove unnecessary files
    rm $lib_folder/CMakeLists.txt
    find $lib_folder \( -iname "*.F90" -or -iname "*.c" \) | sed -e "s|^$lib_folder/||" > $lib_folder/srcFiles.txt
    echo "Imported cesm source files"
}



backup_cmakelists() {
    if [ -d src ]; then
        (
            cd src
            [ -f CMakeLists.txt ] && cp -f CMakeLists.txt ../CMakeLists.txt
            [ -f gptl/CMakeLists.txt ] && cp -f gptl/CMakeLists.txt ../CMakeLists_gptl.txt
            [ -f mct/CMakeLists.txt ] && cp -f mct/CMakeLists.txt ../CMakeLists_mct.txt
            [ -f pio/CMakeLists.txt ] && cp -f pio/CMakeLists.txt ../CMakeLists_pio.txt
            [ -f csm_share/CMakeLists.txt ] && cp -f csm_share/CMakeLists.txt ../CMakeLists_csm_share.txt
            [ -f clm/CMakeLists.txt ] && cp -f clm/CMakeLists.txt ../CMakeLists_clm.txt
            [ -f stubs/CMakeLists.txt ] && cp -f stubs/CMakeLists.txt ../CMakeLists_stubs.txt
            [ -f datm/CMakeLists.txt ] && cp -f datm/CMakeLists.txt ../CMakeLists_datm.txt
            [ -f mosart/CMakeLists.txt ] && cp -f mosart/CMakeLists.txt ../CMakeLists_mosart.txt
            [ -f cesm/CMakeLists.txt ] && cp -f cesm/CMakeLists.txt ../CMakeLists_cesm.txt
        )
    else
        echo "No cmakelists"
    fi
}

import_cmakelists() {
    cp -vf CMakeLists.txt src/
    cp -vf CMakeLists_gptl.txt src/gptl/CMakeLists.txt
    cp -vf CMakeLists_mct.txt src/mct/CMakeLists.txt
    cp -vf CMakeLists_pio.txt src/pio/CMakeLists.txt
    cp -vf CMakeLists_csm_share.txt src/csm_share/CMakeLists.txt
    cp -vf CMakeLists_clm.txt src/clm/CMakeLists.txt
    cp -vf CMakeLists_stubs.txt src/stubs/CMakeLists.txt
    cp -vf CMakeLists_datm.txt src/datm/CMakeLists.txt
    cp -vf CMakeLists_mosart.txt src/mosart/CMakeLists.txt
    cp -vf CMakeLists_cesm.txt src/cesm/CMakeLists.txt
}

copy_source_files() {
    copy_cmake_modules
    copy_gptl
    copy_mct
    copy_pio
    copy_csm_share
    copy_clm
    copy_stubs
    copy_datm
    copy_mosart
    copy_cesm
    import_cmakelists
}

if [ "$1" = "--delete" ] || [ "$1" = "-d" ]; then
    backup_cmakelists
    rm -rf src cmake bld run
    echo "Removed src directory"
elif [ "$1" = "--clean" ] || [ "$1" = "-c" ]; then
    backup_cmakelists
    rm -rf src cmake bld run
    copy_source_files
else
    copy_source_files
fi



