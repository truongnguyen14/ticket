<?php include 'header.php';
		include 'navbar.php'?>
<div class="container">
	<center><h2 class="text-primary">Now Showing</h2></center>
		<div class="row">
			<?php
		  $_SESSION['redirectURL'] = $_SERVER['REQUEST_URI'];
		  $count=0;
          $res=$con->query("select * from movies;");
          while ($row=$res->fetch_assoc()) {
			echo'
			<div class="col-md-4">
				<div class="card">
					<img src="images/'. $row['image'].'" class="card-img" alt="picture">
					  <div class="card-body">
						<h4 class="card-title"><a href="movieinfo.php?m='.$row['mID'].'" class="movie-name">'. $row['name'].'</a></h4>
						<p class="card-text">Genre: '. $row['genre'].' </p>
						<p class="card-text">Rated: '.$row['rated'].'</p>
						<p class="card-text">Rating: '.$row['rating'].'</p>
						<a href="reserve.php?r='.$row['mID'].'" class="btn btn-primary">Book Ticket</a>
					  </div>
				</div>
			</div>';
			$count++;
		  }
?>			
		</div>
	</div>
	<?php include 'script.php'?>
</body>
</html>