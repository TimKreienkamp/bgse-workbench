<?php

ini_set('memory_limit', '-1');

date_default_timezone_set('Europe/Berlin');

$GLOBALS['graphid'] = 0;

// Load libraries

$con= mysqli_connect("127.0.0.1","root","root", "stackexchange") or die ("could not connect to mysql"); 
$result = mysqli_query($con,"select date,mau,wau,dau from mau_wau_dau");



if ($result !== false) {

    $output = Array();

    while ($row = mysqli_fetch_assoc($result)) {

        $DateTimeArray = $row["date"];

        $MYvalue1 = $row["mau"];

        $MYvalue2 = $row["wau"];

        

    

        $date = date('Y-m-d', strtotime($DateTimeArray));

        $time = date('H:i:s', strtotime($DateTimeArray));




        $dateArray = explode('-', $date);

        $year = $dateArray[0];

        $month = $dateArray[1] - 1; // adjust for javascript's 0-indexed months

        $day = $dateArray[2];

        

        $timeArray = explode(':', $time);

        $hours = $timeArray[0];

        $minutes = $timeArray[1];

        $seconds = $timeArray[2];


   

        $output[] = "[new Date($year,$month,$day,$hours,$minutes,$seconds), $MYvalue1, $MYvalue2, $MYvalue3]";

    }

}

?>


<html>

  <head>
    <link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="style.css">

  </head>

      <script type='text/javascript' src='http://www.google.com/jsapi'></script>

    <script type='text/javascript'>

      google.load('visualization', '1.1', {'packages':['annotationchart']});

      google.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = new google.visualization.DataTable();

        data.addColumn('datetime', 'Date');

        data.addColumn('number', 'mau');

        data.addColumn('number', 'wau');

        



        data.addRows([ <?php echo implode(',', $output); ?>]);



        var chart = new google.visualization.AnnotationChart(document.getElementById('chart_div'));



        var options = {

          displayAnnotations: true,

        };



        chart.draw(data, options);

      }

    </script>



  <body>
    <header>

      

      <nav id="nav-wrap">         
         
         <a class="mobile-btn" href="#nav-wrap" title="Show navigation">Show Menu</a>
         <a class="mobile-btn" href="#" title="Hide navigation">Hide Menu</a>         

         <ul id="nav" class="nav">
            <li><a class="smoothscroll" href="./index.php">Home</a></li>
            <li><a class="smoothscroll" href="./activity.php">Activity and Engagement</a></li>
            <li><a class="smoothscroll" href="./content.php">Content Analytics</a></li>
            <li><a class="smoothscroll" href="./predictive.php">Predictive Analytics</a></li>
            <li><a class="smoothscroll" href="./network.php">Network Analysis</a></li>
         </ul> <!-- end #nav -->

      </nav> <!-- end #nav-wrap -->


   </header> <!-- Header End -->
  
  <div id="main">

    <h1 style = "text-align:center; font = montserrat-regular; color: #58687A">Activity and Engagement Dashboard</h1>

    <p style = "text-align:center; width = 75px; color:black"> This graph shows the evolution of monthly and weekly active users (MAU/WAU) over time.</p>
  

    <div id='chart_div' style="width: 700px; height: 500px; dispay:block; margin: 0 auto" align = "center"></div>

  

  </body>

</html>