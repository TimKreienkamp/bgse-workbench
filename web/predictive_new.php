 <?php

 $DB_NAME = 'stackexchange';
 $DB_HOST = '127.0.0.1';
 $DB_USER = 'root';
 $DB_PASS = 'root';

$mysqli = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);

function getHtmlTable($rs){
  // receive a record set and print
  // it into an html table
  $out = '<table>';
  while ($field = $rs->fetch_field()) $out .= "<th>".$field->name."</th>";
  while ($linea = $rs->fetch_assoc()) {
    $out .= "<tr>";
    foreach ($linea as $valor_col) $out .= '<td>'.$valor_col.'</td>';
    $out .= "</tr>";
  }
  $out .= "</table>";
  return $out;
}


if (mysqli_connect_errno()) {
  printf("Connect failed: %s\n", mysqli_connect_error());
  exit();
}
$query = "select case when target = 1 then 'Answered' else 'Unanswered' end as answer_status, 
round(count(questionid)/(select count(questionid) from analysis_mart_w_answered_questions)*100,3) as percentage
from analysis_mart_w_answered_questions group by 1;
";

if ($result = $mysqli->query($query)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Answer Status', 'type' => 'string'),
            array('label' => 'Percentage', 'type' => 'number')
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['answer_status']);
            $temp[] = array('v' => (int) $row['percentage']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable = json_encode($table);
mysqli_free_result($result);

$query_2 = "select quantile, round(hours,2) as hours from quantiles where quantile like '%0%';";

//$result = ($mysqli, $query_2)

if ($result = $mysqli->query($query_2)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Quantile', 'type' => 'string'),
            array('label' => 'Hours', 'type' => 'number')
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['quantile']);
            $temp[] = array('v' => (int) $row['hours']);
            $rows[] = array('c' => $temp);
            }
   }
 }

$table['rows'] = $rows;
$jsonTable_2 = json_encode($table);
mysqli_free_result($result);

$query_3 = "select row_names as feature, round(overall,2) as importance from feature_importances order by 2 desc limit 10;";

//$result = ($mysqli, $query_2)

if ($result = $mysqli->query($query_3)) {
    {
    $rows = array();
    $table = array();
    $table['cols'] = array(
            array('label' => 'Feature', 'type' => 'string'),
            array('label' => 'Importance', 'type' => 'number')
    );

    while ($row = $result->fetch_assoc()) {
            $temp = array();
            $temp[] = array('v' => (string) $row['feature']);
            $temp[] = array('v' => (int) $row['importance']);
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
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
google.load("visualization", "1", {packages:["corechart", "table"]});
google.setOnLoadCallback(drawVisualization);
function drawVisualization() {
  
  // BEGIN BAR CHART
  

  var barData =  new google.visualization.DataTable(<?php echo $jsonTable?>);
  

  // set bar chart options
  var barOptions = {
    focusTarget: 'category',
    backgroundColor: 'transparent',
    colors: ['#23292f'],
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
  var barChart = new google.visualization.ColumnChart(document.getElementById('bar-chart'));
  barChart.draw(barData, barOptions);
  

  var barData_2 = new google.visualization.DataTable(<?php echo $jsonTable_2?>);
  var barChart_2 = new google.visualization.ColumnChart(document.getElementById('bar-chart_2'));
  //barChart.draw(barZeroData, barOptions);
  barChart_2.draw(barData_2, barOptions);

  var barData_3 = new google.visualization.DataTable(<?php echo $jsonTable_3?>);
  var barChart_3 = new google.visualization.BarChart(document.getElementById('bar-chart_3'));
  //barChart.draw(barZeroData, barOptions);
  barChart_3.draw(barData_3, barOptions);
  // BEGIN LINE GRAP2
  
  



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
            <li><a class="smoothscroll" href="./network_age.html">Network Analysis - Age</a></li>
            <li><a class="smoothscroll" href="./network_country.html">Network Analysis - Country</a></li>
         </ul> <!-- end #nav -->

      </nav> <!-- end #nav-wrap -->
</header>

<main>
  <br>
  <h2>Predictive Analytics</h2>
  When operating a Q&A Website, such as stackoverflow or in this case, CrossValidated,
  it is all about high-quality questions and answers. Having many unanswered questions will scare away potential new users and decreases the 
  (perceived) usefulness of the service for existing users. We therefore aim to build a Machine Learning Model to predict if a question will be answered or not.
  We start our analysis by exploring the distribution of answered / unanswered questions
  <h5>Answered Questions</h5>
  <div id="bar-chart"></div>
  <p > This initial exploration reveals that we deal with quite unbalanced classes. This is something 
  we have to deal with later when choosing which machine learning methods we want to utilize. For now, we continue exploring the data set. We hypothesize, that 
  answers on questions are a time variant phenomenum, i.e. the more time has passed the more likely is a question to be answered. We examine after how much time 
  most answered questions were actually answered by plotting the quantiles.</p>
  <h5>Time to Answer - Quantiles </h5>
  <div id="bar-chart_2"></div>
  <p > Here we see, that most answered questions are actually answered after 120 hours (90% quantile). Thus we only include questions older than 120 hours in hour analyis, 
   since other questions might only not be answered because they it is still too early (note that the last day of the database dump is the Sep 14, 2014). <br>
   We hypothesize that the the characteristics of the user asking, as well as the characteristics of the specific question influence the likelihood of receiving an answer. Hence
   we extract user and question-related features from the database. Among other things, we create binary variables to indicate if the question asked was tagged with each of 
   the 20 most popular tags. We also include the length of the question, the reputation of the user, her questions previously answered questions and certain other characteristics.
  We proceed by summarizing the obtained training data. </p> <br>
  <h5> Training Data Summary</h5>
  <?php 
  $rs = mysqli_query($mysqli, "select * from summary");
  echo getHtmlTable($rs);
  mysqli_free_result($rs);
  ?>
  <p > While most of the features are binary, the continouous features are obviously quite different in their scales/magnitudes. We therefore standardize them (mean
    removal, didiving by std. dev.). Also, we remove the Feature "Creation Year 200)" (Referring to the year when the profile was createed). Next, we feed
    the data into a gradient boosting machine. We use ten-fold cross validation to combat overfitting and select hyperparamters via GridSearch. The hyperparameters for
    gradient boosting are the number of trees, interaction depth (i.e. how deep the trees are) and a learning rate/shrinkage parameter. Our tuning grid is shown below:
  </p> <br>
  <?php 
  $rs = mysqli_query($mysqli, "select * from tune_grid");
  echo getHtmlTable($rs);
  mysqli_free_result($rs);
  ?>
  <br>
  <p > We run the model and inspect the results:
  </p> <br>
  <?php 
  $rs = mysqli_query($mysqli, "select * from results_model_1");
  echo getHtmlTable($rs);
  mysqli_free_result($rs);
  ?>
  <p > Since they look solid, we want to see which features are most important / have the most predictive power. 
  </p> <br>
  <h5>Feature Importances</h5>
  <div id="bar-chart_3"></div>
  <p > This is interesting: The topic (indicated by the tag) is not useful in predicting if a question is answered. Instead, user-inherent characteristics, namely her reputation
    and first and foremost the number of answers she has already received. On first sight, question-specific characteristics are not as relevant as user-specific characteristics.
     However, it might very well be that certain users always / most of the time post high-quality questions, which are more likely to be answered.
     We retrain the model, using only the most relevant features and get the following results
  </p>
  <?php 
  $rs = mysqli_query($mysqli, "select * from results_model_2");
  echo getHtmlTable($rs);
  mysqli_free_result($rs);
  ?>
  <p > Here we see, that with a siginficantly reduced feature amount (actually, we chose only Reputation and Questions Answered), we are able to achieve almost as good out-of-sample
    accuracy as with all the features. We prefer having a small amount of features in a real-life setting for mainly two reasons: prevention of overfitting and computational/storage
    efficiency. In a real-life setting, what we would do now is recode the model in a lower level language, install it on the server,
    develop a stored procedure to retrain it every week with the obtained parameters from the gridsearch. Then we would use it to live-score new questions.
  </p>

  
</main>
</body>