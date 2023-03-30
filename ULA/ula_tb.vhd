library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end ula_tb;

architecture testbench of ula_tb is

  -- Component declaration for the DUT (Design Under Test)
  component ula
    port (
      data_in_A : in  unsigned (15 downto 0);
      data_in_B : in  unsigned (15 downto 0);
      result_out : out  unsigned (15 downto 0);
      flag_out : out  std_logic
    );
  end component;

  -- Input signal declarations
  signal data_in_A : unsigned (15 downto 0) := (others => '0');
  signal data_in_B : unsigned (15 downto 0) := (others => '0');

  -- Output signal declarations
  signal result_out : unsigned (15 downto 0);
  signal flag_out : std_logic;

begin

  -- Instantiate the DUT
  DUT: ula port map (
    data_in_A => data_in_A,
    data_in_B => data_in_B,
    result_out => result_out,
    flag_out => flag_out
  );

  -- Stimulus process
  stim_proc: process
  begin
    -- Test 1: Addition Test
    data_in_A <= to_unsigned(10, 16);
    data_in_B <= to_unsigned(20, 16);
    wait for 10 ns;
    assert result_out = to_unsigned(30, 16) report "Addition Test Failed!" severity error;

    -- Test 2: Subtraction Test
    data_in_A <= to_unsigned(50, 16);
    data_in_B <= to_unsigned(25, 16);
    wait for 10 ns;
    assert result_out = to_unsigned(25, 16) report "Subtraction Test Failed!" severity error;

    -- Test 3: Comparison Test 1
    data_in_A <= to_unsigned(100, 16);
    data_in_B <= to_unsigned(50, 16);
    wait for 10 ns;
    assert flag_out = '1' report "Comparison Test 1 Failed!" severity error;

    -- Test 4: Comparison Test 2
    data_in_A <= to_unsigned(50, 16);
    data_in_B <= to_unsigned(100, 16);
    wait for 10 ns;
    assert flag_out = '0' report "Comparison Test 2 Failed!" severity error;

    -- End the simulation
    wait;
  end process;

end testbench;

