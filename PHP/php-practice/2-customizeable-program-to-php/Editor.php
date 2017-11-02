<html>
<head>
<title>Editor</title>
</head>
<body>

<!-- Link to another PHP -->
<a href="Existing-Editor.php">Click for existing program.</a>

<!-- "fname", "lname", and "input" will be sent to "action.php" using post method 'target="_blank" opens new tab -->
<form method="post" action="action.php" target="_blank">
   First Name: <input type="text" name="fname"><br>
   Last Name: <input type="text" name="lname"><br>
   Command: <input type="text" name="input"><br>
 <input type ="submit">
</form>


</body>
</html>
