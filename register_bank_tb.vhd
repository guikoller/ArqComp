LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_bank_tb IS
END ENTITY register_bank_tb;

ARCHITECTURE a_register_bank_tb OF register_bank_tb IS

    COMPONENT register_bank
        PORT (
            selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            selec_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL selec_reg_a : unsigned (2 DOWNTO 0);
    SIGNAL selec_reg_b : unsigned (2 DOWNTO 0);
    SIGNAL selec_reg_write : unsigned (2 DOWNTO 0);
    SIGNAL write_data : unsigned (15 DOWNTO 0);
    SIGNAL write_enable : STD_LOGIC;
    SIGNAL reg_data_a : unsigned (15 DOWNTO 0);
    SIGNAL reg_data_b : unsigned (15 DOWNTO 0);

BEGIN

    uut_register_bank_tb : register_bank
    PORT MAP(
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
        -- Initialize signals
        selec_reg_a <= (OTHERS => '0');
        selec_reg_b <= (OTHERS => '0');
        selec_reg_write <= (OTHERS => '0');
        write_data <= (OTHERS => '0');
        write_enable <= '0';
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
        -- Initialize signals
        selec_reg_a <= (others => '0');
        selec_reg_b <= (others => '0');
        selec_reg_write <= (others => '0');
        write_data <= (others => '0');
        write_enable <= '0';
    BEGIN
        rst <= '1';
        WAIT FOR 20 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    -- Teste de leitura e escrita nos registradores
    test_process : PROCESS
    BEGIN
        -- Initialize signals
        selec_reg_a <= (others => '0');
        selec_reg_b <= (others => '0');
        selec_reg_write <= (others => '0');
        write_data <= (others => '0');
        write_enable <= '0';
        -- Espera o reset terminar
        WAIT FOR 40 ns;

        -- Teste de escrita no registrador 1
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "001";
        write_enable <= '1';
        write_data <= x"1234";
        WAIT FOR 20 ns;

        -- Teste de escrita no registrador 2
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "010";
        write_enable <= '1';
        write_data <= x"4567";
        WAIT FOR 20 ns;

        -- Teste de escrita no registrador 3
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "011";
        write_enable <= '1';
        write_data <= x"ABCD";
        WAIT FOR 20 ns;

        -- Teste de escrita no registrador 4
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "100";
        write_enable <= '1';
        write_data <= x"ac12";
        WAIT FOR 20 ns;

        -- Teste de escrita no registrador 5
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "101";
        write_enable <= '1';
        write_data <= x"5677";
        WAIT FOR 20 ns;

        -- Teste de escrita no registrador 6
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "110";
        write_enable <= '1';
        write_data <= x"d456";
        WAIT FOR 20 ns;

        -- Teste de escrita no registrador 7
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "111";
        write_enable <= '1';
        write_data <= x"FFFF";
        WAIT FOR 20 ns;

        WAIT;
    END PROCESS;
END a_register_bank_tb;