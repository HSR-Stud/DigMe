library ieee;
use ieee.std_logic_1164.all;
entity spiMaster is
  generic(
    DATAWIDTH    : integer
  );
  port(
    clkIn        : in std_logic;
    reset        : in std_logic;
    -- user interface
    start        : in  std_logic;
    busy         : out std_logic;
    dataTransmit : in  std_logic_vector(DATAWIDTH-1 downto 0);
    dataReceive  : out std_logic_vector(DATAWIDTH-1 downto 0);
    -- SPI interface
    CS           : out std_logic;
    SCLK         : out std_logic;
    SDI          : in  std_logic;
    SDO          : out std_logic
  );
end spiMaster;
architecture behavioral of spiMaster is
  type stateType is (idle, sclk0, sclk1);
  signal statePresent, stateNext : stateType;
  signal counterPresent, counterNext : integer range 0 to DATAWIDTH-1;
  signal shiftRegTransmitNext : std_logic_vector(DATAWIDTH-1 downto 0);
  signal shiftRegTransmitPresent : std_logic_vector(DATAWIDTH-1 downto 0);
  signal shiftRegReceiveNext : std_logic_vector(DATAWIDTH-1 downto 0);
  signal shiftRegReceivePresent : std_logic_vector(DATAWIDTH-1 downto 0);
begin
  regLogic : process(clkIn, reset)
  begin
    if reset = '1' then
      statePresent <= idle;
      counterPresent <= 0;
      shiftRegTransmitPresent <= (others => '0');
      shiftRegReceivePresent <= (others => '0');
    elsif rising_edge(clkIn) then
      statePresent <= stateNext;
      counterPresent <= counterNext;
      shiftRegTransmitPresent <= shiftRegTransmitNext;
      shiftRegReceivePresent <= shiftRegReceiveNext;
    end if;
  end process regLogic;
  nextStateLogic : process (counterPresent, start, statePresent)
  begin
    stateNext <= idle;
    counterNext <= 0;
    case statePresent is
      when idle =>
        if start = '1' then
          stateNext <= sclk0;
        else
          stateNext <= idle;
        end if;
      when sclk0 =>
        counterNext <= counterPresent;
        stateNext <= sclk1;
      when sclk1 =>
        if counterPresent >= DATAWIDTH-1 then
          stateNext <= idle;
        else
          stateNext <= sclk0;
          counterNext <= counterPresent+1;
        end if;
    end case;
  end process nextStateLogic;
  transmitShiftRegister : process (dataTransmit, shiftRegTransmitPresent,
    shiftRegTransmitPresent(7 downto 1), statePresent)
  begin
    case statePresent is
      when idle =>
        shiftRegTransmitNext <= DataTransmit;
      when sclk0 =>
        shiftRegTransmitNext <= shiftRegTransmitPresent;
      when sclk1 =>
        shiftRegTransmitNext <= '0' & shiftRegTransmitPresent(7 downto 1);
    end case;
  end process;
  SDO <= shiftRegTransmitNext(0);
  receiveShiftRegister : process (SDI, shiftRegReceivePresent,
    shiftRegReceivePresent(6 downto 0), statePresent)
  begin
    case statePresent is
      when idle =>
        DataReceive <= shiftRegReceivePresent;
        shiftRegReceiveNext <= shiftRegReceivePresent;
      when sclk0 =>
        shiftRegReceiveNext <= shiftRegReceivePresent(6 downto 0) & SDI;
      when sclk1 =>
        shiftRegReceiveNext <= shiftRegReceivePresent;
    end case;
  end process receiveShiftRegister;
  CS   <= '1' when statePresent = idle else '0';
  SCLK <= '1' when statePresent = sclk1 else '0';
  busy <= '0' when statePresent = idle else '1';
end behavioral;
