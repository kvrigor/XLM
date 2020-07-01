cmake_minimum_required (VERSION 3.17)

project (pio LANGUAGES C Fortran)

add_library(${PROJECT_NAME} STATIC)

include(GNUInstallDirs)
find_package(MPI REQUIRED)
find_package(NetCDF COMPONENTS C Fortran)
find_package(PnetCDF REQUIRED COMPONENTS Fortran)

#build requirements
target_compile_definitions(${PROJECT_NAME} PRIVATE TIMING LINUX NDEBUG NO_MPI2 PIO1 FORTRANUNDERSCORE NO_R16 CPRGNU HAVE_SLASHPROC _NO_MPI_RSEND _NETCDF _NOPNETCDF _NOUSEMCT _USEBOX) #TIMING
target_compile_options(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -fconvert=big-endian -mcmodel=medium>)

target_sources(${PROJECT_NAME} PRIVATE 
    alloc_mod.F90
    box_rearrange.F90
    calcdecomp.F90
    calcdisplace_mod.F90
    iompi_mod.F90
    ionf_mod.F90
    nf_mod.F90 
    piodarray.F90
    pio.F90
    pio_kinds.F90
    piolib_mod.F90
    pio_mpi_utils.F90
    pio_msg_callbacks.F90
    pio_msg_getput_callbacks.F90
    pio_msg_mod.F90
    pionfatt_mod.F90
    pionfget_mod.F90
    pionfput_mod.F90
    pionfread_mod.F90
    pio_nf_utils.F90
    pionfwrite_mod.F90
    pio_spmd_utils.F90
    pio_support.F90
    pio_types.F90
    pio_utils.F90
    rearrange.F90
    topology.c
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    Fortran_MODULE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/include)

install (TARGETS ${PROJECT_NAME}
    EXPORT mctTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)