<html>
<head>
<title>Practice PHP</title>
</head>
<body>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
  Username: <input type="text" name="user"><br>
  Password: <input type="text" name="pass"><br>
  <input type="submit">
</form>

<?php 
$username = array("Fajar","John","emanresu");
$password = array("Purnama","Doe","drowssap");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
$user = $_POST['user'];
$pass = $_POST['pass'];

//var_dump($username[0] == $user and $password[1] == $pass);

for ($c = 0; $c <= count($username)-1; $c++) {

if ($user == $username[$c] and $pass == $password[$c]) {
echo "Welcome!";
break;
} elseif ($c < count($username)-1) {
continue;
} else {
echo "Wrong username or password";
}
}
}

?>

</body>
</html>
