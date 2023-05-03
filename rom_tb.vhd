LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom_tb IS
END rom_tb;

ARCHITECTURE a_rom_tb OF rom_tb IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL address : UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data : UNSIGNED(15 DOWNTO 0);

    COMPONENT rom
        PORT (
            clk : IN STD_LOGIC;
            address : IN UNSIGNED(7 DOWNTO 0);
            data : OUT UNSIGNED(15 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    uut : rom
    PORT MAP (
        clk => clk,
        address => address,
        data => data
    );

    clk_process : PROCESS
    BEGIN
        WHILE now < 1000 ns LOOP
            clk <= '0';
            WAIT FOR 10 ns;
            clk <= '1';
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN
        -- Initialize inputs
        address <= (OTHERS => '0');

        -- Test 1: read address 0
        address <= x"00";
        WAIT FOR 40 ns;

        -- Test 2: read address 1
        address <= x"01";
        WAIT FOR 40 ns;

        -- Test 3: read address 2
        address <= x"02";
        WAIT FOR 40 ns;

        -- Test 3: read address 3
        address <= x"03";
        WAIT FOR 40 ns;

        -- Test 3: read address 4
        address <= x"04";
        WAIT FOR 40 ns;
        
        -- Test 3: read address 5
        address <= x"05";
        WAIT FOR 40 ns;

        -- Test 3: read address 6
        address <= x"06";
        WAIT FOR 40 ns;

        -- Test 3: read address 7
        address <= x"07";
        WAIT FOR 40 ns;

        -- Test 3: read address 8
        address <= x"08";
        WAIT FOR 40 ns;

        -- Test 3: read address 9
        address <= x"09";
        WAIT FOR 40 ns;

        -- Test 3: read address 9
        address <= x"0A";
        WAIT FOR 40 ns;

        -- Test 4: read address 255
        address <=  x"FF";
        WAIT FOR 40 ns;

        WAIT;
    END PROCESS;

END a_rom_tb;
