<?php include 'header.php'?>
<?php include 'navbar.php'?>
<body>
<div class="container">
    <center><h1 class="text-primary">Popular movie genres</h1></center>
	<?php
		  $_SESSION['redirectURL'] = $_SERVER['REQUEST_URI'];
          $res = $con -> query("select M.genre, M.name,count(genre) as Viewed
											from reservations R, screentime S, movies M
											where R.screentimeID = S.screentimeID and S.mID = M.MID
											group by M.genre
											order by Viewed desc
											LIMIT 1");
          while ($row = $res -> fetch_assoc()) {
			echo'
	<center><h4 class="text-primary"><small>Current popular movie genre: '. $row['genre'].'</small></h3></center>
	<center><h4 class="text-primary"><small>Movies with the same gernes: '. $row['name'].'</small></h3></center>
		  ';}?>
	<div class="row">
		<?php
		  $count = 0;
          $ress = $con -> query("select M.image, M.mID, M.name, M.genre, M.rated, M.rating, count(genre) as Viewed
											from reservations R, screentime S, movies M
											where R.screentimeID = S.screentimeID and S.mID = M.MID
											group by M.image, M.mID, M.name, M.genre, M.rated, M.rating
											order by Viewed desc
											LIMIT 1");
          while ($rows = $ress -> fetch_assoc()) {
			echo'
			<div class="col-md-4">
				<div class="card">
					<img src="images/'. $rows['image'].'" class="card-img" alt="picture">
					  <div class="card-body">
						<h4 class="card-title"><a href="movieinfo.php?m='.$rows['mID'].'" class="movie-name">'. $rows['name'].'</a></h4>
						<p class="card-text">Genre: '. $rows['genre'].' </p>
						<p class="card-text">Rated: '.$rows['rated'].'</p>
						<p class="card-text">Rating: '.$rows['rating'].'</p>
						<a href="reserve.php?r='.$rows['mID'].'" class="btn btn-primary">Book Ticket</a>
					  </div>
				</div>
			</div>';
			$count++;
		  }
?>	</div>		
	</div>
<?php include'script.php'?>
</body>
</html>