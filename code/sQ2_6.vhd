-- -2.5248 -> binary 101.0111100110101
constant REAL_NUM : real := -2.5248;
-- signed Q3.5 = 101.01111 =  -2.5313 (truncated)
-- the decimal point has to be shifted to the right by 5
signal sNumber : signed(7 downto 0) := to_signed(integer(2.0**5 * REAL_NUM), 8);

-- fixed_pkg
signal sNumber : sfixed(1 downto -6) := to_sfixed(REAL_NUM, 1, -6);
