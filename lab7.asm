    --load x and y register    
    LDX #5;
    1000 001 00000101 1
    LDY #1;
    1000 000 00000001 1

    --a <- a + x and stores in address ($y) in ram
    LDA $A, $X;
    0001 000 001 000 00 0
    STA ($Y);
    0101 000 010 000000

    --add 5 to x and 1 to y
    LDX $X, #5;
    0001 001 00000101 1
    LDY $Y, #1;
    0001 010 00000001 1

    --if y < 30 goto lda $a, $y
    CLS;
    1010 0000 0000 000 0
    CMP $Y, 30;
    0100 010 00010100 1
    BMI -6;
    1111 00000 1 000110

 1 => "1000001000001011",
 2 => "1000000000000011",
 3 => "0001000001000000",
 4 => "0101000010000000",
 5 => "0001001000001011",
 6 => "0001010000000011",
 7 => "1010000000000000",
 8 => "0100010000101001",
 9 => "1111000001000110",