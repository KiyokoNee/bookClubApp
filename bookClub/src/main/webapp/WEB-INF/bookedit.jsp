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
		<title>New Book</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body class="centered-content">
		<div class="d-flex justify-content-between">
			<h1>Change Your Entry!</h1>
			<a href="/books">Back to the Shelves</a>
		</div>
		<form:form class="full-form" modelAttribute="book" method="post" action="/books/${book.id}" >
			<h2>Register</h2>
			<input type="hidden" name="_method" value="put" />
			<input type="hidden" name="user" value="${book.user.id}" />
			<span class="text-danger"><form:errors path="title" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="title">Title: </form:label>
				<form:input path="title" />
			</div>	
			<span class="text-danger"><form:errors path="author" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="author">Author: </form:label>
				<form:input path="author" />
			</div>	
			<span class="text-danger"><form:errors path="thoughts" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="thoughts">Thoughts: </form:label>
				<form:input path="thoughts" />
			</div>
			<button class="btn btn-primary float-end" type="submit">Submit</button>
		</form:form>
	</body>
</html>