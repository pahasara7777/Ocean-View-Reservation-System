<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp?error=Unauthorized access. Please log in.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Bill - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f4f7f6; }
        .navbar-custom { background-color: #004d80; }
        .search-card { max-width: 500px; margin: 50px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp"><i class="bi bi-building"></i> Ocean View Resort</a>
            <a class="btn btn-outline-light btn-sm" href="dashboard.jsp">Back to Dashboard</a>
        </div>
    </nav>

    <div class="container">
        <div class="search-card">
            <h4 class="fw-bold text-secondary text-center mb-4"><i class="bi bi-receipt"></i> Generate Guest Bill</h4>
            
            <% String error = request.getParameter("error"); if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <form action="PrintBillServlet" method="GET">
                <div class="mb-3">
                    <label for="reservationId" class="form-label fw-bold">Reservation ID (Booking Reference)</label>
                    <input type="number" class="form-control" id="reservationId" name="reservationId" placeholder="e.g., 1" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Retrieve Bill</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>