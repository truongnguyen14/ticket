<?php 
include 'connect.php';
session_start();
if(!isset($_POST['submit'])){
	$aUsername = $_POST['username'];
	$aPassword = $_POST['password'];
	if(empty($aUsername) || empty($aPassword)){
		header ('location: login_form.php?login=empty');
		exit();
	}
	if(strlen($aUsername)>20){
		header('location: login_form.php?username=toolong');
		exit();
	}
	if (strlen($aPassword)<6){
		header('location: login_form.php?password=weak');
		exit();
	}
	$sql = "select adminID from admininfo where aUsername = '$aUsername' and aPassword = '$aPassword'";
	$check_user = mysqli_query($con,$sql);
	$check_result = mysqli_num_rows($check_user);
	if($check_result == 0){
		header('location: login_form.php?login=wronguserorpass');
		exit();
	}
	else{
		$row=mysqli_fetch_array($check_user);
        $_SESSION['admin']=$aUsername;
        $_SESSION['id']=$row['adminID'];
        header('location: index.php');
    }
}