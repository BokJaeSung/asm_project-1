.globl main
.data
shp: .asciz "# "
string: .space 512

# Reason of resubmission: Line 68, "add" is used. Note that "add" refers to the instruction and may cause confusion.
# Additionally, there were concerns about the misuse of system call registers(ex....a0, a1), so it has been changed to a temporary register.

.eqv ptr t0
.eqv TEMP t1
.eqv CHR t2
.eqv First_OP t3
.eqv Second_OP t4
.eqv NUM_ASCII 48
.eqv PLUS 43
.eqv MINUS 45
.eqv DIVID 47
.eqv BGT_NUM 58
.eqv EQUAL 61
.eqv MULTI 120
 

.text
main:
	la a0, shp
	li a7, 4
	ecall
	
	la a0, string
	li a1, 512
	li a7, 8
	ecall
	
	la a0, string
	li a7, 4
	ecall
	
	# ptr == start position of string
	la ptr, string
	# reset a0, a1 as 0
	li a0, 0
	li a1, 0
	
	li First_OP, 0
	li Second_OP, 0
	
read_first_operand:  
	# CHR = string[ptr]
	lb CHR, 0(ptr) 
	# if (CHR >= 58) maybe it is multiplier...
	li TEMP, BGT_NUM
	bge CHR, TEMP, process_operator
	
	# string[ptr] == number
	li TEMP, NUM_ASCII
	bge CHR, TEMP, first_operand_loop
	
	# string[ptr] == operator, now go to process_operator 
	jal x0, process_operator
# make a0 first operand is easier than make another condition....(such as ...checking first_operand)
first_operand_loop:

	li TEMP, 10
	mul First_OP, First_OP, TEMP
	
	lb CHR, 0(ptr)
	add First_OP, First_OP, CHR
	addi First_OP, First_OP, -NUM_ASCII
	
	addi ptr, ptr, 1
	
	jal x0, read_first_operand

process_operator:

	li Second_OP ,0
	li TEMP, EQUAL          
	beq CHR, TEMP, Exit
	li TEMP, PLUS		
	beq CHR, TEMP, addition
	li TEMP, MINUS		
	beq CHR, TEMP, subtract
	li TEMP, MULTI		
	beq CHR, TEMP, multiply
	li TEMP, DIVID		
	beq CHR, TEMP, divide

addition:
	jal x1, read_second_operand
	add First_OP, First_OP, Second_OP
	add a0, x0, First_OP
	jal x0, output_result

subtract:
	jal x1, read_second_operand
	sub First_OP, First_OP, Second_OP
	add a0, x0, First_OP
	jal x0, output_result
	
multiply:
	jal x1, read_second_operand
	mul First_OP, First_OP, Second_OP
	add a0, x0, First_OP
	jal x0, output_result
	
divide:
	jal x1, read_second_operand
	div First_OP, First_OP, Second_OP
	add a0, x0, First_OP
	jal x0, output_result

read_second_operand:
 
	addi ptr, ptr, 1
	
	# CHR = string[ptr]
	lb CHR, 0(ptr)
	
	
	# string[ptr] == operater
	li TEMP, MULTI
	beq CHR, TEMP, loop
	li TEMP, NUM_ASCII
	blt CHR, TEMP, loop
	
	#string[ptr] == '='
	li TEMP, EQUAL
	beq CHR, TEMP, loop

	# string[ptr] == number
	li TEMP, 10
	mul Second_OP, Second_OP, TEMP	
	
	lb CHR, 0(ptr)
	add Second_OP, Second_OP, CHR		
	addi Second_OP, Second_OP, -NUM_ASCII

	jal x0, read_second_operand

loop:
	jalr x0, 0(x1)

output_result:
	li a7, 1
	ecall
	
	li a0, 10
	li a7, 11
	ecall

	jal x0, process_operator
	
Exit:
	li a7, 10
	ecall
