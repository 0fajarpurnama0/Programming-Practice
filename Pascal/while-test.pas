program while_test;

var
 a,i: integer;

begin
 a := 1;
 write('How much do you want to count? Insert a number: '); readln(i);
 while a <= i do
 begin
  writeln(a);
  a := a + 1;
 end;

end.
