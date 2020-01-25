assert to_integer(unsigned(bcd)) <= 9 report
  "unexpected bcd code. bcd = " & to_string(bcd);
