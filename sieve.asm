  
    LDX #1
    LDY #1

    INIT_ARRAY:
        LDA $A, $X
        STA ($Y)
        LDX $X, #1
        LDY $Y, #1
        CMP $Y, #30
        BMI INIT_ARRAY (-6)

        LDA #1
    CHECK:
        LDA $A, #1
        STA 0x0000
        PHA
        LDX ($SP)
        CLS
        CMP $X, #0
        BNE IS_ZERO

        LDY #0
        LDY $Y, $A

        MARK_PRIME:
            LDY $Y, $A
            LDA $0
            STA ($Y)
            CLS 
            CMP $Y, 30
            BNI MARK_PRIME

        IS_ZERO:
            LDA #0
            PHA
            LDA ($SP)

            LDX #1
            POWER:
                LDY $Y, $A
                LDX $X, #1
                CLS
                CMP $X, $A
                BNE POWER
            
            CLS
            CMP $Y, #30
            BNI CHECK  
    LDA #0;
    PRINT_PRIMES:
        LDA $A,#1
        PHA
        LDY ($SP)
        CMP $Y, #0
        BNE PRINT_PRIMES

        LDX $X, $Y




1 => "1000001000000011",
2 => "1000010000000011",
3 => "0001001111000000",
4 => "0101000010000000",
5 => "0001001000000011",
6 => "0001010000000011",
7 => "1010000000000000",
8 => "0100010000111101",
9 => "1111000001000110",
10 => "1000010000000001",
11 => "0001010000000011",
12 => "0001010111000000",
13 => "0001000111011000",
14 => "0001011111001001",
15 => "1010000000000000",   
16 => "0100010000111101",
17 => "1111000001000110",
