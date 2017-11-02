program variables;

var 
  firstname, lastname: string;
  a,b,c,d,e : integer;
  f : real; 

begin
 write('What is your firstname? '); readln(firstname);
 write('What is your lastname? '); readln(lastname);
 write('Hi! My name is ', firstname, lastname); writeln('. I would like to perform simple math operation');
 write('Input first number: '); readln(a);
 write('Input second number: '); readln(b);
 c := a+b;
 d := a-b;
 e := a*b;
 f := a / b;
 writeln(a,' + ',b,' = ',c);
 writeln(a,' - ',b,' = ',d);
 writeln(a,' * ',b,' = ',e);
 writeln(a,' / ',b,' = ',f);
end.
