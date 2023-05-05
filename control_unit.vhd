LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit IS
    PORT (
        opcode : IN unsigned(3 DOWNTO 0);
        clk, write_enable, rst : IN STD_LOGIC;
        data_out : INOUT unsigned(15 DOWNTO 0)
    );
END ENTITY control_unit;

ARCHITECTURE a_control_unit OF control_unit IS
    COMPONENT pc_rom IS
        PORT (
            clk, write_enable, rst : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT state_machine IS
        PORT (
            clk, rst : IN STD_LOGIC;
            state : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL sig_data_out : unsigned (15 DOWNTO 0);
    signal sig_op : unsigned (3 downto 0);
    SIGNAL sig_state : std_logic;

    begin
        st_machine: state_machine port map (
            clk => clk,
            rst => rst,
            state
            );

        

END ARCHITECTURE a_control_unit;