CS equ P3.0
A1 equ P3.4  	;define some pins, easier usage in code
A0 equ P3.3
DISP equ P1

START:

	SETB CS
	;HERE WE CHOOSE A DISPLAY 
	;00/01/10/11 as values of A1 and A0 
	;I will print my name - PAWEŁ

	SETB A1		
	SETB A0			;enable display 3
	;WHEN WE SELECT 0 - it is on, 1 - it is off, we start from dp as MSB, a is LSB
	MOV DISP, #10001100B	;P
	CALL delay
	
	CLR A0			;enable display 2
	MOV DISP, #10001000B	;A
	CALL delay
	
	CLR A1
	SETB A0			;enable display 1
	MOV DISP, #11000011B	;W part1
	CALL delay
	
	CLR A0			;enable display 0
	MOV DISP, #11100001B	;W part2
	CALL DELAY
	
	SETB A1		
	SETB A0			;enable display 3
	MOV DISP, #10000110B	;E
	CALL delay
	
	CLR A0			;enable display 2
	MOV DISP, #10000111B	;Ł
	CALL delay
	
	CALL delay		; some delay at the end
	CALL delay
	
	JMP START		; jump back to start, loop
	

DELAY:
	MOV R0, #200
	DJNZ R0, $
	RET
		
END