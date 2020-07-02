cmake_minimum_required (VERSION 3.17)

project (rof LANGUAGES Fortran)

include(GNUInstallDirs)
add_library(${PROJECT_NAME} STATIC)
target_compile_definitions(${PROJECT_NAME} PRIVATE LINUX CPRGNU NDEBUG NO_MPI2 PIO1 FORTRANUNDERSCORE NO_R16 CPRGNU HAVE_SLASHPROC)
target_compile_options(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -mcmodel=medium -fconvert=big-endian>)
target_include_directories(${PROJECT_NAME} PRIVATE /p/project/XLM/_build/include)

target_sources(${PROJECT_NAME} PRIVATE 
    cpl/rof_cpl_indices.F90
    cpl/rof_comp_mct.F90
    riverroute/RtmIO.F90
    riverroute/MOSART_physics_mod.F90
    riverroute/RtmRestFile.F90
    riverroute/RtmMod.F90
    riverroute/RtmDateTime.F90
    riverroute/RtmFileUtils.F90
    riverroute/RtmVar.F90
    riverroute/RtmHistFile.F90
    riverroute/RtmSpmd.F90
    riverroute/RtmHistFlds.F90
    riverroute/RunoffMod.F90
    riverroute/RtmTimeManager.F90
)

install (TARGETS ${PROJECT_NAME}
EXPORT "${PROJECT_NAME}Targets"
ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)



