!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! File created at setup time.  DO NOT EDIT !!!

subroutine Simulation_mapIntToStr(key, str, map)
    use Grid_interface, only: Grid_formatNonRep
    use Driver_interface, only: Driver_getMype, Driver_getNumProcs
    use RuntimeParameters_interface, only: RuntimeParameters_get
    implicit none 
#include "constants.h"
#include "Simulation.h"
    integer, intent(in) :: key, map
    character(len=*), intent(inout) :: str

    integer, parameter :: locunk1(0:NONREP_COUNT) = NONREP_LOCUNK1
    integer, parameter :: maxlocs(0:NONREP_COUNT) = NONREP_MAXLOCS
    character(len=*), parameter :: rpcount_flat = NONREP_RPCOUNT_FLAT
    integer, parameter :: rpcount_start(NONREP_COUNT+1) = NONREP_RPCOUNT_START
    
    integer :: mesh, meshes
    integer :: k, nonrep, nglob, iglob, iloc
    
    call Driver_getMype(MESH_ACROSS_COMM, mesh)
    call Driver_getNumProcs(MESH_ACROSS_COMM, meshes)
 
    k = key + map*MAPBLOCKSIZE
    select case(k)
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  1); str="alph"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  2); str="dfrc"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  3); str="dfun"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  4); str="dust"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  5); str="hdn0"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  6); str="hfgs"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  7); str="hflq"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  8); str="htn0"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) +  9); str="htn1"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 10); str="mflx"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 11); str="nrmx"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 12); str="nrmy"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 13); str="nrmz"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 14); str="omgm"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 15); str="pres"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 16); str="temp"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 17); str="tfrc"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 18); str="tvis"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 19); str="velx"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 20); str="vely"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 21); str="velz"
    case((MAPBLOCK_UNK  * MAPBLOCKSIZE) + 22); str="visc"
    case((MAPBLOCK_FLUX * MAPBLOCKSIZE)+  1); str="velc"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  1); str="hvn0"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  2); str="hvn1"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  3); str="pgn1"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  4); str="pgn2"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  5); str="rhof"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  6); str="sigm"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  7); str="velc"
    case((MAPBLOCK_FACES * MAPBLOCKSIZE)+  8); str="vfrc"
    case default; str = "err"
    end select

    do nonrep=1, NONREP_COUNT
        if(locunk1(nonrep) <= k .and. k - locunk1(nonrep) < maxlocs(nonrep)) then
            iloc = k - locunk1(nonrep) + 1
            ! get the size of this nonrep array
            call RuntimeParameters_get(rpcount_flat(rpcount_start(nonrep):rpcount_start(nonrep+1)-1), nglob)
            iglob = NONREP_LOC2GLOB(iloc, mesh, meshes)
            if(iglob .gt. nglob) then
                str = "err"
                return
            end if
            call Grid_formatNonRep(nonrep, iglob, str)
            exit
        end if
    end do
end subroutine Simulation_mapIntToStr
