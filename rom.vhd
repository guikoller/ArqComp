LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
    PORT (
        clk : IN STD_LOGIC;
        address : IN unsigned (15 DOWNTO 0); --MOS 6502 has 8 bit address, which means 256 addresses
        data : OUT unsigned (15 DOWNTO 0) --The processor has 16 bit data width
    );
END rom;

ARCHITECTURE a_rom OF rom IS
    TYPE mem IS ARRAY (0 TO 255) OF unsigned (15 DOWNTO 0);
    CONSTANT content_rom : mem := (
        0   => "0000000000000000",
        1   => "1000000000010101",
        2   => "0110000000000001",
        3   => "1000000000000011",
        4   => "0001000111011000",
        5   => "0001011111001001",
        OTHERS => (OTHERS => '0')
    );

BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            data <= content_rom(to_integer(address));
        END IF;
    END PROCESS;
END a_rom;