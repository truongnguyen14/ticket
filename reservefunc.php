<?php include "connect.php";
session_start();
if(!isset($_POST['submit'])){
	$cID = $_SESSION['id'];
	$cineplex = $_POST['cinema'];
	$screentime = $_POST['time'];
	$room = $_POST['room'];
	$seat = $_POST['seat'];
	$total = $_POST['total'];

		$reserve = "INSERT INTO reservations(cID, screentimeID,cineplexID, cinemaID, seatNumb, totalprice)
		VALUES('$cID', '$screentime', '$cineplex', '$room', '$seat', '$total')";
		$reserve_result = mysqli_query($con,$reserve) or die (mysqli_error($con));
		$_SESSION['cID'] = mysqli_insert_id($con);
		header('location: index.php');
	
}