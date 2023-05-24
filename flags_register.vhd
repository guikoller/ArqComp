LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY flags_register IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        V_enable, N_enable, Z_enable, C_enable : IN STD_LOGIC;
        V_in, N_in, Z_in, C_in : IN STD_LOGIC;
        V_out, N_out, Z_out, C_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a_flags_register OF flags_register IS
    SIGNAL V, N, Z, C : STD_LOGIC := ('0');
BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            V <= '0';
            N <= '0';
            Z <= '0';
            C <= '0';
        ELSE
            IF V_enable = '1' THEN
                IF rising_edge(clk) THEN
                    V <= V_in;
                END IF;
            END IF;
            IF N_enable = '1' THEN
                IF rising_edge(clk) THEN
                    N <= N_in;
                END IF;
            END IF;
            IF Z_enable = '1' THEN
                IF rising_edge(clk) THEN
                    Z <= Z_in;
                END IF;
            END IF;
            IF C_enable = '1' THEN
                IF rising_edge(clk) THEN
                    C <= C_in;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    V_out <= V;
    N_out <= N;
    Z_out <= Z;
    C_out <= C;
END ARCHITECTURE;