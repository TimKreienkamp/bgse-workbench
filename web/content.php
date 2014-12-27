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


$query = "select a.week, d.questions_asked as q_2014, a.questions_asked as q_2013, b.questions_asked as q_2012, c.questions_asked as q_2011, e.questions_asked as q_2010
from
(select week, questions_asked from questions_asked_weekly where year = '2013' order by week) a
left join 
(select week, questions_asked from questions_asked_weekly where year = '2012' order by week) b
on a.week = b.week
left join 
(select week, questions_asked from questions_asked_weekly where year = '2011' order by week) c
on a.week = c.week
left join 
(select week, questions_asked from questions_asked_weekly where year = '2014' order by week) d
on a.week = d.week
left join 
(select week, questions_asked from questions_asked_weekly where year = '2010' order by week) e
on a.week = e.week
group by 1 order by 1
;";

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
            $temp[] = array('v' => (float) $row['q_2014']);
            $temp[] = array('v' => (float) $row['q_2013']);
            $temp[] = array('v' => (float) $row['q_2012']);
            $temp[] = array('v' => (float) $row['q_2011']);
            $temp[] = array('v' => (float) $row['q_2010']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_4 = json_encode($table);
mysqli_free_result($result);



$query = "select a.week, d.percentage_answered as p_2014, a.percentage_answered as p_2013, b.percentage_answered as p_2012, c.percentage_answered as p_2011, e.percentage_answered as p_2010
from
(select week, percentage_answered from answer_share_weekly where year = '2013' order by week) a
left join 
(select week, percentage_answered from answer_share_weekly where year = '2012' order by week) b
on a.week = b.week
left join 
(select week, percentage_answered from answer_share_weekly where year = '2011' order by week) c
on a.week = c.week
left join 
(select week, percentage_answered from answer_share_weekly where year = '2014' order by week) d
on a.week = d.week
left join 
(select week,percentage_answered from answer_share_weekly where year = '2010' order by week) e
on a.week = e.week
group by 1 order by 1
;";

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
            $temp[] = array('v' => (float) $row['p_2014']);
            $temp[] = array('v' => (float) $row['p_2013']);
            $temp[] = array('v' => (float) $row['p_2012']);
            $temp[] = array('v' => (float) $row['p_2011']);
            $temp[] = array('v' => (float) $row['p_2010']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_5 = json_encode($table);
mysqli_free_result($result);



$query = "select tagname, count from tags order by count desc limit 10;";

if ($result = $mysqli->query($query)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Tag', 'type' => 'string'),
            array('label' => 'Posts', 'type' => 'number'),
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['tagname']);
            $temp[] = array('v' => (float) $row['count']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_6 = json_encode($table);
mysqli_free_result($result);


$query = "select tagname, comments, round(views/1000,0) as views_in_k, answers from topics order by comments desc limit 10;";

if ($result = $mysqli->query($query)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Tag', 'type' => 'string'),
            array('label' => 'Comments', 'type' => 'number'),
            array('label' => 'Views (In Thousands)', 'type' => 'number'),
            array('label' => 'Answers', 'type' => 'number')
            
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['tagname']);
            $temp[] = array('v' => (int) $row['comments']);
            $temp[] = array('v' => (int) $row['views_in_k']);
            $temp[] = array('v' => (int) $row['answers']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_7 = json_encode($table);
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

  var lineData = new google.visualization.DataTable(<?php echo $jsonTable_4?>);
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

  var lineChart = new google.visualization.LineChart(document.getElementById('line-chart'));
  lineChart.draw(lineData, lineOptions);
  
  var lineData2 = new google.visualization.DataTable(<?php echo $jsonTable_5?>);
  var lineChart2 = new google.visualization.LineChart(document.getElementById('line-chart_2'));
  lineChart2.draw(lineData2, lineOptions);

  var barData =  new google.visualization.DataTable(<?php echo $jsonTable_6?>);
  

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

  var barData2 =  new google.visualization.DataTable(<?php echo $jsonTable_7?>);
  var barChart2 = new google.visualization.ColumnChart(document.getElementById('bar-chart_2'));
  barChart2.draw(barData2, barOptions);

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
            <li><a class="smoothscroll" href="./activity.php">Activity and Engagement</a></li>
            <li><a class="smoothscroll" href="./content.php">Content Analytics</a></li>
            <li><a class="smoothscroll" href="./predictive_new.php">Predictive Analytics</a></li>
            <li><a class="smoothscroll" href="./network.php">Network Analysis</a></li>
         </ul> <!-- end #nav -->

      </nav> <!-- end #nav-wrap -->


   </header> <!-- Header End -->
  
  <main>
    <br>
    <h2>Content Analytics</h2>
    <h4> Questions Asked & Answered - Weekly Year over Year Comparison</h4>
    <h5> Questions Asked </h5>
    <div id = "line-chart"></div>
    <h5> Questions Answered (in percent of asked questions) </h5>
    <div id = "line-chart_2"></div>
    <hr>
    <h4> Topics</h4>
    <h5> Most Popular Tags</h5>
    <div id = "bar-chart"></div>
    <h5> Topic Stats </h5>
    <div id = "bar-chart_2"></div>
  </main>
  </body>

</html>
