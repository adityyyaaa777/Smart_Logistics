<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Agents</title>
</head>
<body>

<h2>All Agents</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Username</th>
    </tr>

    <c:forEach var="agent" items="${agents}">
        <tr>
            <td>${agent.userId}</td>
            <td>${agent.username}</td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="/admin/dashboard">Back to Dashboard</a>

</body>
</html>
