LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LAB1_TopLevel IS
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
END ENTITY LAB1_TopLevel;

ARCHITECTURE a_LAB1_TopLevel OF LAB1_TopLevel IS
    COMPONENT register_bank IS
        PORT (
            selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            selec_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
        );

    END COMPONENT;

    COMPONENT ULA IS
        PORT (
            data_in_A : IN unsigned(15 DOWNTO 0);
            data_in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out : OUT STD_LOGIC
        );

    END COMPONENT;

    signal reg_data_0, reg_data_1, result_outt: unsigned (15 downto 0);

begin
    reg_bank: register_bank PORT MAP(selec_reg_a => selec_reg_a, selec_reg_b => selec_reg_b, selec_reg_write => selec_reg_write, clk => clk, rst => rst, write_enable => write_enable, write_data => write_data, reg_data_a => reg_data_0, reg_data_b => reg_data_1);
    alu: ULA port map (data_in_a => reg_data_0, data_in_b => reg_data_1, op => op, result_out => result_out, zero_out => zero_out);


end architecture a_LAB1_TopLevel;
