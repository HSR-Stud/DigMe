architecture RTL of ROM_Test_initialize is
  constant MEM_DEPTH : integer := 2 ** ADDR_WIDTH;
  type ROM_type is array(0 to MEM_DEPTH - 1) of std_logic_vector(DATA_WIDTH - 1 
    downto 0);
  impure function init_mem(mif_file_name : in string) return ROM_type is
    file mif_file : text open read_mode is mif_file_name;
    variable mif_line : line;
    variable temp_bv : bit_vector(DATA_WIDTH - 1 downto 0);
    variable temp_mem : ROM_type;
  begin
    for i in ROM_type'range loop
      readline(mif_file, mif_line);
      read(mif_line, temp_bv);
      temp_mem(i) := to_stdlogicvector(temp_bv);
    end loop;
    return temp_mem;
  end function
  constant ROM : ROM_type := init_mem("mem_init_vhd.mif");
