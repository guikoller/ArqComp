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
        0 => "0000000000000000",
        1 => "1000001000001011",
        2 => "1000000000000011",
        3 => "0001000001000000",
        4 => "0101000010000000",
        5 => "0001001000001011",
        6 => "0001010000000011",
        7 => "1010000000000000",
        8 => "0100010000101001",
        9 => "1111000001000110",
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

-- 0 => "0000000000000000",
-- 1 => "1000000000010101",
-- 2 => "0110000000000001",
-- 3 => "0110000000000010",
-- 4 => "0110000000000011",
-- 5 => "0110000000000100",
-- 6 => "0110000000000101",
-- 7 => "0110000000000110",
-- 8 => "0110000000000111",
-- 9 => "1000000000000011",
-- 10 => "0001000111011000",
-- 11 => "0001011111001001",
-- 12 => "1000000000000101",
-- 13 => "0001000111011000",
-- 14 => "0001011111001001",
-- 15 => "1000000000000111",
-- 16 => "0001000111011000",
-- 17 => "0001011111001001",
-- 18 => "1000000000001001",
-- 19 => "0001000111011000",
-- 20 => "0001011111001001",
-- 21 => "1000000000001011",
-- 22 => "0001000111011000",
-- 23 => "0001011111001001",
-- 24 => "1000000000001101",
-- 25 => "0001000111011000",
-- 26 => "0001011111001001",
-- 27 => "1000000000001111",
-- 28 => "0001000111011000",
-- 29 => "0001011111001001",