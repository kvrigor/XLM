cmake_minimum_required (VERSION 3.17)

project (esmf_wrf_timemgr LANGUAGES C Fortran)

add_library(${PROJECT_NAME} STATIC)

include(GNUInstallDirs)

target_include_directories(${PROJECT_NAME} PRIVATE include)
target_include_directories(${PROJECT_NAME} PRIVATE /p/project/XLM/_build/include)

# Fortran files: cat src/srcFiles.txt | grep -E "*.F90$"
target_sources(${PROJECT_NAME} PRIVATE ESMF_BaseMod.F90)
target_sources(${PROJECT_NAME} PRIVATE
    ESMF.F90
    ESMF_AlarmClockMod.F90
    ESMF_AlarmMod.F90    
    ESMF_BaseTimeMod.F90
    ESMF_CalendarMod.F90
    ESMF_ClockMod.F90
    ESMF_FractionMod.F90
    ESMF_ShrTimeMod.F90
    ESMF_Stubs.F90
    ESMF_TimeIntervalMod.F90
    ESMF_TimeMod.F90
    MeatMod.F90
    wrf_error_fatal.F90
    wrf_message.F90
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    Fortran_MODULE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/include)

install (TARGETS ${PROJECT_NAME}
    EXPORT csmshareTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)