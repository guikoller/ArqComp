LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_bank IS
    PORT (
        selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
        selec_reg_write : IN unsigned (2 DOWNTO 0);
        write_data : IN unsigned (15 DOWNTO 0);
        write_enable, clk, rst : IN STD_LOGIC;
        reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_register_bank OF register_bank IS
    COMPONENT register_unit IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            write_enable : IN STD_LOGIC;
            write_data : IN UNSIGNED(15 DOWNTO 0);
            read_data : OUT UNSIGNED(15 DOWNTO 0));
    END COMPONENT;

    SIGNAL read_data_0, read_data_1, read_data_2, read_data_3, read_data_4, read_data_5, read_data_6, read_data_7 : unsigned (15 DOWNTO 0);
    SIGNAL write_enable_1, write_enable_2, write_enable_3, write_enable_4, write_enable_5, write_enable_6, write_enable_7 : STD_LOGIC;

BEGIN
    reg0 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => '0', write_data => (OTHERS => '0'), read_data => read_data_0);
    reg1 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_1, write_data => write_data, read_data => read_data_1);
    reg2 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_2, write_data => write_data, read_data => read_data_2);
    reg3 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_3, write_data => write_data, read_data => read_data_3);
    reg4 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_4, write_data => write_data, read_data => read_data_4);
    reg5 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_5, write_data => write_data, read_data => read_data_5);
    reg6 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_6, write_data => write_data, read_data => read_data_6);
    reg7 : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_7, write_data => write_data, read_data => read_data_7);

    reg_data_a <=   read_data_0 WHEN selec_reg_a = "000" ELSE
                    read_data_1 WHEN selec_reg_a = "001" ELSE
                    read_data_2 WHEN selec_reg_a = "010" ELSE
                    read_data_3 WHEN selec_reg_a = "011" ELSE
                    read_data_4 WHEN selec_reg_a = "100" ELSE
                    read_data_5 WHEN selec_reg_a = "101" ELSE
                    read_data_6 WHEN selec_reg_a = "110" ELSE
                    read_data_7 WHEN selec_reg_a = "111" ELSE
                    "0000000000000000";

    reg_data_b <=   read_data_0 WHEN selec_reg_b = "000" ELSE
                    read_data_1 WHEN selec_reg_b = "001" ELSE
                    read_data_2 WHEN selec_reg_b = "010" ELSE
                    read_data_3 WHEN selec_reg_b = "011" ELSE
                    read_data_4 WHEN selec_reg_b = "100" ELSE
                    read_data_5 WHEN selec_reg_b = "101" ELSE
                    read_data_6 WHEN selec_reg_b = "110" ELSE
                    read_data_7 WHEN selec_reg_b = "111" ELSE
                    "0000000000000000";

    write_enable_1 <= write_enable WHEN selec_reg_write = "001" ELSE
        '0';
    write_enable_2 <= write_enable WHEN selec_reg_write = "010" ELSE
        '0';
    write_enable_3 <= write_enable WHEN selec_reg_write = "011" ELSE
        '0';
    write_enable_4 <= write_enable WHEN selec_reg_write = "100" ELSE
        '0';
    write_enable_5 <= write_enable WHEN selec_reg_write = "101" ELSE
        '0';
    write_enable_6 <= write_enable WHEN selec_reg_write = "110" ELSE
        '0';
    write_enable_7 <= write_enable WHEN selec_reg_write = "111" ELSE
        '0';
END a_register_bank;