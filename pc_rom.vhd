LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pc_rom IS
    PORT (
        clk, write_enable, rst : IN STD_LOGIC;
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY pc_rom;

ARCHITECTURE a_pc_rom OF pc_rom IS
    COMPONENT pc_plus_one IS
        PORT (
            clk, write_enable, rst : IN STD_LOGIC;
            data_out : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom IS
        PORT (
            clk : IN STD_LOGIC;
            address : IN unsigned(7 DOWNTO 0);
            data : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL output_pc : unsigned (15 DOWNTO 0);

BEGIN
    pc : pc_plus_one
    PORT MAP(
        clk => clk,
        write_enable => write_enable,
        rst => rst,
        data_out => output_pc
    );

    read_only_memory : rom
    PORT MAP(
        clk => clk,
        address => output_pc(7 downto 0),
        data => data_out
    );

END ARCHITECTURE a_pc_rom;