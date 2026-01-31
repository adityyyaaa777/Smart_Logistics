<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h2>Admins and Agents</h2>

<table border="1" cellpadding="10">
    <tr>
        <th>User ID</th>
        <th>Username</th>
        <th>Role</th>
    </tr>

    <c:forEach var="u" items="${users}">
        <tr>
            <td>${u.userId}</td>
            <td>${u.username}</td>

            <td>
                <c:choose>
                    <c:when test="${u.roleId == 2}">ADMIN</c:when>
                    <c:when test="${u.roleId == 3}">AGENT</c:when>
                    <c:when test="${u.roleId == 0}">SUPER ADMIN</c:when>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
