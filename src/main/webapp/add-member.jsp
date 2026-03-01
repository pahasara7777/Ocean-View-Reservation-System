<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security check: Only allow Admin or Manager to view this page
    String role = (String) session.getAttribute("loggedRole"); 
    if (role == null || (!role.equalsIgnoreCase("Manager") && !role.equalsIgnoreCase("Admin"))) {
        response.sendRedirect("dashboard.jsp"); 
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Staff - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .navbar-custom { background-color: #004d80; }
        .card { border-radius: 15px; border: none; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-5">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">
                <i class="bi bi-building"></i> Ocean View Resort
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow">
                    <div class="card-header bg-white text-center pt-4">
                        <i class="bi bi-person-plus-circle text-primary" style="font-size: 3rem;"></i>
                        <h4 class="fw-bold mt-2">Register Staff Member</h4>
                    </div>
                    <div class="card-body p-4">
                        
                        <%-- Success or Error Messages --%>
                        <% if(request.getParameter("error") != null) { %>
                            <div class="alert alert-danger"><%= request.getParameter("error") %></div>
                        <% } %>

                        <form action="AddMemberServlet" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <input type="text" name="username" class="form-control" placeholder="Enter username" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Initial Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-key"></i></span>
                                    <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">System Role</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                                    <select name="role" class="form-select" required>
                                        <option value="Receptionist">Receptionist</option>
                                        <option value="Manager">Manager</option>
                                        <option value="Admin">Admin</option>
                                    </select>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2 fw-bold" style="background-color: #004d80;">Create Account</button>
                            <a href="dashboard.jsp" class="btn btn-link w-100 mt-2 text-decoration-none text-muted">Cancel and Go Back</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>