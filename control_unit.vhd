LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit IS
    PORT (
        opcode : OUT unsigned(3 DOWNTO 0);
        clk, write_enable, rst : IN STD_LOGIC;
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY control_unit;

ARCHITECTURE a_control_unit OF control_unit IS
    COMPONENT pc_plus_one IS
        PORT (
            clk, write_enable, rst, branch : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0);
            address : IN unsigned(15 DOWNTO 0)
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
            state : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL data_output : unsigned (15 DOWNTO 0);
    SIGNAL pc_output : unsigned (15 DOWNTO 0);
    SIGNAL address : unsigned (15 DOWNTO 0);
    SIGNAL op : unsigned (3 DOWNTO 0);
    SIGNAL state : STD_LOGIC;
    SIGNAL branch : STD_LOGIC;
    SIGNAL write_en : STD_LOGIC;

BEGIN
    st_machine : state_machine
    PORT MAP(
        clk => clk,
        rst => rst,
        state => state
    );

    pc : pc_plus_one
    PORT MAP(
        clk => clk,
        write_enable => write_en,
        rst => rst,
        branch => branch,
        data_out => pc_output,
        address => address
    );

    read_only_memory : rom
    PORT MAP(
        clk => clk,
        address => address,
        data => data_output
    );

    write_en <= '1' WHEN state = '0' ELSE
        '0';

    op <= data_output(15 DOWNTO 12);z
    opcode <= op;

    branch <= '1' when op = "1110" else '0';

    address <= "0000000000000000"  when op = "1110" else pc_output;

    data_out <= data_output;
        

END ARCHITECTURE a_control_unit;