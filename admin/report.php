<?php include_once 'header.php'?>
<?php include 'navbar.php'?>
<?php
						if(!isset($_SESSION['admin'])){
							header('location: login_form.php');
					}
					?>
<div class="container">
	<div class="row">
		<div>
		<center><h3 class="text-primary">Most view location</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>CineplexID</th>
				<th>Address</th>
				<th>Reserved</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select count(a.reserveID) as Reserved, a.cineplexID, c.address
										from reservations a, cineplex c
										where a.cineplexID = c.cineplexID
										group by a.cineplexID, c.address
										order by Reserved desc
										LIMIT 1")){
								while ($cineplex = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$cineplex['cineplexID'].'</td>
											<td>'.$cineplex['address'].'</td>
											<td>'.$cineplex['Reserved'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	</div>
	<div class="row">
		<div>
		<center><h3 class="text-primary">List of customer</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>cID</th>
				<th>cUsername</th>
				<th>fname</th>
				<th>lname</th>
				<th>gender</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("SELECT cID, cUsername, fname, lname, gender 
								FROM customers ")){
								while ($customer = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$customer['cID'].'</td>
											<td>'.$customer['cUsername'].'</td>
											<td>'.$customer['fname'].'</td>
											<td>'.$customer['lname'].'</td>
											<td>'.$customer['gender'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		<div>
		<center><h3 class="text-primary">List of reservations</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>RESERVEID</th>
				<th>CID</th>
				<th>SCREENTIMEID</th>
				<th>CINEPLEXID</th>
				<th>CINEMAID</th>
				<th>SEATNUMB</th>
				<th>TOTALPRICE</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select RESERVEID,
											   CID,
											   SCREENTIMEID,
											   CINEPLEXID,
											   CINEMAID,
											   SEATNUMB,
											   TOTALPRICE
										  from RESERVATIONS ")){
								while ($reservation = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$reservation['RESERVEID'].'</td>
											<td>'.$reservation['CID'].'</td>
											<td>'.$reservation['SCREENTIMEID'].'</td>
											<td>'.$reservation['CINEPLEXID'].'</td>
											<td>'.$reservation['CINEMAID'].'</td>
											<td>'.$reservation['SEATNUMB'].'</td>
											<td>'.$reservation['TOTALPRICE'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	</div>
	<div class="row">
		<div>
		<center><h3 class="text-primary">List of reservations made by 1 user</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>cID</th>
				<th>CinemaID</th>
				<th>Fname</th>
				<th>Lname</th>
				<th>Phone
				<th>mID</th>
				<th>Movie name</th>
				<th>Cineplex name</th>
				<th>Address</th>
				<th>Ticket reserved</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("SELECT c.cID, count(c.cid) as TicketReserved, c.fname, c.lname, c.phone, m.mID, m.name, cine.cineplexname, cine.address, r.cinemaID
											FROM customers c, reservations r, cineplex cine, movies m, screentime s
											where r.cid = c.cid and s.mID = m.mID and s.screentimeID = r.screentimeID and cine.cineplexID = r.cineplexID
											group by c.cID , c.fname, c.lname, c.phone, m.mID, m.name, cine.cineplexname, cine.address, r.cinemaID
											order by c.cID asc ")){
								while ($reservations = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$reservations['cID'].'</td>
											<td>'.$reservations['cinemaID'].'</td>
											<td>'.$reservations['fname'].'</td>
											<td>'.$reservations['lname'].'</td>
											<td>'.$reservations['phone'].'</td>
											<td>'.$reservations['mID'].'</td>
											<td>'.$reservations['name'].'</td>
											<td>'.$reservations['cineplexname'].'</td>
											<td>'.$reservations['address'].'</td>
											<td>'.$reservations['TicketReserved'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	</div>
	</div class="row">
		<div>
		<center><h3 class="text-primary">Most popular movie genre</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Genre</th>
				<th>Viewed</th>			
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select M.genre,count(genre) as Viewed
											from reservations R, screentime S, movies M
											where R.screentimeID = S.screentimeID and S.mID = M.MID
											group by genre
											order by Viewed desc
											LIMIT 1")){
								while ($genre = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$genre['genre'].'</td>
											<td>'.$genre['Viewed'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
		<div>
		<center><h3 class="text-primary">Most reserved day</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Day</th>
				<th>Showtime count</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select s.day, count(r.screentimeID) as showtimecount
											from screentime s, reservations r
											where r.screentimeID = s.screentimeID
											group by s.day
											order by showtimecount desc
											LIMIT 1")){
								while ($reserveday = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$reserveday['day'].'</td>
											<td>'.$reserveday['showtimecount'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
		<div>
		<center><h3 class="text-primary">Number of show per day</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Day</th>
				<th>Showtime count</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select s.day, count(r.screentimeID) as showtimecount
										from screentime s, reservations r
										where r.screentimeID = s.screentimeID
										group by s.day
										order by showtimecount desc")){
								while ($reserveday = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$reserveday['day'].'</td>
											<td>'.$reserveday['showtimecount'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
		<div>
		<center><h3 class="text-primary">Total ticket revenue</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Total</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select  sum(R.totalprice) as TotalTicketRevenue
										from reservations R")){
								while ($ticrevenue = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$ticrevenue['TotalTicketRevenue'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div><div>
		<center><h3 class="text-primary">Total F&B revenue</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Total</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select sum(FB.itemprice) AS Total
										from fborder F, foodbeverage FB
										where F.itemID=FB.itemID")){
								while ($fbrevenue = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$fbrevenue['Total'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div><div>
		<center><h3 class="text-primary">Number of ticket sold</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Total</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("Select count(r.cID) as Total
										from reservations r")){
								while ($numtic = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$numtic['Total'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	<div>
		<center><h3 class="text-primary">Number of F&B sold</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>Total</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select count(f.orderid) as Total
										from fborder f")){
								while ($numfb = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$numfb['Total'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	<div>
		<center><h3 class="text-primary">Customer under 20</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>cID</th>
				<th>fname</th>
				<th>lname</th>
				<th>dob</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("Select Cus.cID, Cus.fname, Cus.lname, Cus.dob
										From Customers Cus
										Where Cus.dob > '2001-9-11'")){
								while ($cusunder20 = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$cusunder20['cID'].'</td>
											<td>'.$cusunder20['fname'].'</td>
											<td>'.$cusunder20['lname'].'</td>
											<td>'.$cusunder20['dob'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	<div>
		<center><h3 class="text-primary">Customer buy more than 3 tickets</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>cID</th>
				<th>fname</th>
				<th>lname</th>
				<th>Ticket</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("Select Cus.cID, Cus.fname, Cus.lname, count(R.cID) as Ticket
										From Customers Cus, Reservations R
										Where  Cus.cID = R.cID and R.cID in (select R.cID from reservations R group by R.cID having count(R.cID) >2)
										group by R.cID
										order by Cus.cid asc")){
								while ($cusbuy = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$cusbuy['cID'].'</td>
											<td>'.$cusbuy['fname'].'</td>
											<td>'.$cusbuy['lname'].'</td>
											<td>'.$cusbuy['Ticket'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	<div>
		<center><h3 class="text-primary">List of food and berverage</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>ItemID</th>
				<th>Item name</th>
				<th>Item price</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("select ITEMID,
									   ITEMNAME,
									   ITEMPRICE
								  from FOODBEVERAGE")){
								while ($Item = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$Item['ITEMID'].'</td>
											<td>'.$Item['ITEMNAME'].'</td>
											<td>'.$Item['ITEMPRICE'].'</td>	
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	<div>
		<center><h3 class="text-primary">Movie list</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>mID</th>
				<th>name</th>
				<th>moviedescription</th>
				<th>genre</th>
				<th>rated</th>
				<th>rating</th>
				<th>ticketprice</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("Select m.mID, m.name, m.moviedescription, m.genre, m.rated, m.rating, m.ticketprice from movies m")){
								while ($movie = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$movie['mID'].'</td>
											<td>'.$movie['name'].'</td>
											<td>'.$movie['moviedescription'].'</td>
											<td>'.$movie['genre'].'</td>
											<td>'.$movie['rated'].'</td>
											<td>'.$movie['rating'].'</td>
											<td>'.$movie['ticketprice'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	<div>
		<center><h3 class="text-primary">Cinema location</h3></center>
		<table class="table table-bordered">
			<thead class="thead-dark">
			<tr>
				<th>cineplexID</th>
				<th>cineplexname</th>
				<th>address</th>
				<th>cineplexhotline</th>
			</tr>
			</thead>
			<tbody>
			<?php
				if($res = $con->query("Select c.cineplexID, c.cineplexname, c.address, c.cineplexhotline from cineplex c")){
								while ($cineplexi = $res -> fetch_assoc()){
									echo'<tr>
											<td>'.$cineplexi['cineplexID'].'</td>
											<td>'.$cineplexi['cineplexname'].'</td>
											<td>'.$cineplexi['address'].'</td>
											<td>'.$cineplexi['cineplexhotline'].'</td>
										</tr>';
										}}		
								?>
			</tbody>
		</table>
		</div>
	</div>
<?php include 'script.php'?>
</body>
</html>