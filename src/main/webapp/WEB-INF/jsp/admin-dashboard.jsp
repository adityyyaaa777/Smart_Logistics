<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser || sessionScope.loggedUser.roleId != 0}">
    <c:redirect url="/login"/>
</c:if>

<h2>Welcome, ${adminName}</h2>

<ul>
    <li><a href="/admin/add-user">Add Admin or Agent</a></li>
    <li><a href="/admin/users">View Admins and Agents</a></li>
    <li><a href="/admin/orders">Manage Orders</a></li>
    <li><a href="/logout">Logout</a></li>
</ul>
