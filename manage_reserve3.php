<?php include 'connect.php';?>
<?php									$id = $_POST['cineplexid'];
										$seat = $_POST['timeid'];
										if($res = $con->query("SELECT s.seatNumb
																from seats s
																where s.cinemaID = (select S.cinemaID from screentime S where S.screentimeID = '$seat')
																and s.cineplexID = (select S.cineplexID from screentime S where S.screentimeID = '$seat')")){
												while ($seats = $res -> fetch_assoc()){
												echo'
													<option value="'.$seats['seatNumb'].'">'.$seats['seatNumb'].'</option>';
												}
										}
									?>