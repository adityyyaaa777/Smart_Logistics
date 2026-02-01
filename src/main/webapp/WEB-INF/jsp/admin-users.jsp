<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser || sessionScope.loggedUser.roleId != 2}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Admins and Agents</title>
    <link rel="stylesheet" href="/assets/css/dashboard.css">
</head>

<body>

<!-- Background -->
<div class="animated-gradient"></div>
<div class="blob blob--one"></div>
<div class="blob blob--two"></div>

<svg class="curved-lines" viewBox="0 0 1200 800" preserveAspectRatio="none">
    <path d="M0,200 C300,100 600,300 1200,150" />
    <path d="M0,400 C400,250 800,450 1200,300" />
    <path d="M0,600 C350,500 750,650 1200,520" />
</svg>

<div class="page-wrapper">

    <!-- Header -->
    <header class="header glass-card">
        <span class="app-name">Smart Logistics</span>
        <div>
            <span class="user-name">${sessionScope.customerName}</span>
            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <div class="body-wrapper">

        <!-- Sidebar -->
        <aside class="sidebar glass-card">
            <nav class="nav-menu">
                <a href="/admin/dashboard" class="nav-item">Dashboard</a>
                <a href="/admin/add-user" class="nav-item">Add User</a>
                <a href="/admin/users" class="nav-item">Users</a>
                <a href="/admin/orders" class="nav-item">Orders</a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">

            <div class="panel">
                <h2>Admins and Agents</h2>

                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Username</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.username}</td>
                                <td>${user.role}</td>
                                <td>
                                    <a href="/admin/delete-user?id=${user.userId}" 
                                       class="danger-btn">
                                        Remove
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>

        </main>
    </div>
</div>

</body>
</html>
