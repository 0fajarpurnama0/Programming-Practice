program many_login;

var
 username : array[0..5] of string = ('John', 'Mary', 'Fajar', 'emanresu', 'root', 'admin');
 password : array[0..5] of string = ('Doe', 'Jane', 'Purnama', 'drowssap', 'toor', 'nimda');
 i: integer;
 username_input, password_input: string;

begin
 write('Username: '); readln(username_input);
 write('Password: '); readln(password_input);

 for i := 0 to 5 do
 begin

  if (username_input = username[i]) and (password_input = password[i]) then
  begin
   writeln('Hello ', username_input, ' ', password_input, '!');
   break;
  end
  else if i = 5 then
   writeln('Wrong username or password!');

 end;

end.
