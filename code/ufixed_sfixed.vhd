signal uNumber : ufixed(3 downto -6); --  uQ4.6
signal sNumber: sfixed(3 downto -6); -- sQ4.6
signal fractional : ufixed(-2 downto -3); -- "11" represents 0.011 = 0.375
signal integer : sfixed(3 downto 1); -- "111" represents 1110.0 = -2
-- upper and lower index using integer numbers
uNumber <= to_ufixed(5.25, 3, -6);
-- upper and lower index using the 'high and 'low operator
sNumber <= to_sfixed(-5.25, sNumber'high, sNumber'low);
