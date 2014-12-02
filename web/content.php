<?php ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
	<title>MyApp</title> 
	<link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<script>
/**
 * Given an element, or an element ID, blank its style's display
 * property (return it to default)
 */
function show(element) {
    if (typeof(element) != "object")	{
	element = document.getElementById(element);
    }
    
    if (typeof(element) == "object") {
	element.style.display = '';
    }
}
/**
 * Given an element, or an element ID, set its style's display property
 * to 'none'
 */
function hide(element) {
    if (typeof(element) != "object")	{
	element = document.getElementById(element);
    }
    
    if (typeof(element) == "object") {
	element.style.display = 'none';
    }
}
function show_content(optionsId) {
	var ids = new Array('home','data','analysis');
	show(optionsId);
	document.getElementById(optionsId + '_link').className = 'active';
	for (var i = 0; i < ids.length; i++)
	{
	    if (ids[i] == optionsId) continue;
	    hide(ids[i]);
	    document.getElementById(ids[i] + '_link').className = '';
	}
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

		<div id="home">
			<h1 style = "text-align:center; font = montserrat-regular; color: #58687A">Content Analytics</h1>

			<p style = "text-align:center; width = 75px; color:lightgrey">
			Here will be content analysis.
			</p>

		</div>	

	<?php

include './functions.php';

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
?>
	
	</div>

	<div id="footer">Last update: </div>

</body>
</html>
<?php ?>