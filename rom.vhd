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
        0 => "0000000000000000",
        1 => "0001011000001011",
        2 => "0001100000010001",
        3 => "0001011100101000",
        4 => "0010101110001100",
        5 => "1110100100000111",
        6 => "1110001011001001",
        7 => "0100101011011001",
        8 => "1111100011000000",
        9 => "1110101111000000",
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