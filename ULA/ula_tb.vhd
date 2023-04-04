LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ULA_TB IS
END;

ARCHITECTURE A_ULA_TB OF ULA_TB IS
    COMPONENT ULA IS
        PORT (
            data_in_A : IN unsigned(15 DOWNTO 0);
            data_in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL data_in_A, data_in_B, result_out : unsigned(15 DOWNTO 0);
    SIGNAL op : unsigned(1 DOWNTO 0);
    SIGNAL zero_out : STD_LOGIC;
BEGIN
    uut : ULA PORT MAP(
        data_in_A => data_in_A,
        data_in_B => data_in_B,
        op => op,
        result_out => result_out,
        zero_out => zero_out
    );
    PROCESS
    BEGIN
        -- Teste com soma
        op <= "00";
        data_in_A <= x"0005";
        data_in_B <= x"0002";
        WAIT FOR 10 ns;
        
        data_in_A <= x"0010";
        data_in_B <= x"0050";
        WAIT FOR 10 ns;
        
        data_in_A <= x"1010";
        data_in_B <= x"0401";
        WAIT FOR 10 ns;

        -- Teste com subtração
        op <= "01";
        data_in_A <= x"0005";
        data_in_B <= x"0002";
        WAIT FOR 10 ns;
        
        data_in_A <= x"1000";
        data_in_B <= x"0500";
        WAIT FOR 10 ns;
        
        data_in_A <= x"0007";
        data_in_B <= x"0001";
        WAIT FOR 10 ns;

        -- Teste com comparação igual
        op <= "10";
        data_in_A <= x"0005";
        data_in_B <= x"0005";
        WAIT FOR 10 ns;
        
        data_in_A <= x"0011";
        data_in_B <= x"0005";
        WAIT FOR 10 ns;

        -- Teste com comparação maior
        op <= "11";
        data_in_A <= x"0005";
        data_in_B <= x"0002";
        WAIT FOR 10 ns;

        data_in_A <= x"0002";
        data_in_B <= x"0005";
        WAIT FOR 10 ns;

        data_in_A <= x"0010";
        data_in_B <= x"0002";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;
END A_ULA_TB;