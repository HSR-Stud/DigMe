constant AUGEND : real := 5.625; -- binary 101.101
constant ADDEND : real := 1.1875; -- binary 1.0011
signal uAugend : unsigned(5 downto 0) := to_unsigned(integer(2.0**3 * AUGEND), 6); -- uQ3.3
signal uAddend : unsigned(4 downto 0) := to_unsigned(integer(2.0**4 * ADDEND), 5); -- uQ1.4
-- result uQ4.4 -> Q(max(n1,n2)+1).(max(m1,m2))
signal sum : unsigned(7 downto 0);
-- the '0' left of uAugend is a guard bit to reach the same width as the sum vector.
-- the '0' right of uAugend is needed to align the decimal point
sum <= ('0' & uAugend & '0') + uAddend; -- result uQ4.4

-- fixed_pkg
signal uAugend : ufixed(2 downto -3) := to_ufixed(AUGEND, 2, -3); -- uQ3.3
signal uAddend : ufixed(0 downto -4) := to_ufixed(ADDEND, 0, -4); -- uQ1.4
-- Q3.4 -> Q(max(n1,n2)+1).(max(m1,m2)) -> +1 to prevent overflow
signal sum : ufixed(3 downto -4);
-- here is the guarding and alignmnt done automatically
sum <= uAugend + uAddend;
