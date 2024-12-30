<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login and Registration</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body>
			<div class="text-center">
				<h1 class="purple">Book Club</h1>
				<p>A place for friends to share thoughts on books.</p>
			</div>
			<div id="forms" class="d-flex justify-content-evenly">
				<form:form class="small-form" modelAttribute="newUser" method="post" action="/register" >
					<h2>Register</h2>	
					<span class="text-danger"><form:errors path="username" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="username">User Name: </form:label>
						<form:input path="username" />
					</div>	
					<span class="text-danger"><form:errors path="email" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="email">Email: </form:label>
						<form:input path="email" />
					</div>	
					<span class="text-danger"><form:errors path="password" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="password">Password: </form:label>
						<form:input path="password" />
					</div>	
					<span class="text-danger"><form:errors path="confirm" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="confirm">Confirm Password: </form:label>
						<form:input path="confirm" />
					</div>
					<button class="btn btn-primary float-end" type="submit">Submit</button>
				</form:form>
				
				<form:form class="small-form" modelAttribute="newLogin" method="post" action="/login">
					<h2>Login</h2>
					<span class="text-danger"><form:errors path="email" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="email">Email: </form:label>
						<form:input path="email" />
					</div>	
					<span class="text-danger"><form:errors path="password" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="password">Password: </form:label>
						<form:input path="password" />
					</div>
					<button class="btn btn-primary float-end" type="submit">Submit</button>
				</form:form>
			</div>
	</body>
</html>