<?php
// Start the session (This PHP uses sessions in order to distribute the variables to other files)
session_start();

// Retrieve "fname", "lname", and "input" from Editor.php
$_SESSION["fname"] = $_POST['fname'];
$_SESSION["lname"] = $_POST['lname'];
$input = $_POST['input'];

// Make new variable for convenient use
$fname = $_SESSION["fname"];
$lname = $_SESSION["lname"];

// Prepare the filename to be created (I use text files as storage)
$ftype1 = "_command_list.txt";
$filename = "$fname" . "_" . "$lname";

// For example it will produce "Fajar_Purnama_command_list.txt"
$file1 = "$filename" . "$ftype1";

// Below is the command to be added, "\n" is to start new line (equivalent to ENTER)
$add = "$input\n";

// Add the command (input) into the file, $file1 is the file, $add contains strings to be added, and FILE_APPEND to add on last data (if not the file will be overwritten). Creates new file if file doesn't exist before.
file_put_contents($file1, $add, FILE_APPEND);

// A skeleton under program.php already prepared, this just copy the file using new name base on input on Editor.php
$ftype2 = "_program.php";
$file2 = "$filename" . "$ftype2"; 
copy("program.php","$file2");

// Record of created file is stored on record.txt (this is for Existing-Editor.php)
$record = "$filename\n"; 
file_put_contents("record.txt", $record, FILE_APPEND); 

// Redirect browser
header("Location: $file2");
 
// Make sure that code below does not get executed when we redirect. 
exit;
?>


