<?php include'connect.php';?>
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(genderChart);	 
	  google.charts.setOnLoadCallback(viewgenreChart);
	  google.charts.setOnLoadCallback(showbydayChart);
	  google.charts.setOnLoadCallback(viewlocationChart);
	  google.charts.setOnLoadCallback(viewpermovieChart);
      function genderChart() {
        var data = google.visualization.arrayToDataTable([
          ['Gender','Number of customers'],
          <?php $sql="select c.gender, count(gender) as value
						from customers c
						group by c.gender
						order by 2 Desc";
				$res=mysqli_query($con,$sql);
				while($data=mysqli_fetch_array($res)){
					$Gender=$data['gender'];
					$value=$data['value'];
					
					?>
					['<?php echo $Gender;?>',<?php echo $value;?>],
				<?php
				}
				?>
        ]);

        var options = {
          chart: {
            title: 'Customer gender',
            subtitle: 'Gender',
          },
          bars: 'verticle' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('customer_gender_bar'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
	  function viewgenreChart() {
        var data = google.visualization.arrayToDataTable([
          ['Genre','Views'],
          <?php $genre="select M.genre,count(genre) as Viewed
						from reservations R, screentime S, movies M
						where R.screentimeID = S.screentimeID and S.mID = M.MID
						group by genre";
				$res=mysqli_query($con,$genre);
				while($data=mysqli_fetch_array($res)){
					$viewed=$data['Viewed'];
					$genre=$data['genre'];
					
					?>
					['<?php echo $genre;?>',<?php echo $viewed;?>],
				<?php
				}
				?>
        ]);

        var options = {
          chart: {
            title: 'View by genre',
          },
          bars: 'verticle' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('genre_bar'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
	  function showbydayChart() {
        var data = google.visualization.arrayToDataTable([
          ['Day','Show'],
          <?php $showbyday="select S.day,count(reserveID) as Reserved
						from reservations R, screentime S
						where R.screentimeID = S.screentimeID 
						group by day";
				$res=mysqli_query($con,$showbyday);
				while($data=mysqli_fetch_array($res)){
					$reserved=$data['Reserved'];
					$day=$data['day'];
					
					?>
					['<?php echo $day;?>',<?php echo $reserved;?>],
				<?php
				}
				?>
        ]);

        var options = {
          chart: {
            title: 'Show by day',
          },
          bars: 'verticle' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('showbyday_bar'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
	  function viewlocationChart() {
        var data = google.visualization.arrayToDataTable([
          ['Address','reserved'],
          <?php $viewlocation="select a.cineplexID, c.address, count(a.reserveID) as res
							from reservations a, cineplex c
							where a.cineplexID = c.cineplexID
							group by a.cineplexID, c.address
							order by res desc";
				$res=mysqli_query($con,$viewlocation);
				while($data=mysqli_fetch_array($res)){
					$reserved=$data['res'];
					$address=$data['address'];
					?>
					['<?php echo $address;?>',<?php echo $reserved;?>],
				<?php
				}
				?>
        ]);

        var options = {
          chart: {
            title: 'Most viewed location',
          },
          bars: 'horizontal' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('viewlocation_bar'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
	  function viewpermovieChart() {
        var data = google.visualization.arrayToDataTable([
          ['MovieID','no.customers'],
          <?php $viewpermovie="select M.mID, M.name, count(reserveID) as value
							from reservations R, movies M, screentime S
							where R.screentimeID = S.screentimeID and S.mID = M.mID
							group by M.mID, M.name
							order by M.mID";
				$res=mysqli_query($con,$viewpermovie);
				while($data=mysqli_fetch_array($res)){
					$ID=$data['mID'];
					$movie=$data['name'];
					$customer=$data['value'];
					?>
					['<?php echo $ID;?>',<?php echo $customer;?>],
				<?php
				}
				?>
        ]);

        var options = {
          chart: {
            title: 'View per movie',
          },
          bars: 'vertical' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('viewpermovie_bar'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
  </head>
  <body>
  <?php
						if(!isset($_SESSION['admin'])){
							header('location: login_form.php');
					}
					?>
  <div class="container">
  <center><h1 class="text-primary">Bar chart</h1></center>
	<div class="row">
    <div id="customer_gender_bar" style="width: 900px; height: 500px;"></div>
	<div id="genre_bar" style="width: 900px; height: 500px;"></div>   
	<div id="showbyday_bar" style="width: 900px; height: 500px;"></div>   
	<div id="viewlocation_bar" style="width: 900px; height: 500px;"></div>   
	<div id="viewpermovie_bar" style="width: 9000px; height: 500px;"></div>   
	</div>
  </body>
</html>