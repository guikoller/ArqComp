LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level_tb IS
END ENTITY top_level_tb;

ARCHITECTURE a_top_level_tb OF top_level_tb IS
    -- Component declaration
    COMPONENT top_level
        PORT (
            selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            selec_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            opcode : OUT unsigned(3 DOWNTO 0);
            state_out : OUT unsigned (1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL selec_reg_a_sig, selec_reg_b_sig, selec_reg_write_sig : unsigned (2 DOWNTO 0);
    SIGNAL write_data_sig : unsigned (15 DOWNTO 0);
    SIGNAL write_enable_sig, clk, rst : STD_LOGIC;
    SIGNAL opcode_sig : unsigned(3 DOWNTO 0);
    SIGNAL state_out_sig : unsigned (1 DOWNTO 0);
    SIGNAL result_out_sig : unsigned(15 DOWNTO 0);
    SIGNAL reg_data_a_sig, reg_data_b_sig : unsigned (15 DOWNTO 0);

BEGIN
    uut : top_level
    PORT MAP(
        selec_reg_a => selec_reg_a_sig,
        selec_reg_b => selec_reg_b_sig,
        selec_reg_write => selec_reg_write_sig,
        write_data => write_data_sig,
        write_enable => write_enable_sig,
        clk => clk,
        rst => rst,
        opcode => opcode_sig,
        state_out => state_out_sig,
        result_out => result_out_sig,
        reg_data_a => reg_data_a_sig,
        reg_data_b => reg_data_b_sig
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
        WAIT FOR 20 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN
        WAIT;
    END PROCESS;

END ARCHITECTURE a_top_level_tb;