<?php include 'header.php';
	include 'navbar.php';?>
<div class="container">
	<center><h2 class="text-primary">Book movie</h2></center>
	<div class="reserve">
		<div class="row">
			<?php
						$movie_id = $_GET['r'];
						if($res = $con->query("select * from movies where mID=$movie_id;")){
						while ($mov = $res -> fetch_assoc()){
						echo'
			<div class="col-md-6">
				<img src="images/'.$mov['image'].'" class="card_img" alt="movie image">		
			</div>
			<div class="col-md-4">
			<form method="post" action="reservefunc.php">		
					<div class="form-group">
						<h2 class="bookmovie-title">'.$mov['name'].'</h2>';}}
					?>
					<?php
						if(!isset($_SESSION['username'])){
							$_SESSION['redirectURL'] = $_SERVER['REQUEST_URI'];
							header('location: login_form.php');
					}
					else{
					$user_name = $_SESSION['username'];
						if($res = $con->query("select * from customers where cUsername = '$user_name';")){
						while ($row = $res -> fetch_assoc()){
						echo'
						<p class="card-text">First name: '. $row['fname'].'</p>		
						<p class="card-text">Last name: '. $row['lname'].'</p>		
						<p class="card-text">Contact: (+09)'. $row['phone'].'</p>				
					</div>';}}}
					?>
					<div class="form-group">					
						<div class="card">
							<label for="Cinema">Cinema</label>						
							<select name="cinema" id="cinema">
								<option value="">Choose your cinema</option> 
							<?php							
							if($res = $con->query("select * from cineplex;")){								
								while ($cin = $res -> fetch_assoc()){									
								echo'	
									<option value="'.$cin['cineplexID'].'">'.$cin['cineplexname'].', '.$cin['address'].'</option>
								';
								}
							}
						?>
							</select>
						</div>
											
					</div>
					<div class="other">
						<div class="form-group">
						<div class="card">
							<label for="Time">Time</label>
							<select name="time" id="time">
								<option value=" ">choose your time</option>
							</select>
						</div>
						</div>
						<div class="form-group">
						<div class="card">
							<label for="Room">Room: </label>
							<select name="room" id="room">
								<option value=" ">choose your room</option>
							</select>							
						</div>
							<div class="card">
								<label for="Seat">Seat</label>
								<p>Please select first row of seats number from 1-10(or 15)</p>
								<select name="seat" id="seat">
									<option value=" ">choose your seat</option>									
								</select>
							</div>
						</div>									
						<div class="form-group">
							<div class="card total">
							<?php if($res = $con->query("select * from movies where mID=$movie_id;")){
								while ($price = $res -> fetch_assoc()){
									echo'
							<h3>Total:  <input type="text" id="total" name="total" value="'.$price['ticketprice'].'"></h3>';}}
								?>
							</div>
						</div>
					</div>
				<div class="form-button book-button">	
					<input class="btn btn-primary"  value="Book ticket" type="submit" name="register_btn">
				</div>	
			</form>
			</div>		
	</div>
</div>
</div>
<?php include 'script.php'?>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
$("#cinema").change(function()
{
var cineplex_id= document.getElementById("cinema").value;
var cineplexpost_id = 'cineplexid='+ cineplex_id;

$.ajax
({
	type:'post',
url: "reserve.php?r=<?php echo $_GET['r']?>",
data:cineplexpost_id,
cache: false,
success: function(other)
{
$("#time").html(other);
} 
});
});
$("#time").change(function()
{
var time_id= document.getElementById("time").value;
var timepost_id = 'timeid='+ time_id;

$.ajax
({
	type:'post',
url: "manage_reserve2.php?r=<?php echo $_GET['r']?>",
data:timepost_id,
cache: false,
success: function(other)
{
$("#room").html(other);
} 
});
});
$("#time").change(function()
{
var time_id= document.getElementById("time").value;
var timepost_id = 'timeid='+ time_id;

$.ajax
({
	type:'post',
url: "manage_reserve3.php?r=<?php echo $_GET['r']?>",
data:timepost_id,
cache: false,
success: function(other)
{
$("#seat").html(other);
} 
});
});


</script>
</body>
</html>