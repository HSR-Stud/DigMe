constant S_MULTIPLICAND : real := 1.25; -- binary 01.01
constant S_MULTIPLIER : real := -1.25; -- binary 10.11
signal sMultiplicand : signed(3 downto 0) := to_signed(integer(2.0**2 * S_MULTIPLICAND), 4); -- sQ2.2
signal sMultiplier : signed(3 downto 0) := to_signed(integer(2.0**2 * S_MULTIPLIER), 4); -- sQ2.2
signal sProduct : signed(7 downto 0);
-- Q3.5 -> Q(n1+n1-1).(m1+m2+1)
sProduct <= shift_left(sMultiplicand * sMultiplier, 1);

-- fixed_pkg
signal sMultiplicand : sfixed(1 downto -2) := to_sfixed(S_MULTIPLICAND, 1, -2); -- sQ2.2
signal sMultiplier : sfixed(1 downto -2) := to_sfixed(S_MULTIPLIER, 1, -2); -- sQ2.2
-- Q4.4 -> Q(n1+n2).(m1+m2)
signal sProduct : sfixed(3 downto -4);
signal sProductShift : sfixed(2 downto -5);
-- sProduct has two sign bits
sProduct <= sMultiplicand * sMultiplier;
-- sProductShift has only one sign bit
sProductShift <= resize(sProduct,2,-5);
