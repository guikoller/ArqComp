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

    SIGNAL read_data_A, read_data_X, read_data_Y, read_data_SP : unsigned (15 DOWNTO 0);
    SIGNAL write_enable_A, write_enable_X, write_enable_Y, write_enable_SP : STD_LOGIC;

BEGIN
    regA : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_A, write_data => write_data, read_data => read_data_A);
    regX : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_X, write_data => write_data, read_data => read_data_X);
    regY : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_Y, write_data => write_data, read_data => read_data_Y);
    regSP : register_unit PORT MAP(clk => clk, rst => rst, write_enable => write_enable_SP, write_data => write_data, read_data => read_data_SP);
    
    reg_data_a <=   read_data_A WHEN selec_reg_a = "000" ELSE
                    read_data_X WHEN selec_reg_a = "001" ELSE
                    read_data_Y WHEN selec_reg_a = "010" ELSE
                    read_data_SP WHEN selec_reg_a = "011" ELSE
                    "0000000000000000";

    reg_data_b <=   read_data_A WHEN selec_reg_b = "000" ELSE
                    read_data_X WHEN selec_reg_b = "001" ELSE
                    read_data_Y WHEN selec_reg_b = "010" ELSE
                    read_data_SP WHEN selec_reg_b = "011" ELSE
                    "0000000000000000";
                    
    write_enable_A <= write_enable WHEN selec_reg_write = "000" ELSE
    '0';
    write_enable_X <= write_enable WHEN selec_reg_write = "001" ELSE
        '0';
    write_enable_Y <= write_enable WHEN selec_reg_write = "010" ELSE
        '0';
    write_enable_SP <= write_enable WHEN selec_reg_write = "011" ELSE
        '0';
    
END a_register_bank;