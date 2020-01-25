constant WIDE_NUM : real := -2.5248;
signal sWideNumber : signed(7 downto 0) := to_signed(integer(2.0**5 * REAL_NUM),8); -- Q3.5 -> 101.01111 = -2.53125
signal sTruncated : signed(4 downto 0); -- Q3.2
-- Q3.2 -> 101.01 = -2.75
sTruncated <= resize(shift_right(sWideNumber,3),5);
