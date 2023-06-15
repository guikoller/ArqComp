#GRAVANDO NA RAM
#carrega acumulador com 10
LDA 10 
1000 000 00001010 1
#guarda valor do acumulador no endereço 1
STA 0x0001 
0110 000 000000001
#carrega acumulador com 11
LDA 11 
1000 000 00001011 1
#guarda valor do acumulador no endereço 4
STA 0x0004 
0110 000 000000100
#carrega acumulador com 42
LDA 42 
1000 000 00101010 1
#guarda valor do acumulador no endereço 8
STA 0x0008 
0110 000 000001000
#carrega acumulador com 253
LDA 253 
1000 000 11111101 1
#guarda valor do acumulador no endereço 122
STA 0x7A00 
0110 000 001111010


# carrega acumulador com 1
LDA 1 
1000 000 00000001 1
# carrega o valor do acumulador no ponteiro
PHA 
0001 000 111 011 00 0
# carrega em X a ram
LDX $SP 
0001 011 111 001 00 1

# carrega acumulador com 4
LDA 4
1000 000 00000100 1
# carrega o valor do acumulador no ponteiro
PHA 
0001 000 111 011 00 0
# carrega em X a ram
LDX $SP 
0001 011 111 001 00 1

# carrega acumulador com 8
LDA 8
1000 000 00001000 1
# carrega o valor do acumulador no ponteiro
PHA 
0001 000 111 011 00 0
# carrega em X a ram
LDX $SP 
0001 011 111 001 00 1

# carrega acumulador com 122
LDA 122 
1000 000 01111010 1
# carrega o valor do acumulador no ponteiro
PHA 
0001 000 111 011 00 0
# carrega em X a ram
LDX $SP 
0001 011 111 001 00 1


1000000000010101
0110000000000001
1000000000010111
0110000000000100
1000000001010101
0110000000001000
1000000111111011
0110000001111010


1 => "1000000000010101"
2 => "0110000000000001",
3 => "1000000000010111",
4 => "0110000000000100",
5 => "1000000001010101",
6 => "0110000000001000",
7 => "1000000111111011",
8 => "0110000001111010",
9 => "1000000000000011",
10 => "0001000111011000",
11 => "0001011111001001",
12 => "1000000000001001",
13 => "0001000111011000",
14 => "0001011111001001",
15 => "1000000000010001",
16 => "0001000111011000",
17 => "0001011111001001",
18 => "1000000011110101",
19 => "0001000111011000",
20 => "0001011111001001",