<?php include_once 'header.php'?>
<?php include 'navbar.php'?>
<?php
						if(!isset($_SESSION['admin'])){
							header('location: login_form.php');
					}
					?>
<?php include 'barchart.php'?>
<?php include 'script.php'?>
</body>
</html>