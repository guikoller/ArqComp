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

    SIGNAL op : unsigned(3 DOWNTO 0);
    SIGNAL temp_data_out : unsigned (15 DOWNTO 0);
    SIGNAL jump_en : STD_LOGIC;
BEGIN
    temp_data_out <= data_out;
    -- opcode in 4 bits MSB
    op <= data_out(15 DOWNTO 12);

    --jump: opcode 1110
    jump_en <= '1' WHEN op = "1110" ELSE
        '0';

    -- instantiate pc_rom component
    pc_rom_inst : pc_rom
    PORT MAP(
        clk => clk,
        write_enable => write_enable,
        rst => rst,
        data_out => temp_data_out
    );

    -- increment data_out by 3 when jump_en is '1'
    data_out <= temp_data_out + 3 WHEN jump_en = '1' ELSE
        data_out + 0;
END ARCHITECTURE a_control_unit;