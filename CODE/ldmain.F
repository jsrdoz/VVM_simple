#include "definesld.com"
PROGRAM ldmain
!
!   **********************************************************************
!   *                    VVCM (Ver.1.1   August 31, 2007)                *
!   *                                                                    *
!   *                   Jung, J.-H., and A. Arakawa, 2005:               *
!   *    A three-dimensional cloud model based on the vector vorticity   *
!   *    equation. Atmospheric Science Report No. 762, CSU, 56 pp.       *
!   *                                                                    *
!   *    http://kiwi.atmos.colostate.edu/pubs/joon-hee-tech_report.pdf   *
!   **********************************************************************
!
!   1. Prognostic Variables:
!      vorticity components     (Z3DX, Z3DY, Z3DZ)
!      Potential temperature    (TH3D)
!      Water vapor mixing ratio (QV3D)
!      Cloud water mixing ratio (QC3D)
!      Cloud ice mixing ratio   (QI3D)
!      Rain mixing ratio        (QR3D)
!      Snow mixing ratio        (QS3D)
!      Graupel mixing ratio     (QG3D)
!
!      Note: In this code, the definition of eta has an opposit sign of
!            that in Jung and Arakawa (2005) (dw/dx - du/dz).
!            The horizontal components of vorticity are fixed to zero
!            at the upper and lower boundaries (a free slip condition).
!
!      Note: The variable DYNEW is used for the grid size in y-direction.
!
!   2. Advection scheme for sclar variables and vorticity components
!      is the 2nd-order with ALADV=0 and the 3rd-order with ALADV=1.
!
!   3. Except for the turbulence,
!      the physics package is from UCLA/CSU/UU 2D CEM.
!
!   4. First order turbulence is used. (Shutts and Gray, 1994)
!
!   5. For time differencing, Adams-Bashforth 2nd-order scheme is used.
!   6. Horizontal boundary condition is cyclic.
!   7. Elliptic equations are solved by FFTW .
!
!======================================
!   INPUT (given through a script file)
!======================================
!    definesld.com
!    RESTART    -- READING I.C. FROM A PREVIOUS OUTPUT
!    PERIODIC   -- PERIODIC LATERAL BOUNDARY CONDITIONS
!    (Note: This is not explicitly set all the time because the periodic
!           condition is assumed throughout the code.)
!    ZCONST     -- UNIFORM Z-GRID
!    CORIOLIS   -- INCLUDING THE CORIOLIS FORCE
!    DIFFUSION  -- LINEAR DISSIPATION / TURBULENCE
!    AREAMN     -- FIX THE AREA MEAN OF HORIZONTAL WIND (INSTANT NUDGING)
!    SETWIND    -- PRESCRIBE THE UNIFORM GEOSTROPHIC WIND (UG)
!    PHYSICS    -- PHYSICS CODE IS ACTIVATED
!    RADCODE    -- RADIATION CODE IS ACTIVATED
!    MICROCODE  -- MICROPHYSICS CODE IS ACTIVATED
!    (Unless "PHYSICS" is defined, no calculation of water species.)
!
!    INPUT parameters given from the script file:
!    PARMSLD.com  &  RADPARMS.com
!============
!   OUTPUT
!============
!    (Unformatted in single precision)
!    FT08: Dataset B: constant file
!          (B02 is for restart and in double precision)
!    FT09: Dataset I: initial field of basic fields
!    FT09: Dataset R: Radiation fields
!    FT11: Dataset L: real-time field of basic fields (NXSAVG)
!    FT12: Dataset C: averaged field of physics fields(NXSAVG)
!    FT13: Dataset E: restart file
!
!    (Formatted)
!    fort.21: Information on filling (NFLPRT)
!    fort.95: Initial profiles and LS forcing (once)
!    fort.98: C-block data (once)
!***********************************************************************
    USE kinds
    USE parmsld
    USE ldinput
    USE ab_3d_module

    IMPLICIT NONE

    !      INTEGER rnk_wrld,npc_wrld,ierr

    INTEGER (KIND=int_kind) ::    &
        itt,        & ! time step count
        n1,         & ! AB forcing time index for previous timestep
        n2            ! AB forcing time index for current timestep

!-----------------------------------------------------------------------
! Initialize MPI environment and domain decomposition
!      call MPI_INIT(mpierr)

    CALL INPUT_3D ( ITT )

    write(6,*) 'ITTOUT=',ITT

      !  Initialization
    N1 = MOD ( ITT , 2 ) + 1
    N2 = MOD ( ITT - 1, 2 ) + 1

    do while( ITT <= ITTADD )
    
        CALL AB_3D ( N1, N2, ITT )        

    ENDDO

!-----------------------------------------------------------------------

    STOP 100
END PROGRAM ldmain
