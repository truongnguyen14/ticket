<?php include 'connect.php';?>
										<?php$value = $_POST['cineplexid']; 
										if($res = $con->query("select * from fbsell f where f.cineplexID = '$value'")){
												while ($fb = $res -> fetch_assoc()){
												echo'
													<option value="'.$fb['itemID'].'">'.$fb['itemName'].'</option>';
												}
										}
										?>