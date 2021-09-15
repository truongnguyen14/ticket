<?php 
include 'connect.php';
session_start();
if (!isset($_POST['submit'])){
$fname = $_POST['fname'];
$lname = $_POST['lname'];
$dob = $_POST['dob'];
$cUsername = $_POST['username'];
$cPassword = $_POST['password'];
$gender = $_POST['gender'];
$phone = $_POST['phone'];
if (empty($fname) || empty($lname) || empty($dob) || empty($cUsername) || empty($cPassword) || empty($gender) || empty($phone)){
	header('location: registration_form.php?registration_form=empty');
	exit();
}
if(strlen($cUsername)>20){
	header('location: registration_form.php?username=toolong');
	exit();
}
if (strlen($cPassword)<6){
	header('location: registration_form.php?password=weak');
	exit();
}
$sql = "select cID from customers where cUsername = '$cUsername'";
$check_duplicate = mysqli_query($con,$sql);
$check_result = mysqli_num_rows($check_duplicate);
if($check_result>0){
	header('location: registration_form.php?cUsername=cUsername');
	exit();
}else{
	$customers_registration = "INSERT INTO customers(cUsername, cPassword, fname, lname, dob, gender, phone) 
	VALUES('$cUsername', '$cPassword', '$fname', '$lname', '$dob', '$gender', '$phone')";
	$customers_registration_result = mysqli_query($con,$customers_registration) or die (mysqli_error($con));
	$_SESSION['username']=$cUsername;
	$_SESSION['cID']=mysqli_insert_id($con); //Id increment
	header('location: registration_form.php?register=success');
}
}
?>