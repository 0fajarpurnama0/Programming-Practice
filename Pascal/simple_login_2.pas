program simple_login_2;

var 
 username: string;

begin
 write('username: '); readln(username);
 if username = 'John' then
  writeln('Hello ', username)
 else if username = 'Mary' then
  writeln('Hello ', username)
 else
  writeln('Wrong username');
 
 writeln('Program terminate'); 
end.
