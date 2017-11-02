<html>
<head>
<title>Practice PHP</title>
</head>
<body>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
 username: <input type="text" name="user"><br>
 password: <input type="text" name="pass"><br>
 <input type="submit">
</form>

<?php
$username = array("Fajar","John","emanresu");
$password = array("Purnama","Doe","drowssap");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
$user = $_POST['user'];
$pass = $_POST['pass'];

for ($c = 0; $c <= count($username)-1; $c++) {
 switch($user){
  case $username[$c]:
   switch($pass){
    case $password[$c]:
     echo "Welcome!";
     break;
   }
  default:
   switch($c){
    case count($username)-1:
     echo "Wrong username or password";
   }
 }
}
?>

</body>
</html>

