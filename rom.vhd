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
        -- caso address => content
        0 => "0100110110000011",
        1 => "1100010101010000",
        2 => "0001001001111001",
        3 => "1000000111111000",
        4 => "0010101110001100",
        5 => "1110100100001101",
        6 => "1110001011001001",
        7 => "0100101011011001",
        8 => "1111100011000000",
        9 => "1110101111000111",
        10 => "1110100100111101",

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