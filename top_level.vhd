LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level IS
    PORT (
        -- op : IN unsigned (1 DOWNTO 0);
        -- result_out : OUT STD_LOGIC;
        clk, rst : IN STD_LOGIC;
        output_pc : OUT unsigned (15 DOWNTO 0);
        instruction : OUT unsigned (15 DOWNTO 0);
        state_output : OUT unsigned (1 DOWNTO 0);
        ula_output : OUT unsigned (15 DOWNTO 0);
        -- zero_out : OUT STD_LOGIC;
        -- selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
        -- selec_reg_write : IN unsigned (2 DOWNTO 0);
        -- write_data : IN unsigned (15 DOWNTO 0);
        -- write_enable : IN STD_LOGIC;
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
            op : IN unsigned(3 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            zero_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT control_unit IS
        PORT (
            opcode : OUT unsigned(3 DOWNTO 0);
            clk, write_enable, rst : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0)
            -- selec_reg_a, selec_reg_b : IN unsigned (2 DOWNTO 0);
            -- selec_reg_write : IN unsigned (2 DOWNTO 0);
            -- write_data : IN unsigned (15 DOWNTO 0);
            -- reg_data_a, reg_data_b : INOUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT control_unit;

    SIGNAL ula_result : unsigned (15 DOWNTO 0);
    SIGNAL reg_data_a_temp, reg_data_b_temp : unsigned (15 DOWNTO 0);
    SIGNAL data_output : unsigned (15 DOWNTO 0);
    SIGNAL pc_output : unsigned (15 DOWNTO 0);
    SIGNAL address : unsigned (15 DOWNTO 0);
    SIGNAL opcode_sig : unsigned (3 DOWNTO 0);
    SIGNAL state : unsigned (1 DOWNTO 0);
    SIGNAL write_en_pc : STD_LOGIC;
    SIGNAL write_en_reg : STD_LOGIC;

BEGIN
    reg_bank : register_bank
    PORT MAP(
        selec_reg_a => selec_reg_a_temp,
        selec_reg_b => selec_reg_b_temp,
        selec_reg_write => selec_reg_write_temp,
        write_data => write_data,
        write_enable => write_en_reg,
        clk => clk,
        rst => rst,
        reg_data_a => reg_data_a_temp,
        reg_data_b => reg_data_b_temp
    );

    ula_unit : ula
    PORT MAP(
        data_in_A => reg_data_a_temp,
        data_in_B => reg_data_b_temp,
        op => op,
        zero_out => zero_out,
        result_out => ula_result
    );

    ctrl_unit : control_unit
    PORT MAP(
        opcode => opcode,
        clk => clk,
        write_enable => write_en_pc,
        rst => rst,
        state_out => state,
        data_out => data_out
    );

    selec_reg_a <= selec_reg_a_temp;

    selec_reg_b <= selec_reg_b_temp;

    selec_reg_write <= selec_reg_write_temp;

    write_data <= ula_result;

    reg_data_b_temp <= reg_data_b WHEN selec_reg_b /= "000" ELSE
        reg_data_b_temp;

    reg_data_a <= reg_data_a_temp;

    op <= "00" WHEN opcode = "0001" ELSE
        "01" WHEN opcode = "0010" ELSE
        "10" WHEN opcode = "0011" ELSE
        "11" WHEN opcode = "0100" ELSE
        "00";

    -- Top level pins
    state_output <= state;
    ula_output <= ula_result;

END a_top_level;