LED equ P1.3
CS equ P3.0				;chip select
A1 equ P3.4
A0 equ P3.3

org 00H					;start from memory 00H
jmp START 	

org 01BH				;directive to start writting memory from 01BH
jmp T1_Handler

T1_Handler:
	clr TF1				;clear overflow flag
	mov TH1, #0B1H
	mov Tl1, #0DEH
	cpl LED				;blinking
	reti				;every timer subroutine must return

START:
	clr LED				;turn on LED
	clr CS				
	
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