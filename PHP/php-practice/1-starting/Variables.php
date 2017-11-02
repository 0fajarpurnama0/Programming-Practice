<html>
<head>
<title> Hello World </title>
</head>
<body>

<?php

//First Practice
$name1= "Fajar";
$name2= "Purnama";

$x = 5;
$y = 10.5;

echo "My name is $name1 $name2"."<br>";

echo $x + $y . "<br>";

var_dump($y);

//Second Practice
$a = 1;
$b = 2;

function test() {
global $b;
echo "<br>" . $a, $b . "<br> <br>";
}

test();

//Third Practice
function add() {
$a = 1; static $b = 1;
echo "a = $a ";
$a++;
echo "b = $b <br>";
$b++;
}

add();
add();
add();
?>

</body>
</html>
