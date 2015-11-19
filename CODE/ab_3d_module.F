#include "definesld.com"
MODULE ab_3d_module

USE kinds
USE parmsld

IMPLICIT NONE
PRIVATE

PUBLIC :: ab_3d

CONTAINS

!=======================================================================
   SUBROUTINE AB_3D ( N1, N2, ITT )
!=======================================================================
! Argument list variables
    INTEGER (KIND=int_kind), INTENT(INOUT) :: &
         itt,       & ! time step count
         n1,        & ! AB forcing time index for previous timestep
         n2           ! AB forcing time index for current timestep
   
    INTEGER (KIND=int_kind) :: k


   ITT = ITT+1


   END SUBROUTINE ab_3d

END MODULE ab_3d_module
