LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level IS
    PORT (
        op : IN unsigned (1 DOWNTO 0);
        result_out : OUT STD_LOGIC;
        clk, rst : IN STD_LOGIC;
        zero_out : OUT STD_LOGIC;
        selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
        selec_reg_write : IN unsigned (2 DOWNTO 0);
        write_data : IN unsigned (15 DOWNTO 0);
        write_enable : IN STD_LOGIC;
        reg_data_a, reg_data_b : INOUT unsigned (15 DOWNTO 0)
    );
END ENTITY top_level;

ARCHITECTURE a_top_level OF top_level IS
    COMPONENT register_bank IS
        PORT (
            selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            selec_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ula IS
        PORT (
            data_in_A : IN unsigned(15 DOWNTO 0);
            data_in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL ula_result : unsigned (15 DOWNTO 0);
    SIGNAL reg_data_a_temp, reg_data_b_temp : unsigned (15 DOWNTO 0);

BEGIN
    reg_bank : register_bank PORT MAP(
        selec_reg_a => selec_reg_a,
        selec_reg_b => selec_reg_b,
        selec_reg_write => selec_reg_write,
        write_data => write_data,
        write_enable => write_enable,
        clk => clk,
        rst => rst,
        reg_data_a => reg_data_a_temp,
        reg_data_b => reg_data_b_temp
    );

    ula_unit : ula PORT MAP(
        data_in_A => reg_data_a_temp,
        data_in_B => reg_data_b_temp,
        op => op,
        zero_out => zero_out,
        result_out => ula_result
    );

    reg_data_b_temp <= reg_data_b WHEN selec_reg_b /= "000" ELSE
        reg_data_b_temp;

    reg_data_a <= reg_data_a_temp;

END a_top_level;