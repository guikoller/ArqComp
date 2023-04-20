LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LAB1_TopLevel_tb IS
END ENTITY LAB1_TopLevel_tb;

ARCHITECTURE a_LAB1_TopLevel_tb OF LAB1_TopLevel_tb IS

    COMPONENT LAB1_TopLevel IS
        PORT (
            data_in_A : IN unsigned(15 DOWNTO 0);
            data_in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out : OUT STD_LOGIC;
            selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            selec_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT; 

    -- Inputs
    SIGNAL data_in_A : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL data_in_B : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL op : unsigned(1 DOWNTO 0) := "00";
    SIGNAL selec_reg_a : unsigned(2 DOWNTO 0) := "000";
    SIGNAL selec_reg_b : unsigned(2 DOWNTO 0) := "001";
    SIGNAL selec_reg_write : unsigned(2 DOWNTO 0) := "010";
    SIGNAL write_data : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL write_enable : STD_LOGIC := '0';
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';

    -- Outputs
    SIGNAL result_out : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL zero_out : STD_LOGIC := '0';
    SIGNAL reg_data_a : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL reg_data_b : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

    uut : LAB1_TopLevel PORT MAP(
        data_in_A => data_in_A,
        data_in_B => data_in_B,
        op => op,
        result_out => result_out,
        zero_out => zero_out,
        selec_reg_a => selec_reg_a,
        selec_reg_b => selec_reg_b,
        selec_reg_write => selec_reg_write,
        write_data => write_data,
        write_enable => write_enable,
        clk => clk,
        rst => rst,
        reg_data_a => reg_data_a,
        reg_data_b => reg_data_b
    );
    -- Geração de clock
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

    -- Teste de leitura e escrita nos registradores
    test_process : PROCESS
    BEGIN
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000001";
        selec_reg_a <= "000";
        selec_reg_b <= "100";
        selec_reg_write <= "000";
        write_enable <= '0';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000001";
        selec_reg_a <= "000";
        selec_reg_b <= "100";
        selec_reg_write <= "100";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000001";
        selec_reg_a <= "001";
        selec_reg_b <= "001";
        selec_reg_write <= "000";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000000";
        selec_reg_a <= "000";
        selec_reg_b <= "001";
        selec_reg_write <= "010";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000000";
        selec_reg_a <= "010";
        selec_reg_b <= "101";
        selec_reg_write <= "111";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000001";
        selec_reg_a <= "011";
        selec_reg_b <= "100";
        selec_reg_write <= "101";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000001";
        selec_reg_a <= "000";
        selec_reg_b <= "101";
        selec_reg_write <= "100";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000000";
        selec_reg_a <= "010";
        selec_reg_b <= "100";
        selec_reg_write <= "110";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000001";
        selec_reg_a <= "110";
        selec_reg_b <= "100";
        selec_reg_write <= "011";
        write_enable <= '1';
        WAIT FOR 40 ns;
        op <= "00";
        data_in_b <= "0000000000000000";
        selec_reg_a <= "010";
        selec_reg_b <= "100";
        selec_reg_write <= "010";
        write_enable <= '1';
        WAIT FOR 40 ns;
        write_enable <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE a_LAB1_TopLevel_tb;