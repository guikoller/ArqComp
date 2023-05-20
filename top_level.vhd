LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level IS
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
END ENTITY top_level;

ARCHITECTURE a_top_level OF top_level IS
    COMPONENT ULA IS
        PORT (
            data_in_A : IN unsigned(15 DOWNTO 0);
            data_in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out, negative_out, carry_out, overflow_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT register_bank IS
        PORT (
            selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            selec_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data_a, reg_data_b : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT control_unit IS
        PORT (
            opcode : OUT unsigned(3 DOWNTO 0);
            op : OUT unsigned (1 DOWNTO 0);
            clk, write_enable, rst : IN STD_LOGIC;
            state_out : OUT unsigned (1 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL result : unsigned(15 DOWNTO 0);
    SIGNAL zero, negative, carry, overflow, immediate_flag : STD_LOGIC;
    SIGNAL opcode_sig : unsigned(3 DOWNTO 0);
    SIGNAL state : unsigned(1 DOWNTO 0);
    SIGNAL reg_data_a_sig, reg_data_b_sig : unsigned(15 DOWNTO 0);
    SIGNAL data_output : unsigned(15 DOWNTO 0);
    SIGNAL op_sig : unsigned(1 DOWNTO 0);
    SIGNAL immediate : unsigned(7 DOWNTO 0);

BEGIN
    ula_inst : ULA
    PORT MAP(
        data_in_A => reg_data_a_sig,
        data_in_B => reg_data_b_sig,
        op => op_sig,
        result_out => result,
        zero_out => zero,
        negative_out => negative,
        carry_out => carry,
        overflow_out => overflow
    );

    reg_bank_inst : register_bank
    PORT MAP(
        selec_reg_a => selec_reg_a,
        selec_reg_b => selec_reg_b,
        selec_reg_write => selec_reg_write,
        write_data => write_data,
        write_enable => write_enable,
        clk => clk,
        rst => rst,
        reg_data_a => reg_data_a_sig,
        reg_data_b => reg_data_b_sig
    );

    control_unit_inst : control_unit
    PORT MAP(
        opcode => opcode_sig,
        op => op_sig,
        clk => clk,
        write_enable => write_enable,
        rst => rst,
        state_out => state,
        data_out => data_output
    );

    op_sig <=   "00" WHEN opcode_sig = "0001" ELSE
            "01" WHEN opcode_sig = "0010" ELSE
            "10" WHEN opcode_sig = "0011" ELSE
            "11" WHEN opcode_sig = "0100" ELSE
            "00";

    immediate_flag <= data_output(0);
    immediate <= data_output(8 DOWNTO 1);

    reg_data_a_sig <=   to_unsigned(to_integer(data_output(11 DOWNTO 9)), 16);
    reg_data_b_sig <=   to_unsigned(to_integer(data_output(8 DOWNTO 5)), 16)  
                        when immediate_flag = '0' 
                        else to_unsigned(to_integer(immediate), 16);

    result_out <= result;
    opcode <= opcode_sig;
    state_out <= state;
    reg_data_a <= reg_data_a_sig;
    reg_data_b <= reg_data_b_sig;
END ARCHITECTURE a_top_level;