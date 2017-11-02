<?php
// Start the session
session_start();
?>

<html>
<head>
<title>Existing Program Editor</title>
</head>
<body>

<a href="Editor.php">New Program</a>

<?php
// Create arrays of filenames from "record.txt"
$list = file("record.txt");
?>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">

  <select name="program">
   <?php
    // Check the number of arrays on $list and prepare drop down list for each program name. 
   for($i=0; $i<=count($list)-1; $i++){
    echo "<option value=$list[$i]>$list[$i]</option>";}
   ?>

   <!-- Standard input of the arguments -->
   Arguments: <input type="text" name="input"><br>
 <input type ="submit" name="add" value="add">
 <input type ="submit" name="continue" value="continue">
</form>

<?php
// Will only run if the button is pressed
if ($_SERVER["REQUEST_METHOD"] == "POST"){
 $_SESSION["program"] = $_POST['program'];
 $program = $_SESSION["program"];

 // If the "add" button is pressed
 if (isset($_POST['add'])){

  // If "input" was filled, then the string will be added on the file on your txt command list
  if ($_POST['input'] <> NULL){
   $input = $_POST['input'];
   $ftype1 = "_command_list.txt";
   $file1 = "$program" . "$ftype1";
   $add = "$input\n";
   $current = file_put_contents($file1, $add, FILE_APPEND);
  }

 //If "continue" is pressed it will redirect to the program.php
 } elseif(isset($_POST['continue'])){
  $ftype2 = "_program.php";
  $file2 = "$program" . "$ftype2"; 
  $_SESSION["fname"] = NULL; $_SESSION["lname"] = NULL; //So Editor.php and Existing-Editor.php don't collide
  header("Location: $file2");
  exit;
 }

}
?>

</body>
</html>
