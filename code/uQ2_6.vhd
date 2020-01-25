-- 2.5248 -> binary 10.10000110010110010101
constant REAL_NUM : real := 2.5248;
-- unsigned Q2.6 = 10.100001 = 2.5156 (truncated)
-- the decimal point has to be shifted to the right by 6
signal uNumber : unsigned(7 downto 0) :=  to_unsigned(integer(2.0**6 * REAL_NUM), 8);

-- fixed_pkg
signal uNumber : ufixed(1 downto -6) := to_ufixed(REAL_NUM, 1, -6);
