generic(param_name : param_type := initial_value);  -- Definition
entity en_ffp_data_handler is                       -- Example
  generic(
    AddrWidth_g      : positive  := 16;
    DataWidth_g      : positive  := 32;
    Enable_StreamUp  : boolean   := true;
  );
  port(
    M_AXIS_TVALID    : out std_logic;
    M_AXIS_TDATA     : out std_logic_vector(DataWidth_g-1 downto 0);
  );
end en_ffp_data_handler;
