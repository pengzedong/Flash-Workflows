!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! File created at setup time.  DO NOT EDIT !!!
!!

subroutine Simulation_getVarnameType(varname,vartype)
implicit none 

#include "constants.h"
#include "Simulation.h"

   integer, intent(out) :: vartype
   integer, intent(in) :: varname
   integer :: ctr

   !! varnames is an array of possible input strings (with possibly extra spaces)
   !! vartypes is an array of corresponding answers

   integer, dimension(1:22), parameter :: varnames = (/&
   & ALPH_VAR, DFRC_VAR, DFUN_VAR, DUST_VAR, HDN0_VAR, &
     HFGS_VAR, HFLQ_VAR, HTN0_VAR, HTN1_VAR, MFLX_VAR, &
     NRMX_VAR, NRMY_VAR, NRMZ_VAR, OMGM_VAR, PRES_VAR, &
     TEMP_VAR, TFRC_VAR, TVIS_VAR, VELX_VAR, VELY_VAR, &
     VELZ_VAR, VISC_VAR &
   &/)

   integer, dimension(1:22), parameter :: vartypes = (/&
   & VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC,&
     VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC,&
     VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC,&
     VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC, VARTYPE_GENERIC,&
     VARTYPE_GENERIC, VARTYPE_GENERIC &
   &/)

   ! Species and mass scalars are kept in primitive form. - KW
   if (varname .ge. SPECIES_BEGIN .and. varname .le. MASS_SCALARS_END) then
      vartype = VARTYPE_PER_MASS
      return
   end if

   vartype = VARTYPE_ERROR  ! By default vartype is an ERROR
   do ctr = LBOUND(varnames,1), UBOUND(varnames,1)
      if ( varnames(ctr) .eq. varname ) vartype = vartypes(ctr)
   end do

end subroutine Simulation_getVarnameType

