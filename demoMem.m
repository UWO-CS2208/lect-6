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

include(macro_defs.m)
define(EOL, 10)              ! end of line character
define(MAXX, 10)             ! maximum value for x
define(temp_r, %l0)          ! temporary register


  local_var	             ! start offset at 0
  var(x_s,4)	             ! offset for word x on the stack
  var(y_s,4)	             ! offset for word y on the stack
	
  begin_main	             ! global main and save

  st    %g0, [%fp + x_s]     ! initialize x to 0

loop:
  ld    [%fp + x_s], temp_r  ! fetch x
  sub	temp_r, 3, %o0	     ! (x - 3)
  ld    [%fp + x_s], temp_r  ! fetch x [could be omitted]
  sub	temp_r, 7, %o1	     ! (x - 7)
  call	.mul		     ! compute product
  nop

  st	%o0, [%fp + y_s]     ! store result in y 

  call writeInt		     ! print result
  nop
  call writeChar
  mov	EOL, %o0             ! [filled delay slot]

  ld    [%fp + x_s], temp_r  ! increment x by 1
  inc   temp_r
  st    temp_r, [%fp + x_s]  !
	
  ld    [%fp + x_s], temp_r  ! fetch x [could be omitted]
  cmp   temp_r, MAXX  	     ! is x < = 10?

  ble	loop	             ! if so, keep looping
  nop

  ret
  restore


