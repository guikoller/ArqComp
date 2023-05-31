LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit IS
    PORT (
        opcode : OUT unsigned(3 DOWNTO 0);
        clk, rst, branch : IN STD_LOGIC;
        state_out : OUT unsigned (1 DOWNTO 0);
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY control_unit;

ARCHITECTURE a_control_unit OF control_unit IS
    COMPONENT program_counter IS
        PORT (
            clk, write_enable, rst, branch : IN STD_LOGIC;
            data_in, address : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom IS
        PORT (
            clk : IN STD_LOGIC;
            address : IN unsigned(15 DOWNTO 0);
            data : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT state_machine IS
        PORT (
            clk, rst : IN STD_LOGIC;
            state : OUT unsigned (1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL data_output : unsigned (15 DOWNTO 0);
    SIGNAL pc_input : unsigned (15 DOWNTO 0);
    SIGNAL pc_output : unsigned (15 DOWNTO 0);
    SIGNAL address : unsigned (15 DOWNTO 0);
    SIGNAL jump : unsigned (15 DOWNTO 0);
    SIGNAL signed_jump : signed (16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL signed_pc_output : signed (16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL signed_result : signed (16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_in : unsigned (15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL opcode_sig : unsigned (3 DOWNTO 0);
    SIGNAL state : unsigned (1 DOWNTO 0);
    SIGNAL is_negative : STD_LOGIC;
    SIGNAL write_en_pc : STD_LOGIC;
    
BEGIN
    st_machine : state_machine
    PORT MAP(
        clk => clk,
        rst => rst,
        state => state
    );

    pc : program_counter
    PORT MAP(
        clk => clk,
        write_enable => write_en_pc,
        rst => rst,
        branch => branch,
        data_in => pc_output,
        data_out => pc_output,
        address => address
    );

    read_only_memory : rom
    PORT MAP(
        clk => clk,
        address => address,
        data => data_output
    );

    write_en_pc <= '1' WHEN state = "00" ELSE
        '0';

    opcode_sig <= data_output(15 DOWNTO 12);

    jump <= to_unsigned(to_integer(data_output(5 DOWNTO 0)), 16);
    is_negative <= data_output(6);

    signed_jump <= signed('1' & not(jump) + 1) when is_negative = '1' else signed('0' & jump);
    signed_pc_output <= signed('0' & pc_output);
    signed_result <= signed_jump + signed_pc_output;

    pc_input <= unsigned(resize(signed_result(16 downto 0), 16)); -- result of relative jump
    
    address <= jump WHEN branch = '1' AND opcode_sig = "1110" ELSE
        pc_input WHEN branch = '1' AND opcode_sig = "1111" ELSE
        pc_output;

    opcode <= opcode_sig;
    data_out <= data_output;
    state_out <= state;
END ARCHITECTURE a_control_unit;