library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std. memtextio_type.all;
entity RAM_Test is
  generic (
    ADDR_WIDTH : integer := 8;
    DATA_WIDTH : integer := 8);
  port (
    a_clk :  in std_logic;
    a_addr : in std_logic_vector (ADDR_WIDTH - 1 downto 0);
    a_din :  in std_logic_vector (DATA_WIDTH - 1 downto 0);
    a_dout : out std_logic_vector (DATA_WIDTH - 1 downto 0);
    a_wr :   in std_logic;
    b_clk :  in std_logic;
    b_addr : in std_logic_vector (ADDR_WIDTH - 1 downto 0);
    b_din :  in std_logic_vector (DATA_WIDTH - 1 downto 0);
    b_dout : out std_logic_vector (DATA_WIDTH - 1 downto 0);
    b_wr :   in std_logic);
end entity RAM_Test;

architecture RTL of RAM_Test is
  constant MEM_DEPTH : integer := 2 ** ADDR_WIDTH;
  type ram_type is array (0 to MEM_DEPTH - 1) of std_logic_vector (DATA_WIDTH - 1
    downto 0);
  shared variable blockram : ram_type;
begin
  ramA_write : process (a_clk)
  begin
    if rising_edge (a_clk) then
      if a_wr = '1' then -- if write is enabled
        blockram (to_integer(unsigned(a_addr))) <= a_din;
      end if;
      a_dout <= blockram (to_integer(unsigned(a_addr)));
    end if;
  end process ramA_write;
  ramB_write : process (b_clk)
  begin
    if rising_edge (b_clk) then
      if b_wr = '1' then -- if write is enabled
        blockram (to_integer(unsigned(b_addr))) <= b_din;
      end if;
      b_dout <= blockram (to_integer(unsigned(b_addr)));
    end if;
  end process ramB_write;
end RTL;
