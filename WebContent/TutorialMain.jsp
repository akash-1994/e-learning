<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<!--setting data source-->
<sql:setDataSource var="dataSource" dataSource="jdbc/tutorial_learnit" />

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/w3.css">
<link rel="stylesheet" href="css/w3-theme-red.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style>
h1 {
	font-size: 64px;
}

nav h2 {
	font-size: 20px;
	padding-left: 16px;
}

nav li {
	padding-top: 3px;
	padding-bottom: 3px;
	margin-Left: 15px;
	list-style-type: none;
}

nav li:hover {
	background-color: #f2f2f2;
}
</style>
<title>Learn It tutorial Page</title>
<script src="js/prefixfree.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/clickInit.js"></script>
<script src="jspdf/jspdf.js"></script>
<script src="libs/adler32cs.js/adler32cs.js"></script>
<script src="libs/FileSaver.js/FileSaver.js"></script>
<script src="libs/Blob.js/Blob.js"></script>
<script src="jspdf/addimage.js"></script>
<script src="jspdf/standard_fonts_metrics.js"></script>
<script src="jspdf/split_text_to_size.js"></script>
<script src="jspdf/from_html.js"></script>




</head>

<body>
	<nav class="w3-sidenav w3-card-2 w3-animate-left"
		style="display: none; width: 25%;">
		<a href="javascript:void(0)" onclick="w3_close()"
			class="w3-closebtn w3-large">X</a> <br>
		<sql:query dataSource="${dataSource}" var="result1">             
               SELECT DISTINCT  tutorial_name
               FROM  tutorial_index  WHERE tutorial_name =(?)
             <sql:param value="${param.name}" />

		</sql:query>
		<sql:query dataSource="${dataSource}" var="result2">             
             SELECT tutorial_subheading  FROM learnit_content WHERE tutorial_name=(?) ORDER BY tutorial_no   
              <sql:param value="${param.name}" />
		</sql:query>
		<c:forEach var="rows" items="${result1.rows}">
			<h2 class="w3-text-theme">
				<c:out value="${rows.tutorial_name}"></c:out>
			</h2>
			<ul id="listSubheadings">
				<c:forEach var="rows" items="${result2.rows}">

					<li class="headingName"><c:out
							value="${rows.tutorial_subheading}"></c:out></li>
				</c:forEach>
			</ul>
		</c:forEach>
	</nav>

	<sql:query dataSource="${dataSource}" var="result3">             
             SELECT tutorial_subheading ,tutorial_content FROM learnit_content WHERE tutorial_name=(?) AND tutorial_no=1   
              <sql:param value="${param.name}" />
	</sql:query>

	<div id="main">
		<header class="w3-container w3-theme w3-card-2"
			style="margin-left: 0%; transition: 0.6s; -webkit-transition: 0.6s;">
			<i onclick="w3_open()" class="material-icons w3-opennav"
				style="visibility: visible;">menu</i>
			<h1>Learn It</h1>
			<nav class="w3-topnav w3-theme">
				<a href="index.jsp">Home</a> <a href="TutorialMain.jsp?name=HTML">HTML</a>
				<a href="TutorialMain.jsp?name=CSS">CSS</a> <a href="TutorialMain.jsp?name=javascript">JavaScript</a>
				
			</nav>
		</header>
		<br>
		<div class="w3-container w3-row" id="mainContent">
		<c:forEach var="rows" items="${result3.rows}">
		<h1><c:out value="${rows.tutorial_subheading}"></c:out></h1>
		
		<p><c:out value="${rows.tutorial_content}"></c:out></p>
		</c:forEach>
		</div>
		<p><button class="w3-btn w3-orange w3-large" onclick="demoFromHTML();">Save as PDF<i class="w3-margin-left w3-right fa fa-cloud"></i></button>
		<p>
	</div>

	<script type="text/javascript">
		function w3_open() {
			document.getElementById("main").style.marginLeft = "25%"
			document.getElementsByClassName("w3-sidenav")[0].style.width = "25%";
			document.getElementById("main").style.transition = ".6s";
			document.getElementsByClassName("w3-sidenav")[0].style.transition = "2s";
			document.getElementsByClassName("w3-sidenav")[0].style.display = "block";
			document.getElementsByClassName("w3-opennav")[0].style.visibility = 'hidden';
		}

		function w3_close() {
			document.getElementById("main").style.marginLeft = "0%";
			document.getElementsByClassName("w3-sidenav")[0].style.display = "none";
			document.getElementsByClassName("w3-opennav")[0].style.visibility = "visible";
		}

		function demoFromHTML() {
			var pdf = new jsPDF('p', 'pt', 'letter')

			// source can be HTML-formatted string, or a reference
			// to an actual DOM element from which the text will be scraped.
			, source = $('#mainContent')[0]

			// we support special element handlers. Register them with jQuery-style
			// ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
			// There is no support for any other type of selectors
			// (class, of compound) at this time.
			, specialElementHandlers = {
				// element with id of "bypass" - jQuery style selector
				'#bypassme' : function(element, renderer) {
					// true = "handled elsewhere, bypass text extraction"
					return true
				}
			}

			margins = {
				top : 80,
				bottom : 60,
				left : 5,
				width : 522
			};
			// all coords and widths are in jsPDF instance's declared units
			// 'inches' in this case
			pdf.fromHTML(source // HTML string or DOM elem ref.
			, margins.left // x coord
			, margins.top // y coord
			, {
				'width' : margins.width // max width of content on PDF
				,
				'elementHandlers' : specialElementHandlers
			}, function(dispose) {
				// dispose: object with X, Y of the last line add to the PDF
				//          this allow the insertion of new lines after html
				pdf.save('Tutorial.pdf');
			}, margins)
		}
	</script>

</body>

</html>
