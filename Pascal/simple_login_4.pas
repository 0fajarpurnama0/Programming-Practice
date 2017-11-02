program simple_login_4;

var 
 username, password: string;

begin
 write('username: '); readln(username);
 write('password: '); readln(password);

 if (username = 'John') and (password = 'Doe') then
  writeln('Hello ', username,' ', password)
 else if (username = 'Mary') and (password = 'Jane') then
  writeln('Hello ', username,' ', password)
 else if (username = 'Fajar') and (password = 'Purnama') then
  writeln('Hello ', username,' ', password)
 else
  writeln('Wrong username or password!');
  
 writeln('Program terminate!'); 
end.
