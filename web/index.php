<?php ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
	<title>CrossValidated Project</title> 
	<link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

</script>
<body style = "background:#23292f">
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

   

   </header> <!-- Header End -->

	

	<div id="main" style = "background:#23292f">

			<p> </br> </p>

			<h1 style = "text-align:center; font = montserrat-regular; color: white">Computing Lab / Data Warehouse Project</h1>
			<h5 style = "text-align:center; font = montserrat-regular; color: white">J. McIver, Philipp Schmidt, T.Kreienkamp</h5>
			<br>

<br>
<h2 style = "text-align:center; color:white;">Project Aim </h4>
<br>
<p style = "color:white;">Aim of the project is to construct a statistical web service for the open Q&A site Cross Validated.  The focus lies on creating a database, finding insights within the database and to construct a predictive model based on the data.  The results are presented in a dashboard that provides an immediate overview of the key performance indicators as well as the predictive model.</p>
<br>
<h2 style = "text-align:center; color:white;">Cross Validated</h4>
<br>
<p style = "color:white">Cross validated is a spin-off from the Q&A site Stackexchange (most commonly known for their programmer Q&A stackoverflow) which provides a crowd-based information exchange dedicated to statistics and the corresponding programming problems. The user can post questions, comment and answer posts and vote on other users posts. Users earn a reputation by receiving up and down votes or by earning badges, which are awarded by the site for certain activities.</p>
<br>
<h2 style = "color:white; text-align:center">Database & Predictive analysis</h4>
<br>
<p style = "color:white;">The data has been obtained through the <a href = "http://api.stackexchange.com"> stackexchange open API</a> . Tables that have been used in this project are listed here: Badges, Comments, Posthistory, Postlinks, Posts, Tags and Votes. </p>
<br>
<p style = "color:white;"> The analytical part of this project aims to predict whether posts/questions will receive an accepted answer given various features of the post. The results of this analysis aim to provide a measurement of the sites performance and indicate possible improvements.</p>

			


</body>
</html>
<?php ?>
