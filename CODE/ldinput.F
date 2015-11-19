#include "definesld.com"
MODULE ldinput

USE kinds
USE parmsld
USE ini_3d_module
 
IMPLICIT NONE
PRIVATE

INTEGER (KIND=int_kind) :: &
         ittget

PUBLIC :: &
   input_3d

CONTAINS

!=======================================================================
   SUBROUTINE INPUT_3D ( ITT )
!=======================================================================

! Argument list variables
      INTEGER (KIND=int_kind), INTENT(OUT) :: &
         ITT     ! time step count - initialized here

      LOGICAL (KIND=log_kind) :: restart_found
      INTEGER (KIND=int_kind) :: &       
         nwr10,nwr11,nwr12,nwr13,nwr14,nwr15,nwr16,nwr17,nwr18, nwr19
      INTEGER (KIND=int_kind) :: &
         ifl10, ifl11,ifl12,ifl13,ifl14,ifl15,ifl16,ifl17,ifl18,ifl19
      REAL (KIND=dbl_kind) ::    &
         omega,   & ! earth's rotation rate (s^-1)
         sfcrho,  & ! surface air density (kg m^-2) 
         dt8,     & ! 
         dtabsem, & !
         dtrad      !
      INTEGER (KIND=int_kind) :: &
         maxitt,  & !
         i          ! do loop index
        
      NAMELIST /INPUT1/ ITTADD
      NAMELIST /INPUT2/ DX,DY,DZ,DT
      NAMELIST /INPUT3/ NXSAVG
!      NAMELIST /INPUT6/ ITTMAX,CZ1,CZ2,SST,F,NRAD
!***********************************************************************
      DATA SFCRHO/1.160007D0/,OMEGA/7.292E-5/

! READ HEADER FROM the shell environment
!xlf_r           itest = GETENV('EXPHDR_tmp',exphdr_tmp)
!      CALL GETENV('EXPHDR_tmp',exphdr_tmp)
!      write(6,*) 'EXPHDR=',exphdr_tmp
      
! SET DEFAULT VALUES FOR INPUT1

      ITT    = 0
      ITTADD = 0

      open(unit=15,file='INPUT',form='formatted')
      READ(15,INPUT1)

      ITT = 0
      write(6,*) 'ITT=',ITT,'ITTADD=',ITTADD

      MAXITT = ITTGET + ITTADD + 1

      READ (15, INPUT2)
      READ (15, INPUT3)
      close(15)
      CALL INI_3D (itt)

   END SUBROUTINE input_3d 

END MODULE ldinput
