-- fixed_pkg
signal uDividend : ufixed(4 downto -3) :=  to_ufixed(6.75, 4, -3); -- uQ5.3
signal uDivisor : ufixed(2 downto -4) := to_ufixed(1.5, 2, -4); -- uQ3.4
-- uQ9.6 -> Q(n1+m2-1).(m1+n2)
signal uFraction : ufixed(8 downto -6);
signal sDividend : sfixed(4 downto -3) := to_sfixed(-6.75, 4, -3); -- Q5.3
signal sDivisor : sfixed(2 downto -4) := to_sfixed(1.5, 2, -4); -- uQ9.6 -> Q(n1+m2-1).(m1+n2)
signal sFraction : sfixed(9 downto -5);
uFraction <= uDividend/uDivisor;
sFraction <= sDividend/sDivisor;
