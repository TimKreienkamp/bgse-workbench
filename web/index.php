<?php ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
	<title>MyApp</title>    
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/media-queries.css">
    <link rel="stylesheet" href="css/animate.css">
</head>

<header>

     <div id="header"><h1>Cross Validated Analytics</h1></div>

      <nav id="nav-wrap">         
         
         <a class="mobile-btn" href="#nav-wrap" title="Show navigation">Show Menu</a>
	      <a class="mobile-btn" href="#" title="Hide navigation">Hide Menu</a>         

         <ul id="nav" class="nav">
            <li><a id="home_link" href="#" class="active" onclick="show_content('home'); return false;">Home</a> </li>
	        <li><a id="data_link" href="#" onclick="show_content('data'); update_data_charts(); return false;">Data</a></li>
            <li><a id="analysis_link" href="#" onclick="show_content('analysis'); return false;">Analysis</a></li>
     
         </ul> <!-- end #nav -->

      </nav> <!-- end #nav-wrap -->

      
      </ul>

   </header> <!-- Header End -->
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
	<div id="header"><h1>Cross Validated Analytics</h1></div>

	<div id="main">


		<div id="home">
			<h2>   </h2>
			<p>
			This is the Project of Jordan McIver, Philipp Schmidt and Tim Kreienkamp.
			</p>
		</div>	

		<div id="data" style="display: none">
			<h2>Data</h2>
	                <?php include 'data.php' ?>
		</div>	

		<div id="analysis" style="display: none">
			<h2>Analysis</h2>
		</div>
	
	</div>

	<div id="footer">Last update: </div>

</body>
</html>
<?php ?>
