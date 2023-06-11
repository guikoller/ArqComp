LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ULA IS
    PORT (
        data_in_A : IN unsigned(15 DOWNTO 0);
        data_in_B : IN unsigned(15 DOWNTO 0);
        op : IN unsigned(1 DOWNTO 0);
        result_out : OUT unsigned(15 DOWNTO 0);
        zero_out, negative_out, carry_out : OUT STD_LOGIC
        -- overflow_out : OUT STD_LOGIC
    );
END ULA;

ARCHITECTURE A_ULA OF ULA IS
    SIGNAL temp : unsigned(15 DOWNTO 0);
    SIGNAL carry_sum : unsigned (16 DOWNTO 0);
    SIGNAL carry, carry_minus : STD_LOGIC;
    -- SIGNAL overflow : STD_LOGIC;
BEGIN

    temp <= data_in_a + data_in_b WHEN op = "00" ELSE
        data_in_a - data_in_b WHEN op = "01" ELSE
        data_in_a - data_in_b WHEN op = "10" ELSE
        data_in_a - data_in_b WHEN op = "11" ELSE -- 01 -> Subtração, 10 -> Comparação de Igual, 11 -> Comparação de Maior
        "0000000000000000";

    carry_sum <= to_unsigned(to_integer(data_in_A), 17) + to_unsigned(to_integer(data_in_B), 17);

    carry_minus <= '0' WHEN data_in_b <= data_in_a ELSE
        '1';

    carry <= carry_sum(16) WHEN op = "00" ELSE
        carry_minus WHEN op = "01" ELSE
        '0';

    zero_out <= '1' WHEN data_in_a = data_in_b ELSE
        '0';

    carry_out <= carry;
    -- overflow_out <= overflow;
    negative_out <= temp(15);
    result_out <= temp(15 DOWNTO 0);
END A_ULA;

-- LIBRARY ieee;
-- USE ieee.std_logic_1164.ALL;
-- USE ieee.numeric_std.ALL;

-- ENTITY ULA IS
--     PORT (
--         data_in_A : IN unsigned(15 DOWNTO 0);
--         data_in_B : IN unsigned(15 DOWNTO 0);
--         op : IN unsigned(1 DOWNTO 0);
--         result_out : OUT unsigned(15 DOWNTO 0);
--         zero_out, negative_out, carry_out, overflow_out : OUT STD_LOGIC
--     );
-- END ULA;

-- ARCHITECTURE A_ULA OF ULA IS
--     SIGNAL temp : unsigned(15 DOWNTO 0);
--     SIGNAL carry_sum : unsigned (16 downto 0);
--     SIGNAL negative, carry, overflow : STD_LOGIC;
-- BEGIN
--     PROCESS (data_in_A, data_in_B, op) BEGIN
--         CASE op IS
--             WHEN "00" =>
--                 -- Soma
--                 temp <= data_in_A + data_in_B;
--                 carry_sum <= to_unsigned(to_integer(data_in_A), 17) + to_unsigned(to_integer(data_in_B), 17);
--                 carry <= carry_sum(16);

--                 IF (data_in_A + data_in_B) > "1111111111111111" THEN
--                     overflow <= '1';
--                 ELSE
--                     overflow <= '0';
--                 END IF;

--             WHEN "01" =>
--                 -- Subtração
--                 temp <= data_in_A - data_in_B;

--                 IF data_in_A <= data_in_B THEN
--                     negative <= '1';
--                 ELSE
--                     negative <= '0';
--                 END IF;
--             WHEN "10" =>
--                 -- Comparação igual
--                 IF data_in_A = data_in_B THEN
--                     temp <= "0000000000000001";
--                 ELSE
--                     temp <= "0000000000000000";
--                 END IF;
--             WHEN "11" =>
--                 -- Comparação maior
--                 IF data_in_A > data_in_B THEN
--                     temp <= "0000000000000001";
--                 ELSE
--                     temp <= "0000000000000000";
--                 END IF;
--             WHEN OTHERS =>
--                 -- Operação inválida
--                 temp <= "0000000000000000";
--         END CASE;
--     END PROCESS;

--     result_out <= temp(15 DOWNTO 0);
--     zero_out <= '1' WHEN temp(15 DOWNTO 0) = 0 ELSE
--         '0';
--     carry_out <= carry;
--     overflow_out <= overflow;
--     negative_out <= negative;
-- END A_ULA;