library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    Port ( 
	   data_in_A : in  unsigned (15 downto 0);
           data_in_B : in  unsigned (15 downto 0);
           result_out : out  unsigned (15 downto 0);
           flag_out : out  std_logic
   );
end ula;

architecture a_ula of ula is
begin
    -- Soma
    result_out <= data_in_A + data_in_B;

    -- Subtração (utilizando complemento de 2)
    result_out <= data_in_A + (not data_in_B) + 1;

    -- Comparação (retorna 1 se A >= B, 0 caso contrário)
    flag_out <= '1' when data_in_A >= data_in_B else '0';

end a_ula;


