-- fixed_pkg
signal uMultiplicand : ufixed(1 downto -2) := to_ufixed(U_MULTIPLICAND, 1, -2); -- uQ2.2
signal uMultiplier : ufixed(1 downto -2) := to_ufixed(U_MULTIPLIER, 1, -2); -- uQ2.2
--  uQ4.4 -> Q(n1+n2).(m1+m2)
signal uProduct : ufixed(3 downto -4);
uProduct <= uMultiplicand * uMultiplier;
