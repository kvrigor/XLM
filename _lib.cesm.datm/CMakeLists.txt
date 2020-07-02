cmake_minimum_required (VERSION 3.17)

project (atm LANGUAGES Fortran)

include(GNUInstallDirs)
add_library(${PROJECT_NAME} STATIC)
target_compile_definitions(${PROJECT_NAME} PRIVATE LINUX CPRGNU NDEBUG NO_MPI2 PIO1 FORTRANUNDERSCORE NO_R16 CPRGNU HAVE_SLASHPROC)
target_compile_options(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -mcmodel=medium -fconvert=big-endian>)
target_include_directories(${PROJECT_NAME} PRIVATE /p/project/XLM/_build/include)

target_sources(${PROJECT_NAME} PRIVATE 
    datm_shr_mod.F90
    datm_comp_mod.F90
    atm_comp_mct.F90
)

install (TARGETS ${PROJECT_NAME}
EXPORT "${PROJECT_NAME}Targets"
ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)



