<?php

ini_set('memory_limit', '-1');

date_default_timezone_set('Europe/Berlin');

$GLOBALS['graphid'] = 0;

// Load libraries

$DB_NAME = 'stackexchange';
 $DB_HOST = '127.0.0.1';
 $DB_USER = 'root';
 $DB_PASS = 'root';

$mysqli = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);

$result = mysqli_query($mysqli, "select date, mau, wau from mau_wau_dau");


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
mysqli_free_result($result);

$query = "select case 
when age > 0 and age <= 19 then 'under_20'
when (age >= 20 and age <= 30) then '20_to_30'
when age >= 30 and age <= 40 then 'over_30'
when age >40 and age <= 50 then 'over_40'
when age > 50 then 'senior citizen'
else 'NA'
end as age_group,
count(userid)/(select count(userid) from users where age != '')*100 as percentage
from users
group by 1
having age_group != 'NA';
";

if ($result = $mysqli->query($query)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Age Group', 'type' => 'string'),
            array('label' => 'Percentage', 'type' => 'number')
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['age_group']);
            $temp[] = array('v' => (int) $row['percentage']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable = json_encode($table);
mysqli_free_result($result);


$query = "select 
case when
location = '' then 'Not Given' else 
location end as location, 
round(avg(reputation/10),2) as average_reputation,
round(avg(numberofbadges),2) as average_badges,
round(avg(answersreceived/totalposts),2) as average_answers_per_question
from userdata 
group by 1 having count(userid) > 50 order by 4 desc limit 15;";

if ($result = $mysqli->query($query)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Location', 'type' => 'string'),
            array('label' => 'Average Reputation', 'type' => 'number'),
            array('label' => 'Average Badges', 'type' => 'number'),
            array('label' => 'Average Answers Per Question', 'type' => 'number')
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['location']);
            $temp[] = array('v' => (float) $row['average_reputation']);
            $temp[] = array('v' => (float) $row['average_badges']);
            $temp[] = array('v' => (float) $row['average_answers_per_question']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_2 = json_encode($table);
mysqli_free_result($result);


$query = "select a.week, d.users as u_2014, a.users as u_2013, b.users as u_2012, c.users as u_2011, e.users as u_2010
from
(select week, users from users_acquired_weekly where year = '2013' order by week) a
left join 
(select week, users from users_acquired_weekly where year = '2012' order by week) b
on a.week = b.week
left join 
(select week, users from users_acquired_weekly where year = '2011' order by week) c
on a.week = c.week
left join 
(select week, users from users_acquired_weekly where year = '2014' order by week) d
on a.week = d.week
left join 
(select week, users from users_acquired_weekly where year = '2010' order by week) e
on a.week = e.week
group by 1 order by 1
;;";

if ($result = $mysqli->query($query)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Week of Year', 'type' => 'string'),
            array('label' => '2014', 'type' => 'number'),
            array('label' => '2013', 'type' => 'number'),
            array('label' => '2012', 'type' => 'number'),
            array('label' => '2011', 'type' => 'number'),
            array('label' => '2010', 'type' => 'number')
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['week']);
            $temp[] = array('v' => (float) $row['u_2014']);
            $temp[] = array('v' => (float) $row['u_2013']);
            $temp[] = array('v' => (float) $row['u_2012']);
            $temp[] = array('v' => (float) $row['u_2011']);
            $temp[] = array('v' => (float) $row['u_2010']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_3 = json_encode($table);
mysqli_free_result($result);




?>


<html>

  <head>
    <link rel="stylesheet" type="text/css" href="charts.css">


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



        var chart = new google.visualization.AnnotationChart(document.getElementById('line-chart'));



        var options = {

          displayAnnotations: true,

        };



        chart.draw(data, options);

        var pieData =  new google.visualization.DataTable(<?php echo $jsonTable?>);

        var pieOptions = {
        backgroundColor: 'transparent',
        pieHole: 0.4,
        colors: [ "cornflowerblue", 
              "olivedrab", 
              "orange", 
              "tomato", 
              "crimson", 
              "purple", 
              "turquoise", 
              "forestgreen", 
              "navy", 
              "gray"],
      pieSliceText: 'value',
      tooltip: {
      text: 'percentage'
      },
      fontName: 'Open Sans',
      chartArea: {
      width: '100%',
      height: '94%'
      },
      legend: {
      textStyle: {
        fontSize: 13
      }
    }
  };

  var pieChart = new google.visualization.PieChart(document.getElementById('pie-chart'));
  pieChart.draw(pieData, pieOptions);

  var barData =  new google.visualization.DataTable(<?php echo $jsonTable_2?>);
  

  // set bar chart options
  var barOptions = {
    focusTarget: 'category',
    backgroundColor: 'transparent',
    colors: ['#23292f', 'grey', 'blue'],
    fontName: 'Open Sans',
    chartArea: {
      left: 50,
      top: 10,
      width: '100%',
      height: '70%'
    },
    bar: {
      groupWidth: '80%'
    },
    hAxis: {
      textStyle: {
        fontSize: 11
      }
    },
    vAxis: {
      baselineColor: '#DDD',
      gridlines: {
        color: '#DDD',
        count: 4
      },
      textStyle: {
        fontSize: 11
      }
    },
    legend: {
      position: 'bottom',
      textStyle: {
        fontSize: 12
      }
    },
    animation: {
      duration: 1200,
      easing: 'out'
    }
  };
  var barChart = new google.visualization.BarChart(document.getElementById('bar-chart'));
  barChart.draw(barData, barOptions);

  var lineData = new google.visualization.DataTable(<?php echo $jsonTable_3?>);
  var lineOptions = {
    backgroundColor: 'transparent',
    colors: ['cornflowerblue', 'tomato', 'navy', 'grey'],
    fontName: 'Open Sans',
    focusTarget: 'category',
    chartArea: {
      left: 50,
      top: 10,
      width: '100%',
      height: '70%'
    },
    hAxis: {
      //showTextEvery: 12,
      textStyle: {
        fontSize: 11
      },
      baselineColor: 'transparent',
      gridlines: {
        color: 'transparent'
      }
    },
    vAxis: {
      minValue: 0,
      baselineColor: '#DDD',
      gridlines: {
        color: '#DDD',
        count: 4
      },
      textStyle: {
        fontSize: 11
      }
    },
    legend: {
      position: 'bottom',
      textStyle: {
        fontSize: 12
      }
    },
    animation: {
      duration: 1200,
      easing: 'out'
    }
  };

  var lineChart = new google.visualization.LineChart(document.getElementById('line-chart_2'));
  lineChart.draw(lineData, lineOptions);
  

      }


    </script>

  </head>


  <body>
    <header>

      

      <nav id="nav-wrap">         
         
         <a class="mobile-btn" href="#nav-wrap" title="Show navigation">Show Menu</a>
         <a class="mobile-btn" href="#" title="Hide navigation">Hide Menu</a>         

         <ul id="nav" class="nav">
            <li><a class="smoothscroll" href="./index.php">Home</a></li>
            <li><a class="smoothscroll" href="./activity.php">User Analytics</a></li>
            <li><a class="smoothscroll" href="./content.php">Content Analytics</a></li>
            <li><a class="smoothscroll" href="./predictive_new.php">Predictive Analytics</a></li>
            <li><a class="smoothscroll" href="./network_age.php">Network Analysis - Age</a></li>
            <li><a class="smoothscroll" href="./network_country.php">Network Analysis - Country</a></li>
         </ul> <!-- end #nav -->

      </nav> <!-- end #nav-wrap -->


   </header> <!-- Header End -->
  
  <main>
    <br>
    <h2>User Analytics Dashboard</h2>
    <hr>
    <p> This graph shows the evolution of monthly and weekly active users (MAU/WAU) over time.</p>

    <div id='line-chart'></div>
    <h5> Users by Age .</h5>
    <div id = 'pie-chart'></div>
    <h5> Average Reputation, Answers Received Per Question and Average Badges earned by Location .</h5>
    <p> Reputation Divided by 10 for Visualisation Purposes. Only Locations with more than 50 Users considered. </p>
    <div id='bar-chart'></div>
    <h5>New Users Aquired by Week</h5>
    <p> Year-over-Year Comparison. Note that the service started in mid-2010 and data is only available until mid-September 2014. </p>
    <div id = 'line-chart_2'></div>
  </main>
  </body>

</html>
