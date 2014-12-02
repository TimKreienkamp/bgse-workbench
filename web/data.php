
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
	<title>MyApp</title> 
	<link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<?php

include 'functions.php';

$GLOBALS['graphid'] = 0;

// Load libraries
document_header();
// Create connection
$link = connect_to_db();



// Page body. Write here your queries
$query = "SELECT * FROM stackexchange.Badges limit 15";
$title = "Badges list (15 badges)";
query_and_print_table($query,$title);
echo "Comment 1";

$query = "SELECT count(TagId) as QuestionsTaggedBayes from stackexchange.Tags where lower(TagName) like '%bayes%'";
$title = "Questions about Bayes";
query_and_print_table($query,$title);
echo "Comment 2";

$query = "SELECT count(PostId) as NumberOfPosts from stackexchange.Posts";
$title = "Questions about Bayes";
query_and_print_table($query,$title);
echo "Comment 2";


// query_and_print_graph: Needs two columns: the first one with labels, the second one with values of the graph
$query = "SELECT ProductName, UnitPrice FROM ecommerce.products ORDER BY UnitPrice DESC LIMIT 10";
$title = "Top products";
query_and_print_graph($query,$title,"Euros");
echo "Comment 3";

$query = "SELECT ProductName, UnitPrice FROM ecommerce.products ORDER BY UnitPrice ASC LIMIT 10";
$title = "Top cheap products";
query_and_print_graph($query,$title,"Euros");
echo "Comment 4";



?>

// Close connection
mysql_close($link);
?>
