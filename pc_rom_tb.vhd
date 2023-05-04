LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc_rom_tb IS
END ENTITY pc_rom_tb;

ARCHITECTURE a_pc_rom_tb OF pc_rom_tb IS
    COMPONENT pc_rom IS
        PORT (
            clk, write_enable, rst : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL write_enable : STD_LOGIC := '1';
    SIGNAL data_out : unsigned(15 DOWNTO 0);

BEGIN
    uut : pc_rom
    PORT MAP(
        clk => clk,
        write_enable => write_enable,
        rst => rst,
        data_out => data_out
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

    -- Reset inicial
    reset_process : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN
        WAIT;
    END PROCESS;

END a_pc_rom_tb;