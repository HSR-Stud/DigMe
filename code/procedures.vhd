-- Syntax
procedure <procedure_name> [(<argument list with type declaration>)] is
  [<declarations>];
begin
  (sequential statements>};
end [procedure] <procedure_name>;
-- Example
procedure Proc(X,Y : inout Integer) is
  type Word_16 is range 0 to 65536;
  subtype Byte is Word_16 range 0 to 255;
  variable Vb1,Vb2,Vb3 : Real;
  constant Pi : Real := 3.14;
begin
  -- Some statements
end procedure Proc_3;
