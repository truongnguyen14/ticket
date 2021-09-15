<?php include 'connect.php';?>

								<?php
									 $count = 0;
									$room = $_POST['timeid'];
									if($res = $con->query("select s.cinemaID
															from screentime s
															where s.screentimeID = '$room'")){
										while ($cine = $res -> fetch_assoc()){
											 
										echo'
													<option value="'.$cine['cinemaID'].'">'.$cine['cinemaID'].'</option>';
												}
										
										}
								
									?>
									
							