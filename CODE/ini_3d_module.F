#include "definesld.com"
MODULE ini_3d_module

USE kinds
USE PARMSLD

IMPLICIT NONE
PRIVATE

! public member functions
PUBLIC ::     &
   ini_3d
   
CONTAINS

!=======================================================================
   SUBROUTINE INI_3D (itt)
!=======================================================================

!     Set up I.C. 

      integer (kind=int_kind), intent(in) :: itt

      INTEGER (KIND=int_kind) :: &
         RDHOUR  
      INTEGER (KIND=int_kind) :: &
         i, j, k, & ! do loop indices for zonal, meridional and vertical dimensions
         n,    &    ! time level index
         i00, j00, &!
         IQ,JQ 
      REAL (KIND=dbl_kind) ::    &
         scaleq=0._dbl_kind, & !
         rkappa,             &
         rkappai,            &
         gamfac, a0, z00, xr, yr, zr, dist,tmp,height
      REAL (KIND=dbl_kind), PARAMETER :: th00 = 300._dbl_kind      
      REAL (KIND=dbl_kind), PARAMETER :: rgas = 287.04     
      REAL (KIND=dbl_kind), PARAMETER :: rad1 = -2.    
      REAL (KIND=dbl_kind), PARAMETER :: secday = 86400.    
      REAL (KIND=dbl_kind) :: pzero = 1000._dbl_kind      
      REAL (KIND=dbl_kind) :: P_INT(NK2),PI_INT(NK2) 
      REAL (KIND=int_kind) :: temp(NK3)

      integer nu1, nt1, k1, k2, it
      logical lf
      DATA NU1/33/,NT1/21/
      REAL(kind=dbl_kind) :: rbcp, t8, p8, qv8, qc8, qi8, dummy, gdzbcp, cpbr, &
                             es1, alphaw, pbarmb,sst
      REAL (KIND=dbl_kind) :: T(NK3),H(NK3),TV(NK3),PILOG(NK3),ALPHA(NK3)  &
          ,QCBAR(NK3),QVSBAR(NK3)
      REAL (KIND=dbl_kind) :: ZT1(21),PI1(21),TV1(21),PILOG1(21)
      REAL (KIND=dbl_kind) :: PQ1(20),P1(21),T1(21),QV1(21),QC1(21)
      DATA PQ1/1012.0,991.2,945.5,893.8,836.1,772.8,705.2,635.0,564.5  &
              ,495.7,430.7,370.8,316.7,268.8,227.0,190.8,159.9,133.6   &
              ,111.3,92.6/
      DATA P1/1012.0,991.2,950.0,945.5,893.8,836.1,772.8,705.2,635.0   &
             ,564.5,495.7,430.7,370.8,316.7,268.8,227.0,190.8,159.9    &
             ,133.6,111.3,92.6/
      DATA T1/257.2,240.0,0.0,210.4,182.5,153.5,120.9,79.7,29.6,-21.3  &
             ,-76.9,-142.1,-218.1,-303.4,-396.8,-493.1,-585.9,-666.9   &
             ,-726.4,-755.8,-749.0/
      DATA QV1/3*165.0,153.1,132.5,111.3,90.8,73.2,57.3,42.2,26.3   &
              ,14.3,8.3,4.3,1.9,0.8,0.3,0.1,0.1,0.1,0.1/
      DATA QC1/21*0./

      REAL (KIND=dbl_kind) ::  Q1OBS(20),Q2OBS(20)
      DATA Q1OBS/-0.25,0.18,1.41,2.51,3.29,3.71,3.95,4.09,4.07,3.81  &
                ,3.42,2.92,2.16,1.27,0.64,0.32,0.13,0.03,0.01,0.0/
      DATA Q2OBS/0.60,1.37,3.89,5.28,5.49,5.12,4.54,3.82,3.14, 2.52  &
                ,1.90,1.34,0.85,0.45,0.18,0.05,0.01,0.00,0.00,0.0/
!     U1 IS FOR CASE C4, 11 SEP 1974, DURING GATE, A SQUALL CLUSTER
!     SEE FIG. 17, SUI & YANAI, JAS, 43, 1618-1642.
!     PU1 (MB) , U1(M/S)

      REAL (KIND=dbl_kind) ::  PU1(33),U1(33)
      DATA PU1/1006.7, 993.8, 977.9, 959.1, 937.7, 913.7, 887.4,   &
                858.9, 828.5, 796.4, 762.8, 728.0, 692.2, 655.7,   &
                618.6, 581.3, 543.9, 506.8, 470.2, 434.1, 398.9,   &
                364.6, 331.4, 299.4, 268.7, 239.5, 211.8, 185.8,   &
                161.6, 139.4, 119.2, 101.4,  85.8 /
      DATA U1/ -1.0,  -1.0,  -1.4,  -1.7,  -1.8,  -2.1,  -2.6,  -3.6,   &
               -4.9,  -6.7,  -8.7, -10.6, -12.2, -13.2, -13.1, -12.0,   &
               -9.7,  -6.6,  -3.2,  -0.3,   1.3,   1.3,   0.4,  -1.0,   &
               -2.9,  -4.3,  -4.5,  -2.8,  -0.6,  -0.5,  -2.2,  -2.5,   &
               -3.0 / 

!*****************************************************
!     1. OBTAIN 1D THERMODYNAMICAL PROFILE
!*****************************************************
      SST=20000000

   END SUBROUTINE ini_3d

END MODULE ini_3d_module
