LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY program_counter IS
    PORT (
        data_in : IN unsigned(15 DOWNTO 0);
        clk, write_enable, rst : IN STD_LOGIC;
        data_out : OUT unsigned(15 DOWNTO 0)
    );

END ENTITY program_counter;

ARCHITECTURE a_program_counter OF program_counter IS
    SIGNAL sig_data : unsigned (15 DOWNTO 0);

BEGIN
    PROCESS (clk, rst, write_enable)
    BEGIN
        IF rst = '1' THEN
            sig_data <= x"0000";
        ELSIF write_enable = '1' THEN
            IF rising_edge(clk) THEN
                sig_data <= data_in;
            END IF;
        END IF;

    END PROCESS;

    data_out <= sig_data;

END ARCHITECTURE a_program_counter;