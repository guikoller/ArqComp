LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pc_plus_one IS
    PORT (
        clk, write_enable, rst, branch : IN STD_LOGIC;
        data_out : OUT unsigned(15 DOWNTO 0);
        address : IN unsigned(15 DOWNTO 0)
    );
END ENTITY pc_plus_one;

ARCHITECTURE a_pc_plus_one OF pc_plus_one IS

    COMPONENT program_counter IS
        PORT (
            data_in : IN unsigned(15 DOWNTO 0);
            clk, write_enable, rst : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT plus_one IS
        PORT (
            data_in : IN unsigned(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL output_pc, output_plus_one, pc_in : unsigned (15 DOWNTO 0);

BEGIN
    pc: program_counter
        PORT MAP (
            data_in => pc_in,
            clk => clk,
            write_enable => write_enable,
            rst => rst,
            data_out => output_pc
        );

    count_one: plus_one
        PORT MAP (
            data_in => output_pc,
            clk => clk,
            data_out => output_plus_one
        );

    pc_in <= address when branch = '1' else output_plus_one;
    data_out <= output_pc;
END ARCHITECTURE a_pc_plus_one;
