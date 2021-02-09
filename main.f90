
      ! in arrays, the order of diatomic species is N2, O2, NO
 
      program main

      implicit none
      real*8 :: rhos(3),Ev,T,Tv

      rhos(:) = (/0.0256d0, 0.0013d0, 0.0022d0/)
      Ev = 4.191210435081368d+4

      T = 5000.0d0 ! initial guess

      Tv = Tv_from_Ev(rhos,Ev,T)

      contains

      function Tv_from_Ev(rhos,Ev,T) result(Tv)

      implicit none
      real*8, intent(IN) :: rhos(3),Ev,T
      real*8 :: Tv
      real*8 :: R = 8.3145d0 ! J/(mol*K)
      real*8 :: M(3) = (/28.0d-3, 32.0d-3, 30.0d-3/) ! kg/mol
      real*8 :: thetav(3) = (/3395.0d0, 2239.0d0, 2817.0d0/) ! K
      real*8 :: evs(3),F,dF,dTv

      Tv = T ! initial guess

      PRINT*,'Tv = ',Tv
      dTv = huge(1.0d0)
      do while (abs(dTv).gt.1.0d-6)
         evs = (R/M)*thetav/(exp(thetav/Tv)-1.0d0)
         F = sum( rhos*evs ) - Ev
         dF = sum( rhos*(M/R)*exp(thetav/Tv)*(evs(:)/Tv)**2.0d0 )
         dTv = -F/dF
         Tv = Tv + dTv
         PRINT*,'Tv = ',Tv
      enddo

      end function

      end program
