! Example: y=(x-3)*(x-7) for x=0 to 10
! Where x and y are local variables

	.global main
main:
	save 	%sp, -104, %sp	!include storage for two words (92+8 corrected to div by 8)
	st	%g0, [%fp-4]	!initialize x to 0

loop:	ld	[%fp - 4], %l0	!fetch x
	sub	%l0, 3, %o0	!(x-3) into %o0
!	ld 	[%fp - 4], %l0	!fetch x
	call	.mul
	sub	%l0, 7, %o1	![Filled Delay Slot]

	call	writeInt	!print y
	st	%o0, [%fp - 8]	!Store result into y
!	nop
	call 	writeChar
	mov	'\n', %o0	![Filled Delay Slot]
	
	ld	[%fp - 4], %l0	!increment x by 1
	inc 	%l0
	
!	ld	[%fp - 4], %l0	!fetch x
	cmp	%l0, 10		!is x <= 10?
	ble 	loop		!if so keep looping
	st	%l0, [%fp - 4]	!put value back into memory
!	nop
	
	ret
	restore
