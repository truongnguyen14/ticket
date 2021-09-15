<?php 
$host="localhost";
$username="root";
$password="096996Boy";
$db_name="assignment1";
// Create connection
$con = new mysqli($host, $username, $password,$db_name);
// Check connection
if ($con->connect_error) {
	die("Connection failed: " . $con->connect_error);
} else{
	
}
?>