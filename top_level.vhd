LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level IS
    PORT (
        clk, rst : IN STD_LOGIC;
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

    COMPONENT flags_register IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            V_enable, N_enable, Z_enable, C_enable : IN STD_LOGIC;
            V_in, N_in, Z_in, C_in : IN STD_LOGIC;
            V_out, N_out, Z_out, C_out : OUT STD_LOGIC
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
            clk, rst : IN STD_LOGIC;
            state_out : OUT unsigned (1 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL result : unsigned(15 DOWNTO 0);
    SIGNAL zero, negative, carry, carry_in, overflow, immediate_flag, V, N, Z, C : STD_LOGIC;
    SIGNAL opcode_sig : unsigned(3 DOWNTO 0);
    SIGNAL state : unsigned(1 DOWNTO 0);
    SIGNAL selec_reg_a, selec_reg_b : unsigned(2 DOWNTO 0);
    SIGNAL reg_data_a_sig, reg_data_b_sig, ula_a_in, ula_b_in : unsigned(15 DOWNTO 0);
    SIGNAL data_output : unsigned(15 DOWNTO 0);
    SIGNAL op_sig : unsigned(1 DOWNTO 0);
    SIGNAL immediate : unsigned(7 DOWNTO 0);
    SIGNAL write_data : unsigned(15 DOWNTO 0);
    SIGNAL write_en_reg : STD_LOGIC;
    SIGNAL selec_reg_write : unsigned (2 DOWNTO 0);

    SIGNAL en_V : STD_LOGIC;
    SIGNAL en_N : STD_LOGIC;
    SIGNAL en_Z : STD_LOGIC;
    SIGNAL en_C : STD_LOGIC;


    CONSTANT NOP : unsigned(3 DOWNTO 0) := "0000";
    CONSTANT ADD : unsigned(3 DOWNTO 0) := "0001";
    CONSTANT SUB : unsigned(3 DOWNTO 0) := "0010";
    CONSTANT MAIOR : unsigned(3 DOWNTO 0) := "0011";
    CONSTANT JMP : unsigned(3 DOWNTO 0) := "1110";
    CONSTANT CLS : unsigned(3 DOWNTO 0) := "1010";

BEGIN
    ula_inst : ULA
    PORT MAP(
        data_in_A => ula_a_in,
        data_in_B => ula_b_in,
        op => op_sig,
        result_out => result,
        zero_out => zero,
        negative_out => negative,
        carry_out => carry,
        overflow_out => overflow
    );

    flags_reg : flags_register
    PORT MAP(
        clk => clk,
        rst => rst,
        V_enable => en_V,
        N_enable => en_N,
        Z_enable => en_Z,
        C_enable => en_C,
        V_in => overflow,
        N_in => negative,
        Z_in => zero,
        C_in => carry_in,
        V_out => V,
        N_out => N,
        Z_out => Z,
        C_out => C
    );

    reg_bank_inst : register_bank
    PORT MAP(
        selec_reg_a => selec_reg_a,
        selec_reg_b => selec_reg_b,
        selec_reg_write => selec_reg_write,
        write_data => write_data,
        write_enable => write_en_reg,
        clk => clk,
        rst => rst,
        reg_data_a => reg_data_a_sig,
        reg_data_b => reg_data_b_sig
    );
    -- VO TOMA UM GUARANA
    control_unit_inst : control_unit
    PORT MAP(
        opcode => opcode_sig,
        clk => clk,
        rst => rst,
        state_out => state,
        data_out => data_output
    );

    write_en_reg <= '1' WHEN state = "10" ELSE
        '0';

    op_sig <= "00" WHEN opcode_sig = "0001" ELSE
        "01" WHEN opcode_sig = "0010" ELSE
        "10" WHEN opcode_sig = "0011" ELSE
        "11" WHEN opcode_sig = "0100" ELSE
        "00";

    en_C <= '1' when opcode_sig = CLS else '0';
    carry_in <= data_output(0) when opcode_sig = CLS else carry;

    immediate_flag <= data_output(0);
    immediate <= data_output(8 DOWNTO 1);

    selec_reg_a <= to_unsigned(to_integer(data_output(11 DOWNTO 9)), 3);
    selec_reg_b <= to_unsigned(to_integer(data_output(8 DOWNTO 6)), 3);

    ula_a_in <= reg_data_a_sig;
    ula_b_in <= to_unsigned(to_integer(immediate), 16)
        WHEN immediate_flag = '1'
        ELSE
        reg_data_b_sig;

    selec_reg_write <= selec_reg_a WHEN immediate_flag = '1' ELSE
        to_unsigned(to_integer(data_output(5 DOWNTO 3)), 3);

    write_data <= to_unsigned(to_integer(immediate), 16) WHEN opcode_sig = "1000" ELSE
        result;

    result_out <= result;
    opcode <= opcode_sig;
    state_out <= state;
    reg_data_a <= reg_data_a_sig;
    reg_data_b <= reg_data_b_sig;
END ARCHITECTURE a_top_level;