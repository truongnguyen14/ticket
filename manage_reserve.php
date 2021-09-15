<?php include 'connect.php';?>
						<?php		
								$movie_id=$_GET['r'];
									$value = $_POST['cineplexid'];
									if($res = $con->query("select * from screentime s where s.cineplexID = '$value' and s.mID = '$movie_id'")){
										if($value==""){
										echo "<option>Full</option>";
									}else{
										while ($time = $res -> fetch_assoc()){
										echo'
											<option value="'.$time['screentimeID'].'">Day: '.$time['day'].', Date: '.$time['date'].', Start time: '.$time['starttime'].'</option>';
									}};}
													
										?>
								
									
							
						
					