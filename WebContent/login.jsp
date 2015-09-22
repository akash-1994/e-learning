<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s"%>
<!DOCTYPE html>
<html>
<s:setDataSource var="dataSource" dataSource="jdbc/tutorial_learnit" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login to our app</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/login.css">

</head>
<body>
	<div class="container-fluid">
		<h1>Please login</h1>





		<form action="login.jsp" method="post" class="form-horizontal">
			<div class="form-group">
				<label for="topic">Username:</label> <input type="text"
					class="form-control" id="topic-name" name="username">
			</div>
			<!-- form group create content (topic) -->
			<div class="form-group">
				<label for="topic">password</label> <input type="text"
					class="form-control" id="tut_no" name="password">
			</div>
			<!-- form group create content (topic) -->
			<div class="form-group">
				<p>
					<input type="submit" value="submit"
						class="btn btn-block btn-success" />
				</p>
			</div>
			<div class="form-group">
				<p>
					<a href="index.jsp">return to site</a>
				</p>
			</div>
			<font color="red"><c:if test="${not empty param.errMsg}">
					<c:out value="${param.errMsg}" />
				</c:if></font>
		</form>
	</div>
</body>
<c:if test="${pageContext.request.method=='POST'}">
	<c:if test="${ empty param.username or empty param.password}">
		<c:redirect url="login.jsp">
			<c:param name="errMsg" value="Please Enter UserName and Password" />
		</c:redirect>

	</c:if>

	<c:if test="${not empty param.username and not empty param.password}">


		<s:query dataSource="${dataSource}" var="selectQ">
        select count(*) as kount from admin
        where idadmin='${param.username}'
        and adminpass='${param.password}'
      </s:query>

		<c:forEach items="${selectQ.rows}" var="r">
			<c:choose>
				<c:when test="${r.kount gt 0}">
					<c:set scope="session" var="loginUser" value="${param.username}" />
					<c:redirect url="adminPanel.jsp" />
				</c:when>
				<c:otherwise>
					<c:redirect url="login.jsp">
						<c:param name="errMsg" value="Username/password does not match" />
					</c:redirect>
				</c:otherwise>
			</c:choose>

		</c:forEach>

	</c:if>

</c:if>

</html>


