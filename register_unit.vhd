LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity register_unit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           write_enable : in STD_LOGIC;
           write_data : in UNSIGNED(15 downto 0);
           read_data : out UNSIGNED(15 downto 0));
end register_unit;

architecture a_register_unit of register_unit is
    signal reg_data : unsigned(15 downto 0) := (others => '0'); -- Registrador com valor inicial de 0
begin
    process(clk, rst, write_enable)
    begin
        if rst = '1' then-- Reset ativo
            reg_data <= (others => '0');-- Zera o registrador
        elsif write_enable = '1' then   -- Habilita escrita              
            if rising_edge(clk) then -- Clock
                reg_data <= write_data; -- Escreve no registrador
            end if;
        end if;
    end process;
    read_data <= reg_data; -- Saída do valor do registrador
end a_register_unit;