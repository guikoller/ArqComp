    LDX 1;
    LDY 1;

    LOAD_ARRAY:
        LDA $A, $X;
        STA ($Y);
        LDX $X, 1;
        LDY $Y, 1;
        CLS;
        CMP $Y, 30;
        BMI LOAD_ARRAY;
    
    LDA $0

    LDY 4
    TWO:
        STA ($Y)
        LDY $Y,2
        CLS;
        CMP $Y, 32;
        BMI TWO;
    
    LDY 6
    THREE:
        STA ($Y)
        LDY $Y,3
        CLS;
        CMP $Y, 32;
        BMI THREE;

    LDY 10
    FIVE:
        STA ($Y)
        LDY $Y,5
        CLS;
        CMP $Y, 32;
        BMI FIVE;

    LDY 0;
    PRINT:
        LDY $Y, 1;
        LDA $A, $Y;
        PHA 
        LDX ($SP)
        CLS;
        CMP $Y, 32;
        BMI -6;