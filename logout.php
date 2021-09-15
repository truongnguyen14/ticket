<?php session_start();
unset($_SESSION["cID"]);
unset($_SESSION["username"]);
session_destroy();
$CurrentPage = $_SERVER['HTTP_REFERER'];
if(isset($CurrentPage)) {
    header('location: '.$CurrentPage);
} else {
    header('location: index.php'); 
}
?>