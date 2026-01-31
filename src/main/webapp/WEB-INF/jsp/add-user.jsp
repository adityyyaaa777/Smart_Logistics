<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${role == 'ADMIN'}">Add Admin</c:when>
            <c:otherwise>Add Agent</c:otherwise>
        </c:choose>
    </title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }
        .container {
            width: 400px;
            margin: 60px auto;
            background: white;
            padding: 20px;
            border-radius: 6px;
        }
        input, button {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .msg-success { color: green; }
        .msg-error { color: red; }
    </style>
</head>

<body>

<div class="container">

    <h2>
        <c:choose>
            <c:when test="${role == 'ADMIN'}">Add Admin</c:when>
            <c:otherwise>Add Agent</c:otherwise>
        </c:choose>
    </h2>

    <form action="/admin/add-user" method="post">

        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />

        <!-- ROLE COMES FROM DASHBOARD -->
        <input type="hidden" name="role" value="${role}" />

        <button type="submit">
            <c:choose>
                <c:when test="${role == 'ADMIN'}">Create Admin</c:when>
                <c:otherwise>Create Agent</c:otherwise>
            </c:choose>
        </button>
    </form>

    <c:if test="${not empty success}">
        <p class="msg-success">${success}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p class="msg-error">${error}</p>
    </c:if>

    <br/>
    <a href="/admin/dashboard">← Back to Dashboard</a>
</div>

</body>
</html>
