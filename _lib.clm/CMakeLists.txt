cmake_minimum_required (VERSION 3.17)

project (clm LANGUAGES C Fortran)

add_library(${PROJECT_NAME} STATIC)

include(GNUInstallDirs)
find_package(MPI REQUIRED)
if(MPI_FOUND)
    target_compile_definitions(${PROJECT_NAME} PRIVATE HAVE_MPI)
endif(MPI_FOUND)
if(UNIX AND NOT APPLE)
    target_compile_definitions(${PROJECT_NAME} PRIVATE LINUX)
endif()

#build requirements
target_compile_definitions(${PROJECT_NAME} PRIVATE CPRGNU NDEBUG NO_MPI2 PIO1 FORTRANUNDERSCORE NO_R16 CPRGNU HAVE_SLASHPROC)
target_compile_options(${PROJECT_NAME} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:-ffree-form -ffree-line-length-none -mcmodel=medium -fconvert=big-endian>)

target_include_directories(${PROJECT_NAME} PRIVATE include)
target_include_directories(${PROJECT_NAME} PRIVATE /p/project/XLM/_build/include)

# Fortran template files transformed through genf90.pl
target_sources(${PROJECT_NAME} PRIVATE
    init_interp/initInterp2dvar.F90
    utils/restUtilMod.F90
    utils/array_utils.F90
    dyn_subgrid/dynVarTimeInterpMod.F90
    dyn_subgrid/dynVarMod.F90
    dyn_subgrid/dynVarTimeUninterpMod.F90
    main/ncdio_pio.F90
)



# Fortran files: cat src/srcFiles.txt | grep -E "*.F90$"
target_sources(${PROJECT_NAME} PRIVATE 
    utils/clmfates_interfaceMod.F90
    utils/clmfates_paraminterfaceMod.F90
    init_interp/initInterp2dvar.F90
    init_interp/initInterp1dData.F90
    init_interp/initInterpMultilevelSnow.F90
    init_interp/initInterpUtils.F90
    init_interp/initInterpMultilevelContainer.F90
    init_interp/initInterp.F90
    init_interp/initInterpMultilevelBase.F90
    init_interp/initInterpMultilevelInterp.F90
    init_interp/initInterpBounds.F90
    init_interp/initInterpMindist.F90
    init_interp/initInterpMultilevelCopy.F90
    init_interp/initInterpMultilevelSplit.F90
    utils/array_utils.F90
    utils/clm_varorb.F90
    utils/getdatetime.F90
    utils/SimpleMathMod.F90
    utils/quadraticMod.F90
    utils/restUtilMod.F90
    utils/AnnualFluxDribbler.F90
    utils/clm_time_manager.F90
    utils/clm_nlUtilsMod.F90
    utils/domainMod.F90
    utils/spmdGathScatMod.F90
    utils/spmdMod.F90
    utils/fileutils.F90
    cpl/lnd_import_export.F90
    cpl/lnd_comp_mct.F90
    cpl/clm_cpl_indices.F90
    soilbiogeochem/SoilBiogeochemDecompMod.F90
    soilbiogeochem/SoilBiogeochemDecompCascadeBGCMod.F90
    soilbiogeochem/SoilBiogeochemDecompCascadeCNMod.F90
    soilbiogeochem/SoilBiogeochemNitrifDenitrifMod.F90
    soilbiogeochem/SoilBiogeochemCarbonStateType.F90
    soilbiogeochem/SoilBiogeochemVerticalProfileMod.F90
    soilbiogeochem/SoilBiogeochemNLeachingMod.F90
    soilbiogeochem/SoilBiogeochemPotentialMod.F90
    soilbiogeochem/SoilBiogeochemLittVertTranspMod.F90
    soilbiogeochem/SoilBiogeochemNitrogenStateType.F90
    soilbiogeochem/SoilBiogeochemStateType.F90
    soilbiogeochem/SoilBiogeochemNitrogenUptakeMod.F90
    soilbiogeochem/SoilBiogeochemCompetitionMod.F90
    soilbiogeochem/SoilBiogeochemNitrogenFluxType.F90
    soilbiogeochem/SoilBiogeochemCarbonFluxType.F90
    soilbiogeochem/SoilBiogeochemNStateUpdate1Mod.F90
    soilbiogeochem/SoilBiogeochemDecompCascadeConType.F90
    soilbiogeochem/SoilBiogeochemPrecisionControlMod.F90
    biogeophys/LakeCon.F90
    biogeophys/SoilMoistureStreamMod.F90
    biogeophys/QSatMod.F90
    biogeophys/HumanIndexMod.F90
    biogeophys/LunaMod.F90
    biogeophys/SoilWaterMovementMod.F90
    biogeophys/SoilStateInitTimeConstMod.F90
    biogeophys/OzoneOffMod.F90
    biogeophys/SoilMoistStressMod.F90
    biogeophys/UrbanRadiationMod.F90
    biogeophys/SoilHydrologyType.F90
    biogeophys/SoilWaterRetentionCurveClappHornberg1978Mod.F90
    biogeophys/DaylengthMod.F90
    biogeophys/CanopyFluxesMod.F90
    biogeophys/PhotosynthesisMod.F90
    biogeophys/SoilWaterPlantSinkMod.F90
    biogeophys/SolarAbsorbedType.F90
    biogeophys/AerosolMod.F90
    biogeophys/WaterfluxType.F90
    biogeophys/ActiveLayerMod.F90
    biogeophys/GlacierSurfaceMassBalanceMod.F90
    biogeophys/LakeFluxesMod.F90
    biogeophys/UrbanAlbedoMod.F90
    biogeophys/SoilWaterRetentionCurveVanGenuchten1980Mod.F90
    biogeophys/SoilWaterRetentionCurveMod.F90
    biogeophys/SoilHydrologyMod.F90
    biogeophys/BalanceCheckMod.F90
    biogeophys/SnowSnicarMod.F90
    biogeophys/SoilWaterRetentionCurveFactoryMod.F90
    biogeophys/SoilHydrologyInitTimeConstMod.F90
    biogeophys/OzoneBaseMod.F90
    biogeophys/HydrologyNoDrainageMod.F90
    biogeophys/SoilFluxesMod.F90
    biogeophys/UrbanParamsType.F90
    biogeophys/BareGroundFluxesMod.F90
    biogeophys/SurfaceAlbedoType.F90
    biogeophys/LakeTemperatureMod.F90
    biogeophys/LakeStateType.F90
    biogeophys/LakeHydrologyMod.F90
    biogeophys/SurfaceResistanceMod.F90
    biogeophys/CanopyHydrologyMod.F90
    biogeophys/UrbanFluxesMod.F90
    biogeophys/SurfaceRadiationMod.F90
    biogeophys/CanopyTemperatureMod.F90
    biogeophys/EnergyFluxType.F90
    biogeophys/UrbBuildTempOleson2015Mod.F90
    biogeophys/TemperatureType.F90
    biogeophys/IrrigationMod.F90
    biogeophys/RootBiophysMod.F90
    biogeophys/CanopyStateType.F90
    biogeophys/TotalWaterAndHeatMod.F90
    biogeophys/WaterStateType.F90
    biogeophys/SoilTemperatureMod.F90
    biogeophys/OzoneFactoryMod.F90
    biogeophys/SnowHydrologyMod.F90
    biogeophys/SurfaceAlbedoMod.F90
    biogeophys/FrictionVelocityMod.F90
    biogeophys/TridiagonalMod.F90
    biogeophys/HydrologyDrainageMod.F90
    biogeophys/SoilStateType.F90
    biogeophys/BandDiagonalMod.F90
    biogeophys/OzoneMod.F90
    biogeophys/UrbanTimeVarType.F90
    dyn_subgrid/dynLandunitAreaMod.F90
    dyn_subgrid/dynPatchStateUpdaterMod.F90
    dyn_subgrid/dynSubgridDriverMod.F90
    dyn_subgrid/dynColumnTemplateMod.F90
    dyn_subgrid/dynVarTimeInterpMod.F90
    dyn_subgrid/dynInitColumnsMod.F90
    dyn_subgrid/dynSubgridControlMod.F90
    dyn_subgrid/dynVarMod.F90
    dyn_subgrid/dynColumnStateUpdaterMod.F90
    dyn_subgrid/dynFileMod.F90
    dyn_subgrid/dynPriorWeightsMod.F90
    dyn_subgrid/dynEDMod.F90
    dyn_subgrid/dynpftFileMod.F90
    dyn_subgrid/dynTimeInfoMod.F90
    dyn_subgrid/dynVarTimeUninterpMod.F90
    dyn_subgrid/dynConsBiogeophysMod.F90
    dyn_subgrid/dyncropFileMod.F90
    biogeochem/CNAnnualUpdateMod.F90
    biogeochem/CNVegStateType.F90
    biogeochem/CNBalanceCheckMod.F90
    biogeochem/CNCStateUpdate2Mod.F90
    biogeochem/CNFireFactoryMod.F90
    biogeochem/SatellitePhenologyMod.F90
    biogeochem/CNCStateUpdate1Mod.F90
    biogeochem/CNCStateUpdate3Mod.F90
    biogeochem/CNVegNitrogenStateType.F90
    biogeochem/CNFireNoFireMod.F90
    biogeochem/NutrientCompetitionMethodMod.F90
    biogeochem/ch4varcon.F90
    biogeochem/CNFireMethodMod.F90
    biogeochem/CNSpeciesMod.F90
    biogeochem/SpeciesBaseType.F90
    biogeochem/EDBGCDynMod.F90
    biogeochem/CNRootDynMod.F90
    biogeochem/CNNStateUpdate2Mod.F90
    biogeochem/CNGapMortalityMod.F90
    biogeochem/CNSharedParamsMod.F90
    biogeochem/MEGANFactorsMod.F90
    biogeochem/CNC14DecayMod.F90
    biogeochem/CNFireLi2014Mod.F90
    biogeochem/dynCNDVMod.F90
    biogeochem/CNCIsoAtmTimeSeriesReadMod.F90
    biogeochem/CNVegStructUpdateMod.F90
    biogeochem/NutrientCompetitionFlexibleCNMod.F90
    biogeochem/CNCIsoFluxMod.F90
    biogeochem/CNFireBaseMod.F90
    biogeochem/ch4Mod.F90
    biogeochem/CNDVType.F90
    biogeochem/CNMRespMod.F90
    biogeochem/CNGRespMod.F90
    biogeochem/CNFUNMod.F90
    biogeochem/ch4FInundatedStreamType.F90
    biogeochem/CNPrecisionControlMod.F90
    biogeochem/VOCEmissionMod.F90
    biogeochem/CNVegetationFacade.F90
    biogeochem/CNVegCarbonStateType.F90
    biogeochem/CNProductsMod.F90
    biogeochem/NutrientCompetitionFactoryMod.F90
    biogeochem/CNVegCarbonFluxType.F90
    biogeochem/CNDVEstablishmentMod.F90
    biogeochem/CNNStateUpdate1Mod.F90
    biogeochem/SpeciesNonIsotopeType.F90
    biogeochem/CNVegComputeSeedMod.F90
    biogeochem/NutrientCompetitionCLM45defaultMod.F90
    biogeochem/CNDVDriverMod.F90
    biogeochem/CNFireEmissionsMod.F90
    biogeochem/SpeciesIsotopeType.F90
    biogeochem/CNDVLightMod.F90
    biogeochem/CNFireLi2016Mod.F90
    biogeochem/CNPhenologyMod.F90
    biogeochem/dynConsBiogeochemMod.F90
    biogeochem/CNDriverMod.F90
    biogeochem/DryDepVelocity.F90
    biogeochem/FireEmisFactorsMod.F90
    biogeochem/dynHarvestMod.F90
    biogeochem/CNNDynamicsMod.F90
    biogeochem/CNNStateUpdate3Mod.F90
    biogeochem/DUSTMod.F90
    biogeochem/CNVegNitrogenFluxType.F90
    biogeochem/CropType.F90
    main/abortutils.F90
    main/PatchType.F90
    main/accumulMod.F90
    main/atm2lndMod.F90
    main/GridcellType.F90
    main/ndepStreamMod.F90
    main/organicFileMod.F90
    main/initSubgridMod.F90
    main/landunit_varcon.F90
    main/glcBehaviorMod.F90
    main/atm2lndType.F90
    main/clm_varpar.F90
    main/ncdio_pio.F90
    main/glc2lndMod.F90
    main/clm_driver.F90
    main/histFileMod.F90
    main/filterMod.F90
    main/lnd2glcMod.F90
    main/subgridRestMod.F90
    main/pftconMod.F90
    main/readParamsMod.F90
    main/initGridCellsMod.F90
    main/clm_varsur.F90
    main/clm_varctl.F90
    main/controlMod.F90
    main/column_varcon.F90
    main/lnd2atmMod.F90
    main/LandunitType.F90
    main/surfrdUtilsMod.F90
    main/subgridAveMod.F90
    main/clm_initializeMod.F90
    main/clm_instMod.F90
    main/init_hydrology.F90
    main/ColumnType.F90
    main/FuncPedotransferMod.F90
    main/surfrdMod.F90
    main/lnd2atmType.F90
    main/decompMod.F90
    main/TopoMod.F90
    main/restFileMod.F90
    main/reweightMod.F90
    main/subgridMod.F90
    main/subgridWeightsMod.F90
    main/decompInitMod.F90
    main/initVerticalMod.F90
    main/ncdio_utils.F90
    main/GetGlobalValuesMod.F90
    main/clm_varcon.F90
    main/paramUtilMod.F90
    main/filterColMod.F90
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    Fortran_MODULE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/include)

install (TARGETS ${PROJECT_NAME}
    EXPORT csmshareTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)