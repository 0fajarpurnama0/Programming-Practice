<?php
// Start the session
session_start();
?>

<html>
<head>
<title>Program</title>
</head>
<body>

<?php
// Check whether it is new program or existing program (is it from Editor.php ??? or Existing-Editor.php ???)
if ($_SESSION["fname"] <> NULL and $_SESSION["lname"] <> NULL){
 $fname = $_SESSION["fname"]; 
 $lname = $_SESSION["lname"];
 // The file to be used
 $file = "$fname" . "_" . "$lname" . "_command_list.txt";
} else {
 // Use session value from Existing-Editor.php, calls the txt that contains your command list.
 $program = $_SESSION["program"]; 
 $file = "$program" . "_command_list.txt";
}

// Put your commands into array
$command = file($file);
?>

<a href="Existing-Editor.php">Add More Command</a>

<form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
 <select name="cmd">
   
  <?php
  // Generates command list from $command array
  for($c=0; $c<=count($command)-1; $c++){ 
   echo "<option value=$command[$c]>$command[$c]</option>";}
  ?>

 </select>
 <input type ="text" name="var">
 <input type ="submit" name="delete" value="delete">
 <input type ="submit" name="execute" value="execute">
</form>

<?php
// Will only if the buttons aboved are pressed
if ($_SERVER["REQUEST_METHOD"] == "POST") {
 $cmd = $_POST['cmd'];
 $var = $_POST['var'];
 // Executes the command on the server (these will run the strings you type on command line, cmd for Windows, Terminal for Linux or MAC, and returns the output)
 if (isset($_POST['execute'])){
  echo $output = passthru("$cmd $var");
 // If you choose to delete a command (will search of which key the string is on the array, deletes the key on the array, update the txt file, and refresh the page)
 } elseif (isset($_POST['delete'])) {
  $key = array_search($cmd . "\n",$command);
  unset($command[$key]);
  file_put_contents($file, $command);
  header("Refresh:0");
 }
}
?>

</body>
</html>
