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
      DATA NU1/33/,NT1/33/
      REAL(kind=dbl_kind) :: rbcp, t8, p8, qv8, qc8, qi8, dummy, gdzbcp, cpbr, &
                             es1, alphaw, pbarmb
      REAL (KIND=dbl_kind) :: T(NK3),H(NK3),TV(NK3),PILOG(NK3),ALPHA(NK3)  &
          ,QCBAR(NK3),QVSBAR(NK3)
      REAL (KIND=dbl_kind) :: ZT1(33),PI1(33),TV1(33),PILOG1(33)
      REAL (KIND=dbl_kind) :: PQ1(20),P1(33),T1(33),QV1(33),QC1(33)
      DATA PQ1/1012.0,991.2,945.5,893.8,836.1,772.8,705.2,635.0,564.5  &
              ,495.7,430.7,370.8,316.7,268.8,227.0,190.8,159.9,133.6   &
              ,111.3,92.6/
      DATA P1/982.6,975.4,964.8,951.0,934.1,914.2,891.5,866.2,838.5 &
             ,808.6,776.8,743.4,708.7,672.8,636.1,598.9,561.4,523.8 &
             ,486.5,449.7,413.5,378.3,344.2,311.3,279.8,249.8,221.4 &
             ,194.6,169.6,146.2,124.8,105.3,88.0/
      DATA T1/300.41,299.95,299.27,298.40,297.60,296.81,295.85,294.69 &
             ,293.38,291.91,290.29,288.72,286.88,284.90,282.62,280.14 &
             ,277.51,274.55,271.49,268.14,264.55,260.73,256.46,251.93 &
             ,246.90,241.30,234.76,227.68,219.85,211.77,204.24,196.16 &
             ,196.03/
      DATA QV1/22.4,22.0,21.6,20.8,20.1,19.3,18.6,18.0,17.1,16.2,15.3 &
              ,14.2,13.3,12.1,11.0,9.8,8.6,7.5,6.5,5.4,4.5,3.6,2.8,2.0 &
              ,1.4,0.8,0.4,0.2,0.1,0.0,0.0,0.0,0.0/
      DATA QC1/33*0./

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
      SST=302.

   END SUBROUTINE ini_3d

END MODULE ini_3d_module
