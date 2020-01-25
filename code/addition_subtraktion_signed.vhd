-- fixed_pkg
signal sMinuend : sfixed(2 downto -3) := to_sfixed(MINUEND, 2, -3); -- Q3.3
signal sSubtrahend : sfixed(0 downto -4) := to_sfixed(SUBTRAHEND, 0, -4); -- Q1.4
-- Q3.4 -> Q(max(n1,n2)+1).(max(m1,m2)) -> +1 to prevent overflow
signal difference : sfixed(3 downto -4);
-- here is the guarding and alignment done automatically
difference <= sMinuend - sSubtrahend;
