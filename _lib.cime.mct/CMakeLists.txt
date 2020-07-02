cmake_minimum_required (VERSION 3.17)

project (mct LANGUAGES Fortran)

add_library(${PROJECT_NAME} STATIC)

include(GNUInstallDirs)
find_package(MPI REQUIRED)

#build requirements
target_compile_definitions(${PROJECT_NAME} PRIVATE CPRGNU NDEBUG)
target_compile_options(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -fconvert=big-endian -mcmodel=medium>)

# TODO: get_zeits.c requires config.h which is auto-fenerated by autotools configure script.
# Skipping this for now!
# target_sources(${PROJECT_NAME} PRIVATE mpeu/get_zeits.c)

# Fortran files: cat src/srcFiles.txt | grep -E "*.F90$"
target_sources(${PROJECT_NAME} PRIVATE 
    mpeu/m_FileResolv.F90
    mpeu/m_stdio.F90
    mpeu/m_IndexBin_integer.F90
    mpeu/m_inpak90.F90
    mpeu/m_dropdead.F90
    mpeu/m_Filename.F90
    mpeu/m_IndexBin_char.F90
    mpeu/m_zeit.F90
    mpeu/m_mpif90.F90
    mpeu/m_mpout.F90
    mpeu/m_mpif.F90
    mpeu/m_Permuter.F90
    mpeu/m_mall.F90
    mpeu/m_SortingTools.F90
    mpeu/m_rankMerge.F90
    mpeu/m_List.F90
    mpeu/m_StrTemplate.F90
    mpeu/m_ioutil.F90
    mpeu/m_MergeSorts.F90
    mpeu/m_FcComms.F90
    mpeu/m_String.F90
    mpeu/m_chars.F90
    mpeu/m_realkinds.F90
    mpeu/m_StringLinkedList.F90
    mpeu/m_flow.F90
    mpeu/m_IndexBin_logical.F90
    mpeu/m_TraceBack.F90
    mpeu/m_die.F90
    mct/m_SparseMatrixPlus.F90
    mct/m_AccumulatorComms.F90
    mct/m_Accumulator.F90
    mct/m_GlobalToLocal.F90
    mct/m_MatAttrVectMul.F90
    mct/m_Router.F90
    mct/m_GlobalSegMap.F90
    mct/m_AttrVectReduce.F90
    mct/m_ConvertMaps.F90
    mct/m_SparseMatrix.F90
    mct/m_SpatialIntegral.F90
    mct/m_GlobalSegMapComms.F90
    mct/m_SparseMatrixToMaps.F90
    mct/m_GlobalMap.F90
    mct/m_AttrVect.F90
    mct/m_Merge.F90
    mct/m_MCTWorld.F90
    mct/m_Rearranger.F90
    mct/m_GeneralGridComms.F90
    mct/m_AttrVectComms.F90
    mct/m_SparseMatrixDecomp.F90
    mct/m_Transfer.F90
    mct/m_GeneralGrid.F90
    mct/m_Navigator.F90
    mct/m_SPMDutils.F90
    mct/m_SpatialIntegralV.F90
    mct/m_ExchangeMaps.F90
    mct/m_SparseMatrixComms.F90
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    Fortran_MODULE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/include)

install (TARGETS ${PROJECT_NAME}
    EXPORT mctTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)