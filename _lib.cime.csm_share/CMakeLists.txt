cmake_minimum_required (VERSION 3.17)

project (csm_share LANGUAGES C Fortran)

add_library(${PROJECT_NAME} STATIC)

include(GNUInstallDirs)
find_package(MPI REQUIRED)
if(MPI_FOUND)
    target_compile_definitions(${PROJECT_NAME} PRIVATE HAVE_MPI)
endif(MPI_FOUND)
if(UNIX AND NOT APPLE)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LINUX)
endif()
#target_compile_definitions(${PROJECT_NAME} PRIVATE FORTRANUNDERSCORE HAVE_SLASHPROC _PNETCDF)

#build requirements
target_compile_definitions(${PROJECT_NAME} PRIVATE CPRGNU NDEBUG NO_MPI2 PIO1 FORTRANUNDERSCORE NO_R16 CPRGNU HAVE_SLASHPROC)
target_compile_definitions(${PROJECT_NAME} PRIVATE 
NUM_COMP_INST_ATM=1
NUM_COMP_INST_LND=1
NUM_COMP_INST_ICE=1
NUM_COMP_INST_OCN=1
NUM_COMP_INST_ROF=1
NUM_COMP_INST_GLC=1
NUM_COMP_INST_WAV=1
NUM_COMP_INST_ESP=1
)

#if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
target_compile_options(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -mcmodel=medium -fconvert=big-endian>)
#endif()

target_include_directories(${PROJECT_NAME} PRIVATE include)
target_include_directories(${PROJECT_NAME} PRIVATE /p/project/XLM/_build/include)

# C files: cat src/srcFiles.txt | grep -E "*.c$"
target_sources(${PROJECT_NAME} PRIVATE
share/RandNum/src/dsfmt_f03/dSFMT.c
share/RandNum/src/dsfmt_f03/dSFMT_utils.c
share/RandNum/src/kissvec/kissvec.c
share/util/shr_reprosumx86.c
)

# Fortran files: cat src/srcFiles.txt | grep -E "*.F90$"
target_sources(${PROJECT_NAME} PRIVATE 
    drivers/mct/shr/shr_fire_emis_mod.F90
    drivers/mct/shr/shr_ndep_mod.F90
    drivers/mct/shr/seq_io_read_mod.F90
    drivers/mct/shr/shr_expr_parser_mod.F90
    drivers/mct/shr/seq_infodata_mod.F90
    drivers/mct/shr/seq_comm_mct.F90
    drivers/mct/shr/seq_drydep_mod.F90
    drivers/mct/shr/seq_timemgr_mod.F90
    drivers/mct/shr/glc_elevclass_mod.F90
    drivers/mct/shr/shr_carma_mod.F90
    drivers/mct/shr/shr_megan_mod.F90
    drivers/mct/shr/seq_cdata_mod.F90
    drivers/mct/shr/seq_flds_mod.F90
    share/RandNum/src/kissvec/kissvec_mod.F90
    share/RandNum/src/shr_RandNum_mod.F90
    share/RandNum/src/dsfmt_f03/dSFMT_interface.F90
    share/RandNum/src/mt19937/mersennetwister_mod.F90
    share/streams/shr_stream_mod.F90
    share/streams/shr_strdata_mod.F90
    share/streams/shr_tInterp_mod.F90
    share/streams/shr_dmodel_mod.F90
    share/util/shr_flds_mod.F90
    share/util/shr_strconvert_mod.F90
    share/util/shr_infnan_mod.F90
    share/util/mct_mod.F90
    share/util/shr_frz_mod.F90
    share/util/shr_scam_mod.F90
    share/util/shr_sys_mod.F90
    share/util/shr_kind_mod.F90
    share/util/shr_timer_mod.F90
    share/util/shr_pio_mod.F90
    share/util/water_isotopes.F90
    share/util/shr_ncread_mod.F90
    share/util/shr_mct_mod.F90
    share/util/shr_cal_mod.F90
    share/util/shr_orb_mod.F90
    share/util/shr_flux_mod.F90
    share/util/shr_spfn_mod.F90
    share/util/shr_string_mod.F90
    share/util/water_types.F90
    share/util/shr_reprosum_mod.F90
    share/util/shr_wv_sat_mod.F90
    share/util/shr_assert_mod.F90
    share/util/shr_msg_mod.F90
    share/util/shr_const_mod.F90
    share/util/shr_file_mod.F90
    share/util/shr_nl_mod.F90
    share/util/shr_log_mod.F90
    share/util/shr_map_mod.F90
    share/util/shr_vmath_mod.F90
    share/util/shr_mpi_mod.F90
    share/util/shr_abort_mod.F90
    share/util/shr_mem_mod.F90
    share/util/shr_precip_mod.F90
    share/util/shr_pcdf_mod.F90
)

# configure_file(shr_assert_mod.F90.in shr_assert_mod.F90)
# configure_file(shr_frz_mod.F90.in shr_frz_mod.F90)
# configure_file(shr_infnan_mod.F90.in shr_infnan_mod.F90)


set_target_properties(${PROJECT_NAME} PROPERTIES
    Fortran_MODULE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/include)

install (TARGETS ${PROJECT_NAME}
    EXPORT csmshareTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)