<?php session_start();
unset($_SESSION["adminID"]);
unset($_SESSION["admin"]);
session_destroy();

    header('location: login_form.php'); 

?>