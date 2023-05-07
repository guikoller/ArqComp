LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit IS
    PORT (
        opcode : OUT unsigned(3 DOWNTO 0);
        clk, write_enable, rst : IN STD_LOGIC;
        data_out : INOUT unsigned(15 DOWNTO 0)
    );
END ENTITY control_unit;

ARCHITECTURE a_control_unit OF control_unit IS
    COMPONENT pc_rom IS
        PORT (
            clk, write_enable, rst : IN STD_LOGIC;
            data_out, address : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT state_machine IS
        PORT (
            clk, rst : IN STD_LOGIC;
            state : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL data_output : unsigned (15 DOWNTO 0);
    SIGNAL address : unsigned (15 DOWNTO 0);
    SIGNAL op : unsigned (3 DOWNTO 0);
    SIGNAL state : STD_LOGIC;
    SIGNAL write_en : STD_LOGIC;

BEGIN
    st_machine : state_machine PORT MAP(
        clk => clk,
        rst => rst,
        state => state
    );

    rom_pc : pc_rom PORT MAP(
        clk => clk, 
        write_enable => write_en, 
        rst => rst,
        data_out => data_output,
        address => address
    );

    write_en <= '1' when state = '0' else '0';

    op <= data_output(15 downto 12);
    opcode <= op;

    data_out <= to_unsigned(to_integer(address + 3), 16)   when op = "1110" else data_output;

END ARCHITECTURE a_control_unit;