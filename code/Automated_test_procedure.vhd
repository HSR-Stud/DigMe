library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all; -- Fuer externes Stimuli-File
entity TestVectors_in_File_V2008 is
end entity TestVectors_in_File_V2008;
architecture tb of TestVectors_in_File_V2008 is
  constant freq : natural := 10000; -- Clockfrequenz
  constant T : time := (1 sec) / freq;
  constant delta_t : time := 0.1 * T; -- Sampling point, at least delta_t
    -- before next clock edge
  component edgedetpos
    port(
      clk : in std_ulogic;
      nrst : in std_ulogic;
      inp : in std_ulogic;
      oup : out std_ulogic);
  end component edgedetpos;
  signal clk_tb, nrst_tb, inp_tb, oup_tb, oup_exp : std_ulogic;
begin
  dut : edgedetpos
    port map(
      clk => clk_tb,
      nrst => nrst_tb,
      inp => inp_tb,
      oup => oup_tb);
  clk_generator : process
  begin
    clk_tb <= '0';
    wait for T/2;
    clk_tb <= '1';
    wait for T/2;
  end process;
  apply_testvector : process -- Load data from file
    file test_vector_file : text open read_mode is
      "d:\testvectors.txt"; -- File mit Testvektoren
    -- Variables needed for reading the file
    variable line_number : line; -- Text line buffer, actual line
    variable line_content : string(1 to 20); -- Variable for passing read values
    variable vector_nr : integer; -- Test vector number
  begin
    while not endfile(test_vector_file) loop -- Loop reads line by line of file
      readline(test_vector_file, line_number); -- New line
      next when line_number.all(1) = '-'; -- Skip comment
      read(line_number, line_content); -- read line number
      vector_nr := to_integer(line_content(1 to 3)); -- value is identified as test
        -- vector and stored in variable
      nrst_tb <= '1' when (line_content(5) = "1") else '0'; -- Read value stored as
        -- signal nrst_tb
      inp_tb <= to_std_ulogicvector(line_content(7 to 10)); -- Read value identified
        -- as input vector
      oup_exp <= to_std_ulogicvector(line_content(12 to 20)); -- Read value identified
        -- as expected response
      -- Simulation result is compared with expected response
      wait for (T-delta_t); -- Definition of time of evaluation
      assert (oup_tb = oup_exp) report "Error in test vector " & to_string(vector_nr) severity error;
      wait until (rising_edge(clk_tb)); -- Wait for next clock cycle
    end loop;
    -- terminate simulation
    assert false report "Simulation Completed" severity failure;
  end process apply_testvector;
end architecture tb;
