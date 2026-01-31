<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Admin or Agent</title>
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
        input, select, button {
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
    <h2>Add Admin or Agent</h2>

    <!-- ADD USER FORM -->
    <form action="/admin/add-user" method="post">

        <input
            type="text"
            name="username"
            placeholder="Username"
            required
        />

        <input
            type="password"
            name="password"
            placeholder="Password"
            required
        />

        <select name="roleId" required>
            <option value="">Select Role</option>
            <option value="2">ADMIN</option>
            <option value="3">AGENT</option>
        </select>

        <button type="submit">Create User</button>
    </form>

    <!-- FEEDBACK MESSAGES -->
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
