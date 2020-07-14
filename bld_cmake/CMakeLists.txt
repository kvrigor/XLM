cmake_minimum_required (VERSION 3.14)

project (xlm LANGUAGES C Fortran)

# Set global compile features and definitions
if(UNIX AND NOT APPLE)
    add_compile_definitions(LINUX)
endif()

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    set(cdefs CPRGNU)
    set(cflags -O -std=gnu99)
elseif(CMAKE_C_COMPILER_ID STREQUAL "Intel")
    set(cdefs CPRINTEL)
    set(cflags -qno-opt-dynamic-align -std=gnu99 -O2 "SHELL:-fp-model precise -debug minimal")
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
    set(fdefs CPRGNU)
    set(fflags -ffree-form -ffree-line-length-none -fconvert=big-endian -O)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
    set(fdefs CPRINTEL)
    set(fflags -free -qno-opt-dynamic-align -ftz -traceback -O2 "SHELL:-convert big_endian -assume byterecl -assume realloc_lhs -fp-model source -debug minimal")
endif()

add_compile_options("$<$<COMPILE_LANGUAGE:Fortran>:${fflags}>")
add_compile_options("$<$<COMPILE_LANGUAGE:C>:${cflags}>")
add_compile_definitions("$<$<COMPILE_LANGUAGE:Fortran>:${fdefs}>")
add_compile_definitions($<$<COMPILE_LANGUAGE:C>:${cdefs}>)


# Copied from https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/RPATH-handling#always-full-rpath
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
if("${isSystemDir}" STREQUAL "-1")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
endif("${isSystemDir}" STREQUAL "-1")
# 
# https://cmake.org/cmake/help/v3.17/variable/CMAKE_LANG_COMPILER_ID.html#variable:CMAKE_<LANG>_COMPILER_ID
# add_compile_definitions(
#     $<$<COMPILE_LANG_AND_ID:C,GNU>:CPRGNU>
#     $<$<COMPILE_LANG_AND_ID:C,Intel>:CPRGNU>
# )
#add_compile_definitions(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -fconvert=big-endian -mcmodel=medium>)

add_subdirectory(gptl)
add_subdirectory(mct)
add_subdirectory(pio)
add_subdirectory(csm_share)
add_subdirectory(clm)
add_subdirectory(stubs)
add_subdirectory(datm)
add_subdirectory(mosart)
add_subdirectory(cesm)