# ATARI MOS 6502

http://www.6502.org/tutorials/6502opcodes.html

|  ||                |       |
|-----------|-----------|-------------------|------------------|
| NO OPERATION       |NOP| NOP               | 0000000000000000 |
| SUM       |ADC $RES, IMMEDIATE| ADC $R3, 5        | 0001_011_00000101_1 |
| SUM       |ADC $RES, IMMEDIATE| ADC $R4, 8        | 0001_100_00001000_1 |
| SUM       |ADC $RA, $RB, $RD| ADC $R3, $R5, $R5 | 0001_011_100_101_00_0 |
| SUBTRACION       |SBC $RES, IMMEDIATE| SBC $R5, 1        | 0010_101_00000001_1 |
| JUMP       |JMP POS| JMP 20            | 1110_000000_010100 |
| SUM       |ADC $RA, $RB, $RD|ADC $R5, $R0, $R3 | 0001_101_000_011_00_0 |
| JUMP       |JMP POS |JMP 3             | 1110_000000_000011 |

## LAB5:

```
0:
    NOP;
    ADC $R3, 5;
    ADC $R4, 8;
    ADC $R3, $R5, $R5;
    SBC $R5, 1;
    JMP 20;
20:
    ADC $R5, $R0, $R3;
    JMP 3;
```

```
0000000000000000
0001011000001011
0001100000010001
0001011100101000
0010101000000011
1110000000010100
0001101000011000
1110000000000011
```

## LAB6:
```
    NOP;
    ADC $R3, 0;
    ADC $R4, 0;
    ADC $R3, $R4, $R4;
    ADC $R3, 1;
    CLS;
    CMP R3, 30;
    BMI -4;
    ADC $R4, $R0, $R5
```