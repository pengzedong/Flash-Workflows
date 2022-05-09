!!****f* object/setup_flashUnits
!!
!! NAME
!!
!!  setup_getFlashUnits
!!
!!
!! SYNOPSIS
!!
!!
!!  call setup_getFlashUnits(character(len=MAX_STRING_LENGTH) :: unit_names(1:$num_units))
!!
!!  call setup_getFlashUnits(character(len=MAX_STRING_LENGTH) :: unit_names(1:NUM_UNITS))
!!
!!
!! DESCRIPTION
!!
!!  Return a character array of size NUM_UNITS containing
!!  the names of all of the FLASH units used to assemble
!!  the current executable
!!
!!  The unit_names variable should be declared as
!!
!!    include "constants.h"
!!  
!!    character (len=MAX_STRING_LENGTH) :: flash_units(numUnits)
!!
!!  or
!!
!!    character(len=MAX_STRING_LENGTH),ALLOCATABLE :: flash_units(:)
!!
!!
!!  The length of each character string is set to MAX_STRING_LENGTH,
!!  which is defined in the constants.h file.
!!  The proper number of elements to allocate, called numUnits above,
!!  can be inquired at run time with
!!
!!   call setup_getNumFlashUnits(numUnits)
!!
!!  so that an ALLOCATABLE array can be used for flash_units.
!!
!!***

  subroutine setup_getFlashUnits(unit_names)

#include "constants.h"
    implicit none

    integer, PARAMETER :: NUM_UNITS = 36
    character (len=MAX_STRING_LENGTH) :: unit_names(NUM_UNITS)
    integer :: i

    i = 0

    i = i + 1; unit_names(i) = &
"Driver/DriverMain/Unsplit"
    i = i + 1; unit_names(i) = &
"Grid/GridBoundaryConditions"
    i = i + 1; unit_names(i) = &
"Grid/GridMain/AMR/Amrex/levelFlux"
    i = i + 1; unit_names(i) = &
"Grid/GridSolvers/AmrexMultigridSolver"
    i = i + 1; unit_names(i) = &
"Grid/localAPI"
    i = i + 1; unit_names(i) = &
"IO/IOMain/hdf5/AM"
    i = i + 1; unit_names(i) = &
"IO/IOMain/hdf5/parallel/AM"
    i = i + 1; unit_names(i) = &
"IO/IOMain/hdf5/writeGrid/AM"
    i = i + 1; unit_names(i) = &
"IO/localAPI"
    i = i + 1; unit_names(i) = &
"PhysicalConstants/PhysicalConstantsMain"
    i = i + 1; unit_names(i) = &
"RuntimeParameters/RuntimeParametersMain"
    i = i + 1; unit_names(i) = &
"Simulation/SimulationForcing/incompFlow/Heater"
    i = i + 1; unit_names(i) = &
"Simulation/SimulationForcing/incompFlow/Inlet"
    i = i + 1; unit_names(i) = &
"Simulation/SimulationForcing/incompFlow/Outlet/phaseForcing"
    i = i + 1; unit_names(i) = &
"Simulation/SimulationMain/incompFlow/FlowBoiling"
    i = i + 1; unit_names(i) = &
"flashUtilities/contiguousConversion"
    i = i + 1; unit_names(i) = &
"flashUtilities/general"
    i = i + 1; unit_names(i) = &
"flashUtilities/interpolation/oneDim"
    i = i + 1; unit_names(i) = &
"flashUtilities/nameValueLL"
    i = i + 1; unit_names(i) = &
"flashUtilities/system/memoryUsage/legacy"
    i = i + 1; unit_names(i) = &
"monitors/Logfile/LogfileMain"
    i = i + 1; unit_names(i) = &
"monitors/Timers/TimersMain/MPINative"
    i = i + 1; unit_names(i) = &
"numericalTools/Stencils/StencilsAdvection"
    i = i + 1; unit_names(i) = &
"numericalTools/Stencils/StencilsDiffusion"
    i = i + 1; unit_names(i) = &
"numericalTools/Stencils/StencilsLevelset"
    i = i + 1; unit_names(i) = &
"numericalTools/Stencils/StencilsMain"
    i = i + 1; unit_names(i) = &
"numericalTools/Stencils/StencilsTemporal"
    i = i + 1; unit_names(i) = &
"physics/HeatAD/HeatADAdvection"
    i = i + 1; unit_names(i) = &
"physics/HeatAD/HeatADMain/varDiffusion"
    i = i + 1; unit_names(i) = &
"physics/HeatAD/localAPI"
    i = i + 1; unit_names(i) = &
"physics/IncompNS/IncompNSExtras"
    i = i + 1; unit_names(i) = &
"physics/IncompNS/IncompNSMain/varDens"
    i = i + 1; unit_names(i) = &
"physics/IncompNS/localAPI"
    i = i + 1; unit_names(i) = &
"physics/Multiphase/MultiphaseEvap"
    i = i + 1; unit_names(i) = &
"physics/Multiphase/MultiphaseMain"
    i = i + 1; unit_names(i) = &
"physics/Multiphase/localAPI"


    return

  end subroutine setup_getFlashUnits

  subroutine setup_getNumFlashUnits(numUnits)

    implicit none

    integer, intent(out) :: numUnits
    integer, PARAMETER :: NUM_UNITS = 36

    numUnits = NUM_UNITS

    return

  end subroutine setup_getNumFlashUnits

