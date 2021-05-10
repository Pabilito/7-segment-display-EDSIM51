LED equ P1.3
CS equ P3.0				;chip select
A1 equ P3.4
A0 equ P3.3
DISP equ P1

org 00H					;start from memory 00H
jmp START 	

org 01BH				;directive to start writting memory from 01BH
jmp T1_Handler

T1_Handler:
	clr TF1				;clear overflow flag
	mov TH1, #0B1H
	mov Tl1, #0DEH

	mov ACC, R0
	jb ACC.0, DISPLAY0	;choose on of the displays
	jb ACC.1, DISPLAY1
	jb ACC.2, DISPLAY2
	jb ACC.3, DISPLAY3	

DISPLAY3:
	mov R0, #00000100B
	SETB A1		
	SETB A0			;enable display 3
	MOV DISP, #11111001B	;1
	reti				;every timer subroutine must return

DISPLAY2:
	mov R0, #00000010B
	CLR A0			;enable display 2
	MOV DISP, #11111001B	;1
	reti				;every timer subroutine must return

DISPLAY1:
	mov R0, #00000001B
	CLR A1
	SETB A0			;enable display 1
	MOV DISP, #11000000B	;0
	reti				;every timer subroutine must return
	
DISPLAY0:
	mov R0, #00001000B
	CLR A0			;enable display 0
	MOV DISP, #10000010B	;6
	reti				;every timer subroutine must return

START:
	clr LED				;turn on LED
	SETB CS				
	mov R0, #00001000B
	
	;T1 configuration
	setb TR1			;TR1 is a special register
	mov TMOD, #00000000	;set value of timer mode register
	mov TH1, #0B1H
	mov TL1, #0DEH
	setb ET1			;enable overflow interrupt for T1
	setb EA				;enable global overflow
	
INFLOOP:
	sjmp $ 				;simplest infinite loop
		
END