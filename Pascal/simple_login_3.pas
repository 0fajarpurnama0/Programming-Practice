program simple_login_2;

var 
 username, password: string;

begin
 write('username: '); readln(username);

 if (username = 'John') or (username = 'Mary') then
  writeln('Hello ', username)
 else
  writeln('Wrong username');
  
 writeln('Program terminate'); 
end.
