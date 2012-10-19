! program demoMem.m
! sample program to show how memory is allocated
!   for local variables
! this program computes the expression:
!    y = (x - 3) * (x - 7) for x = 0, 1, ... 10
! revision history: original code from T. Dube
!                   modified by A. Downing 1998-10-28
!                   more changes 1999-02-09, 2000-02-15,
!                   2006-10-24

! registers used: 
!	%l0	    temp_r,  temporary for calculations

! variables: x and y are local variables stored on the stack

 
              ! end of line character
             ! maximum value for x
          ! temporary register


  !local variables
	             ! start offset at 0
  x_s = -4	             ! offset for word x on the stack
  y_s = -8	             ! offset for word y on the stack
	
  .global	main
main:	save	%sp, -104, %sp	             ! global main and save

  st    %g0, [%fp + x_s]     ! initialize x to 0

loop:
  ld    [%fp + x_s], %l0  ! fetch x
  sub	%l0, 3, %o0	     ! (x - 3)
  ld    [%fp + x_s], %l0  ! fetch x [could be omitted]
  sub	%l0, 7, %o1	     ! (x - 7)
  call	.mul		     ! compute product
  nop

  st	%o0, [%fp + y_s]     ! store result in y 

  call writeInt		     ! print result
  nop
  call writeChar
  mov	10, %o0             ! [filled delay slot]

  ld    [%fp + x_s], %l0  ! increment x by 1
  inc   %l0
  st    %l0, [%fp + x_s]  !
	
  ld    [%fp + x_s], %l0  ! fetch x [could be omitted]
  cmp   %l0, 10  	     ! is x < = 10?

  ble	loop	             ! if so, keep looping
  nop

  ret
  restore


