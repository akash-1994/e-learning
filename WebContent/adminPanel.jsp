<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html lang="en">
<!--setting data source-->
<sql:setDataSource var="dataSource" dataSource="jdbc/tutorial_learnit" />

<head>
<meta charset="UTF-8">
<title>Learn for free</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/styleAdmin.css">
<script src="js/prefixfree.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/myscript.js"></script>
<script src="js/clickAdmin.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"> Learn It </a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->

			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown "><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">
							Account <span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li class="dropdown-header">SETTINGS</li>
							<li><a href="logout.jsp">Logout <c:out
										value="${sessionScope['loginUser']}" />
							</a></li>
						</ul></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<div class="container-fluid main-container">
		<div class="col-md-2 sidebar">
			<ul class="nav nav-pills nav-stacked">
				<li class="active" id="home"><a href="#">Home</a></li>
				<li><a href="#" id="new-topic">Create new topic</a></li>
				<li><a href="#" id="edit-content">edit</a></li>
				<li><a href="#" id="delete-content-all">delete</a></li>
			</ul>
		</div>
		<div class="col-md-10 content">
			<div class="panel panel-default">
				<div class="panel-heading">Dashboard</div>

				<div class="margin">
					<div class="container-fluid">
						<div class="jumbotron" id="home-text">
							<p>Hello Admin , you can create new content here</p>
						</div>
						<div id="create-from-scratch">
							<form class="form-horizontal" id="new-topic-form" role="form"
								method="post" action="adminPanel.jsp?action=createContent">
								<div class="form-group">
									<label for="topic">Topic:</label> <input type="text"
										class="form-control" id="topic-name" name="tname">
								</div>
								<!-- form group create content (topic) -->
								<div class="form-group">
									<label for="topic">Tutorial number:</label> <input type="text"
										class="form-control" id="tut_no" name="tno">
								</div>
								<!-- form group create content (topic) -->
								<div class="form-group">
									<label for="subtopic">Sub-topic:</label> <input type="text"
										class="form-control" id="sub-topic-name" name="stname">
								</div>
								<!-- form group create content (sub-topic) -->
								<div class="form-group">
									<label for="content">Content:</label>
									<textarea class="form-control" rows="8" maxlength="1500"
										id="content" name="ctname"></textarea>
								</div>
								<p>
									<input type="submit" value="submit"
										class="btn btn-block btn-success" />
								</p>
							</form>
							<!-- main form create from scratch -->
						</div>
						<!-- toggle create from scratch  -->

						<c:if test="${pageContext.request.method=='POST'}">
							<c:catch var="exception">
								<c:if test="${param.action=='createContent' }">

									<sql:transaction dataSource="${dataSource}">
										<sql:update var="updatedTable1">                                
									
									INSERT INTO learnit_content (tutorial_content,tutorial_subheading,tutorial_name,tutorial_no) VALUES (?,?,?,?)   
                                    <sql:param value="${param.ctname}" />
											<sql:param value="${param.stname}" />
											<sql:param value="${param.tname}" />
											<sql:param value="${param.tno}" />

										</sql:update>

										<sql:update var="updatedTable2">
                                
									INSERT INTO tutorial_index(tutorial_name) VALUES (?)   
                                    <sql:param value="${param.tname}" />

										</sql:update>
									</sql:transaction>
									<c:if test="${updatedTable2>=1&&updatedTable1>=1}">
										<script>
											alert(" Congratulations ! Data inserted successfully.");
										</script>

									</c:if>

								</c:if>
								<c:if test="${param.action=='updateContent'}">
									<sql:transaction dataSource="${dataSource}">
										<sql:update var="updatedTable3">
                                
									UPDATE learnit_content SET tutorial_content= ? WHERE tutorial_subheading=?
									   
                                            <sql:param
												value="${param.UpdatedContent}" />
											<sql:param value="${param.selSubhead}" />
										</sql:update>
									</sql:transaction>
									<c:if test="${updatedTable3>=1}">
										<script>
											alert(" Congratulations ! Data updated successfully.");
										</script>

									</c:if>

								</c:if>
								<c:if test="${param.action=='delete' }">
									<sql:query dataSource="${dataSource}" var="result2">
						         DELETE FROM learnit_content
                                 WHERE tutorial_subheading=?;
                                 <sql:param	value="${param.delSubTopicName}" />

									</sql:query>
								</c:if>
							</c:catch>
							<c:if test="${exception!=null}">
								<script>
									alert("Data could not be inserted.");
								</script>
							</c:if>
						</c:if>
						<sql:query dataSource="${dataSource}" var="result1">             
                        SELECT DISTINCT  tutorial_name
                        FROM  learnit_content 
						</sql:query>

						<div id="delete-data">
							<form class="form-horizontal" id="delete-form" role="form"
								method="post" action="adminPanel.jsp?action=delete">
								<div class="form-group">
									<label for="sel1">Select Topic:</label> <select
										class="form-control" id="delTopicName">
										<option>Topic Name</option>
										<c:forEach var="rows" items="${result1.rows}">
											<option><c:out value="${rows.tutorial_name}"></c:out></option>
										</c:forEach>

									</select>
								</div>
								<!-- form group create content (topic) -->
								<div class="form-group">
									<label for="subtopic">Sub-topic:</label> <select
										class="form-control" id="delSubTopicName" name="delSubHead">
									</select>
								</div>
								<!-- form group create content (sub-topic) -->
								<div class="form-group">
									<input type="submit" value="Delete" class="btn  btn-warning" />
								</div>
							</form>
							<!-- main form delete sub topic -->
						</div>
						<sql:query dataSource="${dataSource}" var="result1">             
                        SELECT DISTINCT  tutorial_name
                        FROM  learnit_content 
						</sql:query>
						<!-- create subtopic toggle div -->
						<div id="edit-all">
							<form class="form-horizontal" id="edit-content-form" role="form"
								method="post" action="adminPanel.jsp?action=updateContent">
								<div class="form-group">
									<label for="sel1">Select list:</label> <select
										class="form-control" id="selTopicname">
										<option>Topic Name</option>
										<c:forEach var="rows" items="${result1.rows}">
											<option><c:out value="${rows.tutorial_name}"></c:out></option>
										</c:forEach>
									</select>
								</div>
								<!-- form group create content (topic) -->
								<div class="form-group">
									<label for="sel1">Select list:</label> <select
										class="form-control" id="selSubheading" name="selSubhead"><option>Subheading</option>

									</select>
								</div>
								<!-- form group create content (sub-topic) -->
								<div class="form-group">
									<label for="content">Content:</label>
									<textarea class="form-control" rows="8" maxlength="1500"
										id="contentEdit" name="UpdatedContent"></textarea>
								</div>
								<p>
									<input type="submit" value="Update" class="btn  btn-info" />

								</p>
							</form>
							<!-- main form edit -->
						</div>
						<!-- toggle edit div -->
					</div>
					<!-- container-fluid -->
				</div>
				<!-- margin   -->
			</div>
			<!-- panel default -->
		</div>
		<!--column 10-->
	</div>
	<!-- container fluid -->



	<footer class="pull-left footer">
		<hr class="divider">
		<p class="col-md-12">
			Copyright &COPY; 2015 <a href="#">NTPC</a>
		</p>
	</footer>
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp" />
	</c:if>


</body>
</html>