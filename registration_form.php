<?php include 'header.php';
 include 'navbar.php';
 $_SESSION['redirectURL'] = $_SERVER['REQUEST_URI'];?>
<div class="container">
	<div class="form">
		<div class="form-box">
			<form id="register" method="post" action="registration.php">
				<div class="title">
					<h1><span>Register</span> account</h1>
				</div>
				<?php
				$fullUrl = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
				if(strpos($fullUrl, "registration_form=empty") == true){
					echo "<p class='warning'>You have to fill the space</p>";				
				}
				else if(strpos($fullUrl, "username=toolong") == true){
					echo "<p class='warning'>Username is too long</p>";				
				}
				else if(strpos($fullUrl, "password=weak") == true){
					echo "<p class='warning'>Password must consist 6 </p>";
				}
				else if(strpos($fullUrl, "cUsername=cUsername") == true){
					echo "<p class='warning'>This username has been taken </p>";		
				}
				else if(strpos($fullUrl, "register=success") == true){
					echo "<p class='success'>You have successfully register your account. Please log in into your account </p>";		
				}
				?>
				<div class="form-group ">                        
					<input class="form-control" type="text" name="fname" id="fname" placeholder="First Name">
				</div>                      
				<div class="form-group">                        
					<input class="form-control" type="text" name="lname" id="lname" placeholder="Last Name">                        
				</div>
				<div class="form-group">
					<select name="gender" id="gender">
						<option value="">Select your gender</option>
						<option value="male">Male</option>
						<option value="female">Female</option>
						<option value="other">Other</option>
					</select>
				</div>
				<div class="form-group">                        
					<input class="form-control" type="date" name="dob" id="dob" placeholder="Date of birth">                        
				</div>
				<div class="form-group">                        
					<input class="form-control" type="text" name="username" id="username" placeholder="Username">                        
				</div>                                              
				<div class="form-group">                        
					<input class="form-control" type="password" name="password" id="password" placeholder="Password">                        
				</div>                                              
				<div class="form-group">                        
					<input class="form-control" type="text" name="phone" id="phone" placeholder="Phone number">                        
				</div>                        
				<div class="form-button register-button">
					<input class="btn btn-primary" value="Clear" type="reset" name="clear-btn">				
					<input class="btn btn-primary"  value="Register" type="submit" name="register_btn">
				</div>
				
				<div class="account">                        
					<p>Already have an Account? Then<a href="login_form.php"> login</a></p>                        
				</div>
			</form>		
		</div>
	</div>
</div>
	<?php include 'script.php'?>
</body>
</html>			