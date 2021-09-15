<?php include 'header.php'?>
	<div id="mycarousel" class="carousel slide" data-bs-ride="carousel">
    <ul class="carousel-indicators">
		<?php
			  $_SESSION['redirectURL'] = $_SERVER['REQUEST_URI'];
			  $slide = 0;
			  $res = $con -> query("select * from movies;");
			  while ($row = $res -> fetch_assoc()) {
				if ($slide == 5) {
					break;
				}
				if ($slide==0) {
					echo'<li data-target="#mycarousel" data-slide-to="'.$slide.'" class="active"></li>';		
				}
				else{
					echo'<li data-target="#mycarousel" data-slide-to="'.$slide.'" ></li>';
				}
				$slide++;}?>		 
    </ul>	
    <div class="carousel-inner">
			<?php
				$count = 0;
				$res = $con -> query("select * from movies;");
				while ($car = $res -> fetch_assoc()){
				if ($count == 5){
					break;
				}
				if ($count == 0){
					echo'
					<div class="carousel-item active" data-bs-interval="10000">';
				}
				else{
					echo'
					<div class="carousel-item" data-bs-interval="10000">';
				}
					echo'
					<img src="images/'.$car['image'].'" class="img-fluid" alt="First slide">
					<div class="container">
					  <div class="carousel-caption text-start">
						<h2>'.$car['name'].'</h2>
						<p><a href="reserve.php?r='.$car['mID'].'" class="btn btn-primary carousel">Book Ticket</a></p>
					  </div>
					</div>
					</div>';	
				$count++;
				}
			?>
	</div>
    <a class="carousel-control-prev" href="#mycarousel" role="button" data-slide="prev">
     <i class="fa fa-chevron-left fa-3x"></i>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#mycarousel" role="button" data-slide="next">
      <i class="fa fa-chevron-right fa-3x"></i>
      <span class="sr-only">Next</span>
    </a>
  </div>
  

