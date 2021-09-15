<?php include 'header.php'?>
<body>
	<nav class="navbar navbar-expand-sm navbar-light static-top py-4" id="mainNav">
					<a class="navbar-brand" href="index.php"><span>M</span>Ticket</a>
					<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#Navbar" aria-controls="Navbar" aria-expanded="false" aria-label="Toggle navigation">
						<span class="fa fa-bars"></span>
					</button>
					<div class="collapse navbar-collapse" id="Navbar">
						<ul class="navbar-nav ml-auto">
							<li class="nav-item"><a class="nav-link" href="index.php">Home</a></li>
							<li class="nav-item dropdown">
							  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								Movies
							  </a>
							  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="onshowing.php">On Showing movies</a></li>
								<li><a class="dropdown-item" href="populargenres.php">Popular movies genre</a></li>
								<li><a class="dropdown-item" href="F&B.php">Food and Beverage</a></li>
							  </ul>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								Account
							  </a>
							  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<?php if(isset($_SESSION['username'])){	?>
								<li><a class="dropdown-item" href="userprofile.php"><?php echo $_SESSION['username']?></a></li>
								<li><a class="dropdown-item" href="logout.php">Log out</a></li>
								<?php
								}else{ ?>
									<li><a class="dropdown-item" href="login_form.php">Log in</a></li>
									<li><a class="dropdown-item" href="registration_form.php">Register</a></li>
								<?php } ?>
							  </ul>
							</li>
						</ul>
					</div>
		</nav>