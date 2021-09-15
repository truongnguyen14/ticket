<?php include 'header.php'?>
<?php include 'navbar.php'?>
<body>
<div class="container">
    <center><h2 class="text-primary">Account</h2></center>
		<div class="userinfo">
			<div class="row">
				<?php
					if(!isset($_SESSION['username'])){
						header('location: index.php');
					}
					else{
					$user_name = $_SESSION['username'];
					if($res = $con->query("select * from customers where cUsername = '$user_name';")){
						while ($row = $res -> fetch_assoc()){
						echo'
					<div class="col-md-auto box1">
							<img src="user image/user.png" class="card_img" alt="user image">
					</div>
					<div class="col-md-8">
						<div class="card">
							<div class="card-body">
								<p class="card-text">First name: '. $row['fname'].'</p>
								<p class="card-text">Last name: '. $row['lname'].'</p>
								<p class="card-text">Date of birth: '. $row['dob'].'</p>
								<p class="card-text">Gender: '. $row['gender'].'</p>
								<p class="card-text">Username: '. $row['cUsername'].'</p>
								<p class="card-text">Phone number: (+09)'. $row['phone'].'</p>
								<p class="card-text">Number of reserved seats orded: </p>
							</div>
						</div>
							</div> ';}
					}
					}
					?>
				
		   </div>
		</div>
    </div>
   <?php include 'script.php'?>
</body>
</html>