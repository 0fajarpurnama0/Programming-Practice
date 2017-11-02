program simple_login_1;

var 
 username: string;

begin
 write('username: '); readln(username);
 if username = 'John' then
  writeln('Hello ', username)
 else
  writeln('Wrong username');
 
 writeln('Program terminate'); 
end.
