program simple_login_5;

var 
 username, password: string;

procedure simple_login(username:string; password:string);
 begin
  if (username = 'John') and (password = 'Doe') then
   writeln('Hello ', username,' ', password)
  else if (username = 'Mary') and (password = 'Jane') then
   writeln('Hello ', username,' ', password)
  else if (username = 'Fajar') and (password = 'Purnama') then
   writeln('Hello ', username,' ', password)
  else
   writeln('Wrong username or password!');
  
  writeln('Program terminate!'); 
 end;

begin
 write('username: '); readln(username);
 write('password: '); readln(password);
 simple_login(username, password);
end.
