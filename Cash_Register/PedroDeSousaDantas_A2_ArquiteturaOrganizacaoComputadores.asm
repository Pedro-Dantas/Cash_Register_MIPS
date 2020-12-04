#####################################################################
## ATIVIDADE INDIVIDUAL AVALIATIVA(A2)
## PROGRAMA��O ASSEMBLY PARA ARQUITETURA MIPS32
## Aluno: Pedro de Sousa Dantas
## Matr�cula:20162102395
#####################################################################

.data
	msg1:  .asciiz "  Valor insuficiente para compra! "
	msg2:  .asciiz "  Valor Suficiente! "
	msg3:  .asciiz "  N�o h� troco! "
	msg4:  .asciiz "  H� troco ou � insuficiente! "
	msg5:  .asciiz "  Valor pago em centavos: R$ "
	msg6:  .asciiz "  Valor do produto em centavos: R$ "
	msg7:  .asciiz "  Troco em centavos: R$ "
	enter: .asciiz "\n"
	 
	ced20: .asciiz " Quantidade de notas de 20 reais: "
	ced10: .asciiz " Quantidade de notas de 10 reais: "
	ced5:  .asciiz  " Quantidade de notas de 5 reais: "
	ced2:  .asciiz  " Quantidade de notas de 2 reais: "
	mo1:   .asciiz   " Quantidade de moedas de 1 real: "
	mo50:  .asciiz  " Quantidade de moedas de 0,50 centavos: "
	mo25:  .asciiz  " Quantidade de moedas de 0,25 centavos: "
	mo10:  .asciiz  " Quantidade de moedas de 0,10 centavos: "
	mo5:   .asciiz   " Quantidade de moedas de 0,05 centavos: "
	
.text # Declara��o de in�cio do segmento de texto
.globl main # Declara��o de que o r�tulo main � global

main: 

	# Persist�ncia dos valores nos registradores $sx da notas em centavos atrav�s da multiplica��o

	li $s0, 1 # Quantidade de notas de R$20,00 inseridas.
	mul $s0, $s0, 2000 # Transforma��o do valor da nota em centavos
	
	li $s1, 1 #Quantidade de notas de R$10,00 inseridas.
	mul $s1, $s1, 1000 # Transforma��o do valor da nota em centavos
	
	li $s2, 1 #Quantidade de notas de R$5,00 inseridas.
	mul $s2, $s2, 500 # Transforma��o do valor da nota em centavos
	
	li $s3, 1 #Quantidade de notas de R$2,00 inseridas.
	mul $s3, $s3, 200 # Transforma��o do valor da nota em centavos
	
	li $s4, 1 #Quantidade de notas de R$1,00 inseridas.
	mul $s4, $s4, 100 # Transforma��o do valor da nota em centavos
	
	li $s5, 1 #Quantidade de notas de R$0,50 inseridas.
	mul $s5, $s5, 50 # Transforma��o do valor da nota em centavos
	
	li $s6, 1 #Quantidade de notas de R$0,25 inseridas.
	mul $s6, $s6, 25 # Transforma��o do valor da nota em centavos
	
	li $s7, 1 #Quantidade de notas de R$0,10 inseridas.
	mul $s7, $s7, 10 # Transforma��o do valor da nota em centavos
	
	li, $k0, 5 # Moeda de 5 centavos
	
	# Somat�rio dos valores inseridos de forma encadeada
	# formula geral => N = N0 + N1 + Nn 
	# add $t2 = $s0 + $s1 + $n
	add $t2, $s0, $s1 
	add $t2, $t2, $s2 
	add $t2, $t2, $s3 
	add $t2, $t2, $s4 
	add $t2, $t2, $s5 
	add $t2, $t2, $s6 
	add $t2, $t2, $s7 
	
	# Valor do produto marretado em centavos
	# Exemplo : R$20,15 = Valor do produto x 100
	li $t9, 2015 
	
    ## Verifica��o se h� capital para compra do produto ##
	###############################################################################################

	# if (total > produto)
	bgt $t2, $t9, true1 # Se total > produto for verdadeiro, a intru��o pula para o label true1 
	# Caso seja falso executa as instru��es abaixo
	li $v0, 4
	la $a0, msg1
	li $t0, 1 # retorno 1 quando o valor n�o � suficiente para compra
	syscall 
	b fim

    true1: 	# total > produto sendo true 
	li $v0, 4
	la $a0, msg2
	li $t0, 0 # retorno 1 quando o valor for suficiente para compra
	syscall	
	
	###############################################################################################	
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
    
    ###############################################################################################
    
	# if (total < produto)
	blt $t2, $t9, true2 # Se total < produto for verdadeiro, a instru��o pula para o label true3
	# Caso seja falso executa as instru��es abaixo
	li $v0, 4
	la $a0, msg2
	li $t0, 0 # retorno 1 quando o valor � suficiente para compra
	syscall 
	b fim
	
    true2: 	# total < produto sendo true
	li $v0, 4
	la $a0, msg1
    li $t0, 1 # retorno 1 quando o valor n�o � suficiente para compra
	syscall
		
	###############################################################################################
			
	# if (produto = total)
	beq $t2, $t9, true3 # Se total = produto for verdadeiro, a instru��o pula para o label true2
	# Caso seja falso executa as instru��es abaixo 
	li $v0, 4
	la $a0, msg4 # Imprime a mensagem "H� troco ou � insuficiente!"
	syscall 
	b fim

    true3: 	# total = produto sendo true
	li $v0, 4
	la $a0, msg3  
    li $t0, 0 # retorno 0 quando o valor for suficiente para compra
	syscall	
	
	###############################################################################################
	
	fim:
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	###############################################################################################
    ## Impress�o do valor pago (em centavos) ##

	li $v0, 4 # Carrega o comando 4 para impress�o
	la $a0, msg5 # Impress�o da mensagem
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t2 # Impress�o do valor pago
	syscall		
	
    ## Impress�o do valor do produto (em centavos) ##
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, msg6 # Impress�o de mensagem
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t9 # Impress�o do valor do produto (em centavos)
	syscall		
	
    ## Impress�o do troco (em centavos) ##
	# troco = total - produto
	sub $t3, $t2, $t9 
	# $t3 = troco
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, msg7 # Impress�o de mensagem
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t3 # Impress�o do valor do troco (em centavos)
	syscall		
	
    ## Algoritmo de calculo de troco a serem impressas ##
 		
	loop:
		# (Troco menor que 2000)
		blt $t3, $s0, loop2   
	
		addi $a1, $a1, 1
		subi $t3, $t3, 2000
	
		j loop		
	
	loop2:
		# (Troco menor que 1000)
		blt $t3, $s1, loop3   
	
		addi $a2, $a2, 1
		subi $t3, $t3, 1000
	
		j loop
	
	loop3:
		# (Troco menor que 500)
		blt $t3, $s2, loop4   
	
		addi $a3, $a3, 1
		subi $t3, $t3, 500
	
		j loop
	
	loop4:
		# (Troco menor que 200)
		blt $t3, $s3, loop5   
	
		addi $t4, $t4, 1
		subi $t3, $t3, 200
	
		j loop
		
	loop5:
		# (Troco menor que 100)
		blt $t3, $s4, loop6   
	
		addi $t5, $t5, 1
		subi $t3, $t3, 100
	
		j loop
		
	loop6:
		# (Troco menor que 50)
		blt $t3, $s5, loop7   
	
		addi $t6, $t6, 1
		subi $t3, $t3, 50
	
		j loop	
	
	loop7:
		# (Troco menor que 25)
		blt $t3, $s6, loop8   
	
		addi $t7, $t7, 1
		subi $t3, $t3, 25
	
		j loop
		
	loop8:
		# (Troco menor que 10)
		blt $t3, $s7, loop9   
	
		addi $t8, $t8, 1
		subi $t3, $t3, 10
	
		j loop
		
		
	loop9:
		# (Troco menor que 5)
		blt $t3, $k0, exit   
	
		addi $k1, $k1, 1
		subi $t3, $t3, 10
	
		j loop
	
	exit:
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	li $v0, 4
	la $a0, enter 
	syscall
	
	# Impress�o da quantidade de cedulas de 20 reais #
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, ced20 # Impress�o da mensagem
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $a1 # Impress�o do valor
	syscall		
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter
	syscall
	
	## Impress�o da quantidade de cedulas de 10 reais ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, ced10 	# Impress�o da mensagem 	
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $a2 # Impress�o do valor
	syscall		
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	## Impress�o da quantidade de cedulas de 5 reais ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, ced5  # Impress�o da mensagem  	
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $a3 # Impress�o do valor
	syscall		
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	## Impress�o da quantidade de cedulas de 2 reais ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, ced2 	# Impress�o da mensagem  	
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t4 # Impress�o do valor
	syscall	
		
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	## Impress�o da quantidade de cedulas de 1 reais ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, mo1 # Impress�o da mensagem  
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t5 # Impress�o do valor
	syscall	

	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	## Impress�o da quantidade de moedas de 50 centavos ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, mo50	# Impress�o da mensagem  	
	syscall
	li $v0, 1  # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t6 # Impress�o do valor
	syscall		
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	## Impress�o da quantidade de moedas de 25 centavos ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, mo25 	# Impress�o da mensagem	
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t7 # Impress�o do valor
	syscall	
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, mo10 	# Impress�o da mensagem		
	syscall
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $t8 # Impress�o do valor
	syscall	
	
	# Espa�o em branco entre as respostas
	li $v0, 4
	la $a0, enter 
	syscall
	
	## Impress�o da quantidade de moedas de 5 centavos ##
	li $v0, 4	# Carrega o comando 4 para impress�o
	la $a0, mo5  # Impress�o da mensagem		
	syscall 	
	li $v0, 1 # Carrega o comando 1 para impress�o de inteiro
	move $a0, $k1 # Impress�o do valor
	syscall	
	
	# return 0
	li $v0, 10 
	syscall 	
	
