<?php 
include 'connect.php';
session_start();
if(!isset($_POST['submit'])){
	$cUsername = $_POST['username'];
	$cPassword = $_POST['password'];
	if(empty($cUsername) || empty($cPassword)){
		header ('location: login_form.php?login=empty');
		exit();
	}
	if(strlen($cUsername)>20){
		header('location: login_form.php?username=toolong');
		exit();
	}
	if (strlen($cPassword)<6){
		header('location: login_form.php?password=weak');
		exit();
	}
	$sql = "select cID from customers where cUsername = '$cUsername' and cPassword = '$cPassword'";
	$check_user = mysqli_query($con,$sql);
	$check_result = mysqli_num_rows($check_user);
	if($check_result == 0){
		header('location: login_form.php?login=wronguserorpass');
		exit();
	}
	else{
		$row=mysqli_fetch_array($check_user);
        $_SESSION['username']=$cUsername;
        $_SESSION['id']=$row['cID'];
        header('location:'.$_SESSION['redirectURL']);
    }
}