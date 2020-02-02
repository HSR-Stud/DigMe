-- Gleich wie bei Block Ram Single-Port
architecture RTL of RAM_Test is
  constant MEM_DEPTH : integer := 2 ** ADDR_WIDTH;
  type ram_type is array(0 to MEM_DEPTH - 1) of std_logic_vector(DATA_WIDTH - 1
    downto 0);
  signal distram : ram_type;
begin
  ram_write : process(clk)
  begin
    if rising_edge(clk) then
      if en = '1' then -- if RAM is enabled
        if we = '1' then -- if write is enabled
          distram(to_integer(unsigned(addr))) <= din;
        end if;
      end if;
    end if;
  end process ram_write;

  dout <= distram(to_integer(unsigned(addr)));
end RTL;
