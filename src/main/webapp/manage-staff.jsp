<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.User" %>
<%
    // Security check: Only allow Admin or Manager
    String role = (String) session.getAttribute("loggedRole"); 
    if (role == null || (!role.equalsIgnoreCase("Manager") && !role.equalsIgnoreCase("Admin"))) {
        response.sendRedirect("dashboard.jsp"); 
        return;
    }

    // Grab the list of staff sent by our ManageStaffServlet
    List<User> staffList = (List<User>) request.getAttribute("staffList");
    
    // If the list is missing (someone typed the URL directly), bounce them to the Servlet
    if (staffList == null) {
        response.sendRedirect("ManageStaffServlet");
        return;
    }
    
    String loggedUser = (String) session.getAttribute("loggedUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Staff - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .navbar-custom { background-color: #004d80; }
        .table-hover tbody tr:hover { background-color: #f1f8ff; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-5">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">
                <i class="bi bi-building"></i> Ocean View Resort
            </a>
            <div class="d-flex">
                <span class="navbar-text me-3 text-white">Logged in as: <strong><%= loggedUser %></strong></span>
                <a class="btn btn-outline-light btn-sm" href="dashboard.jsp">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row mb-3">
            <div class="col-md-8">
                <h3 class="fw-bold text-secondary"><i class="bi bi-people-fill"></i> Staff Directory</h3>
                <p class="text-muted">View all active accounts or remove unauthorized users.</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="add-member.jsp" class="btn btn-success"><i class="bi bi-person-plus"></i> Add New Staff</a>
            </div>
        </div>

        <%-- Display Success or Error Messages --%>
        <% if(request.getParameter("message") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> <%= request.getParameter("message") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Username</th>
                            <th>System Role</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(User staffMember : staffList) { %>
                            <tr>
                                <td class="ps-4 align-middle fw-bold"><%= staffMember.getUsername() %></td>
                                <td class="align-middle">
                                    <%-- Highlight Managers/Admins in Blue, regular staff in Gray --%>
                                    <% if(staffMember.getRole().equalsIgnoreCase("Manager") || staffMember.getRole().equalsIgnoreCase("Admin")) { %>
                                        <span class="badge bg-primary"><%= staffMember.getRole() %></span>
                                    <% } else { %>
                                        <span class="badge bg-secondary"><%= staffMember.getRole() %></span>
                                    <% } %>
                                </td>
                                <td class="text-end pe-4 align-middle">
                                    
                                    <%-- Prevent the logged-in user from deleting themselves --%>
                                    <% if(staffMember.getUsername().equals(loggedUser)) { %>
                                        <button class="btn btn-sm btn-outline-secondary" disabled>Current Session</button>
                                    <% } else { %>
                                        
                                        <%-- Secure Delete Button Form --%>
                                        <form action="ManageStaffServlet" method="post" class="d-inline" 
                                              onsubmit="return confirm('ETHICAL IT WARNING:\nAre you sure you want to permanently delete the account for <%= staffMember.getUsername() %>?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="username" value="<%= staffMember.getUsername() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </form>

                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>