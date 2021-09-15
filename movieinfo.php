<?php include 'header.php';
	  include 'navbar.php'?>
	<div class="movieinfo container">
		<div class="movie">			
			<?php 
				$movie_id = $_GET['m'];
				if($res = $con->query("select * from movies where mID=$movie_id;")){
					while ($row = $res -> fetch_assoc()){
					echo'
					<div class="row">
					<div class="col-md-5 box1">
						<img src="images/'.$row['image'].'" class="poster-image">
					</div>
					<div class="col align-self-center box2">
						<h1 class="movieinfo-title">'.$row['name'].'</h1>
						<h5>Description: '.$row['moviedescription'].'</h5>
						<h5>Genre: '.$row['genre'].'</h5>
						<h5>Rated: '.$row['rated'].'</h5>
						<h5>Rating: '.$row['rating'].'</h5>
					</div>
					</div>
					<div class="row">
					<div class="col-md-10 box3">
						<div class="movieinfo button">
							<a href="reserve.php?r='.$row['mID'].'" class="btn btn-primary">Book Ticket</a>
						</div>
					</div>
				</div>';}
				}?>
			
		</div>
	</div>
	<?php include 'script.php'?>
</body>
</html>
			