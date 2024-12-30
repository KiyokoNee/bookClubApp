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
		<title>Book Details</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body class="centered-content">
		<div>
			<h1><c:out value="${book.title}"></c:out></h1>
			<a href="/books">Back to the Shelves</a>
		</div>
		<p><span class="text-danger"><c:out value="${reader}"></c:out></span> read 
			<span class="purple"><c:out value="${book.title}"></c:out></span> by 
			<span class="text-success"><c:out value="${book.author}"></c:out></span></p>
		<p>Here are ${thinker} thoughts:</p>
		
		<hr>
		
		<blockquote class="blockquote">
			<em><c:out value="${book.thoughts}"></c:out></em>
		</blockquote>
		
		<hr>
		<c:if test="${isUser}">
			<div>
				<form:form action="/books/${book.id}/edit" method="get">
					<button>Edit</button>
				</form:form>
				<form:form action="/books/${book.id}/delete" method="delete">
					<button>Delete</button>
				</form:form>
			</div>
		</c:if>
	</body>
</html>