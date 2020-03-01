library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
entity RAM_Test is
  generic (
    ADDR_WIDTH : integer := 8;
    DATA_WIDTH : integer := 8);
  port (
    clk :    in std_logic;
    addr :   in std_logic_vector(ADDR_WIDTH - 1 downto 0);
    din :    in std_logic_vector(DATA_WIDTH - 1 downto 0);
    dout :   out std_logic_vector(DATA_WIDTH - 1 downto 0);
    we, en : in std_logic);
end entity RAM_Test;

architecture RTL of RAM_Test is
  constant MEM_DEPTH : integer := 2 ** ADDR_WIDTH;
  type ram_type is array(0 to MEM_DEPTH - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal blockram : ram_type;
begin
  ram_write : process(clk)
  begin
    if rising_edge(clk) then
      if en = '1' then -- if RAM is enabled
        if we = '1' then -- if write is enabled
          blockram(to_integer(unsigned(addr))) <= din;
          dout <= din;
        else
          dout <= blockram(to_integer(unsigned(addr)));
        end if;
      end if;
    end if;
  end process ram_write;
end RTL;
