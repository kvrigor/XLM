cmake_minimum_required (VERSION 3.17)

project (stubcomponents LANGUAGES Fortran)

include(GNUInstallDirs)
foreach(component glc wav ice esp ocn)
    add_library(${component} STATIC)
    target_compile_definitions(${component} PRIVATE LINUX CPRGNU NDEBUG NO_MPI2 PIO1 FORTRANUNDERSCORE NO_R16 CPRGNU HAVE_SLASHPROC)
    target_compile_options(${component} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -mcmodel=medium -fconvert=big-endian>)
    target_include_directories(${component} PRIVATE /p/project/XLM/_build/include)
    if(${component} STREQUAL glc)
        target_sources(glc PRIVATE glc_comp_mct.F90)
    elseif(${component} STREQUAL wav)
        target_sources(wav PRIVATE wav_comp_mct.F90)
    elseif(${component} STREQUAL ice)
        target_sources(ice PRIVATE ice_comp_mct.F90)
    elseif(${component} STREQUAL esp)
        target_sources(esp PRIVATE esp_comp_mct.F90)
    elseif(${component} STREQUAL ocn)
        target_sources(ocn PRIVATE ocn_comp_mct.F90)
    endif()
    install (TARGETS ${component}
    EXPORT "${component}Targets"
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )
endforeach(component)



