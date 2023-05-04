LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit_tb IS
END control_unit_tb;

ARCHITECTURE a_control_unit_tb OF control_unit_tb IS
    COMPONENT control_unit IS
        PORT (
            opcode : IN unsigned(3 DOWNTO 0);
            clk, write_enable, rst : IN STD_LOGIC;
            data_out : INOUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL opcode : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL write_enable : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL data_out : unsigned(15 DOWNTO 0) := (others => '0');

BEGIN
    uut : control_unit
    PORT MAP(
        opcode => opcode,
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

END ARCHITECTURE a_control_unit_tb;