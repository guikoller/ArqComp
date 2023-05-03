LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY plus_one IS
    PORT (
        data_in : IN unsigned(15 DOWNTO 0);
        clk : IN STD_LOGIC;
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END plus_one;

ARCHITECTURE a_plus_one OF plus_one IS
    SIGNAL count : unsigned (15 DOWNTO 0);
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            count <= data_in + x"0001";
        END IF;
    END PROCESS;

    data_out <= count;

END ARCHITECTURE a_plus_one;