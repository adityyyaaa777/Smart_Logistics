<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Admins</title>
</head>
<body>

<h2>All Admins</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Username</th>
    </tr>

    <c:forEach var="admin" items="${admins}">
        <tr>
            <td>${admin.userId}</td>
            <td>${admin.username}</td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="/admin/dashboard">Back to Dashboard</a>

</body>
</html>
