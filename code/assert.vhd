assert condition report "message" severity error; -- Syntax
i := to_integer(unsigned(bcd)); -- Example
assert i <= 9 report
  "unexpected bcd code. bcd = " & integer'image(i);
