LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_bank IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        write_enable : IN STD_LOGIC;
        write_data : IN UNSIGNED(15 DOWNTO 0);
        read_select1 : IN UNSIGNED(2 DOWNTO 0);
        read_select2 : IN UNSIGNED(2 DOWNTO 0);
        read_data1 : OUT UNSIGNED(15 DOWNTO 0);
        read_data2 : OUT UNSIGNED(15 DOWNTO 0)
    );
END register_bank;

ARCHITECTURE a_register_bank OF register_bank IS
    COMPONENT register_unit -- Componente do registrador
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            write_enable : IN STD_LOGIC;
            write_data : IN UNSIGNED(15 DOWNTO 0);
            read_data : OUT UNSIGNED(15 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL reg_data_0, reg_data_1, reg_data_2, reg_data_3, reg_data_4, reg_data_5, reg_data_6, reg_data_7: unsigned(15 DOWNTO 0); -- Array de 8 registradores
BEGIN
    -- Instanciação dos registradores
    reg0 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => '0', write_data => (OTHERS => '0'), read_data => reg_data_0);
    reg1 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_1);
    reg2 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_2);
    reg3 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_3);
    reg4 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_4);
    reg5 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_5);
    reg6 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_6);
    reg7 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, read_data => reg_data_7);

    read_data1 <= reg_data(to_integer(unsigned(read_select1))); -- Saída do valor do registrador selecionado para leitura 1
    read_data2 <= reg_data(to_integer(unsigned(read_select2))); -- Saída do valor do registrador selecionado para leitura 2
END a_register_bank;
