LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ULA_TB IS
END ULA_TB;

ARCHITECTURE A_ULA_TB OF ULA_TB IS
    -- Component declaration for ULA
    COMPONENT ULA
        PORT (
            data_in_A : IN unsigned(15 DOWNTO 0);
            data_in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(3 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out, negative_out, carry_out : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Testbench signals
    SIGNAL data_A, data_B : unsigned(15 DOWNTO 0);
    SIGNAL operation : unsigned(3 DOWNTO 0);
    SIGNAL result : unsigned(15 DOWNTO 0);
    SIGNAL zero, negative, carry : STD_LOGIC;

BEGIN
    -- Instantiate the ULA component
    uut : ULA
    PORT MAP(
        data_in_A => data_A,
        data_in_B => data_B,
        op => operation,
        result_out => result,
        zero_out => zero,
        negative_out => negative,
        carry_out => carry
    );

    -- Stimulus process
    PROCESS
    BEGIN
        -- Testcase 1: Addition
        operation <= "0000";
        data_A <= "1000000000000010";
        data_B <= "1000000000000011";
        WAIT FOR 10 ns;

        data_A <= x"0006";
        data_B <= x"FFFF";
        WAIT FOR 10 ns;

        data_A <= x"0006";
        data_B <= x"0006";
        WAIT FOR 10 ns;

        data_A <= x"0125";
        data_B <= x"0A56";
        WAIT FOR 10 ns;

        -- Testcase 2: Subtraction
        data_A <= "0000000000000011";
        data_B <= "0000000000000110";
        operation <= "0001";
        WAIT FOR 10 ns;

        -- Testcase 3: Comparison (Equal)
        data_A <= "0000000000000010";
        data_B <= "0100000000000010";
        operation <= "0010";
        WAIT FOR 10 ns;

        -- Testcase 4: Comparison (Greater)
        data_A <= "0000000000000100";
        data_B <= "0000000000000010";
        operation <= "0011";
        WAIT FOR 10 ns;

        -- Testcase 5: Invalid operation
        data_A <= "0000000000000001";
        data_B <= "0000000000000001";
        operation <= "0100";
        WAIT FOR 10 ns;
        
        WAIT;
    END PROCESS;

END A_ULA_TB;