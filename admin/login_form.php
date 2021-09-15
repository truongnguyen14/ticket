<?php include 'header.php'; 
	  include 'navbar.php'?>
	<div class="log-in">
		<div class="login-title">			
			<h1>LOG IN AS ADMIN</h1>			
		</div>			
		<form  method="post" action="login.php">					
			<div class="ibox">					
				<input type="text" name="username" id="username" placeholder="Username" >					
			</div>					
			<div class="ibox">					
				<input type="password" name="password" id="password" placeholder="Password" >					
			</div>
			<?php
				$fullUrl = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
				if(strpos($fullUrl, "login=empty") == true){
					echo "<p class='warning'>You have to fill the space</p>";				
				}
				else if(strpos($fullUrl, "username=toolong") == true){
					echo "<p class='warning'>Username is too long</p>";				
				}
				else if(strpos($fullUrl, "password=weak") == true){
					echo "<p class='warning'>Password must consist 6 </p>";
				}
				else if(strpos($fullUrl, "login=wronguserorpass") == true){
					echo "<p class='warning'>Wrong username or password</p>";
				}
			?>
			<div class="form-button login-button">					
				<input class="btn btn-primary"  value="Log in" type="submit" name="login_btn">					
			</div>
				<p class="box"><a class="boxs" href="login_form.php"><b>Log in as Customer</b></a></p>
		</form>									
	</div>			
<?php include 'script.php'?>
</body>
</html>
