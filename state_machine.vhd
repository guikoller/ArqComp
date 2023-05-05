LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY state_machine IS
    PORT (
        clk, rst : IN STD_LOGIC;
        state : OUT STD_LOGIC
    );
END state_machine;

ARCHITECTURE a_state_machine OF state_machine IS
    signal output: STD_LOGIC;
BEGIN
    PROCESS (clk, rst) 
    BEGIN
        IF rst = '1' THEN
            output <= '0';
        ELSIF rising_edge(clk) THEN
            output <= NOT output;
        end IF;
    END PROCESS;
    state <= output;
END a_state_machine;