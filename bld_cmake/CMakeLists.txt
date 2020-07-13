cmake_minimum_required (VERSION 3.17)

project (xlm LANGUAGES C Fortran)

# Global compile definitions
if(UNIX AND NOT APPLE)
    add_compile_definitions(LINUX)
endif()

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    add_compile_definitions($<$<COMPILE_LANGUAGE:C>:CPRGNU>)
elseif(CMAKE_C_COMPILER_ID STREQUAL "Intel")
    add_compile_definitions($<$<COMPILE_LANGUAGE:C>:CPRINTEL>)
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
    add_compile_definitions($<$<COMPILE_LANGUAGE:Fortran>:CPRGNU>)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
    add_compile_definitions($<$<COMPILE_LANGUAGE:Fortran>:CPRINTEL>)
endif()

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