LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ULA IS
    PORT (
        data_in_A : IN unsigned(15 DOWNTO 0);
        data_in_B : IN unsigned(15 DOWNTO 0);
        op : IN unsigned(1 DOWNTO 0);
        result_out : OUT unsigned(15 DOWNTO 0);
        zero_out : OUT STD_LOGIC
    );
END ULA;

ARCHITECTURE A_ULA OF ULA IS
    SIGNAL temp : unsigned(15 DOWNTO 0);
BEGIN
    PROCESS (data_in_A, data_in_B, op) BEGIN
        CASE op IS
            WHEN "00" =>
                -- Soma
                temp <= data_in_A + data_in_B;
            WHEN "01" =>
                -- Subtração
                temp <= data_in_A - data_in_B;
            WHEN "10" =>
                -- Comparação igual
                IF data_in_A = data_in_B THEN
                    temp <= "0000000000000001";
                ELSE
                    temp <= "0000000000000000";
                END IF;
            WHEN "11" =>
                -- Comparação maior
                IF data_in_A > data_in_B THEN
                    temp <= "0000000000000001";
                ELSE
                    temp <= "0000000000000000";
                END IF;
            WHEN OTHERS =>
                -- Operação inválida
                temp <= "0000000000000000";
        END CASE;
    END PROCESS;

    result_out <= temp(15 DOWNTO 0);
    zero_out <= '1' WHEN temp(15 DOWNTO 0) = 0 ELSE
        '0';
END A_ULA;