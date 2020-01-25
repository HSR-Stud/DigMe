function resize (
  arg             : unresolved_ufixed; -- input
  constant left_index : integer; -- integer portion
  constant right_index : integer; -- size of fraction
  constant overflow_style : fixed_overflow_style_type := FIXED_OVERFLOW_STYLE;
  constant round_style : fixed_round_style_type := FIXED_ROUND_STYLE)
return unresolved_ufixed;
