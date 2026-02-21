<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SECURE SYSTEM ACCESS: Check if the user is actually logged in.
    // If the session attribute is null, redirect them back to the login page.
    String username = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("userRole");
    
    if (username == null) {
        response.sendRedirect("login.jsp?error=Unauthorized access. Please log in first.");
        return; // Stop processing the rest of the page
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body {
            background-color: #f4f7f6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-custom {
            background-color: #004d80;
        }
        .dashboard-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
            padding: 20px;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
            color: #004d80;
        }
        .card-icon {
            font-size: 3rem;
            color: #004d80;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-5">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">
                <i class="bi bi-building"></i> Ocean View Resort
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item me-3 text-light">
                        Welcome, <strong><%= username %></strong> (<%= role %>)
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-light btn-sm" href="LogoutServlet">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="fw-bold text-secondary">Staff Dashboard</h2>
                <p class="text-muted">Select an action below to manage resort operations.</p>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <a href="add-reservation.jsp" class="dashboard-card bg-white h-100">
                    <i class="bi bi-calendar-plus card-icon"></i>
                    <h5 class="fw-bold">New Reservation</h5>
                    <p class="text-muted small">Register a new guest and book a room.</p>
                </a>
            </div>

            <div class="col-md-4">
                <a href="ViewReservationsServlet" class="dashboard-card bg-white h-100">
                    <i class="bi bi-card-list card-icon"></i>
                    <h5 class="fw-bold">View Reservations</h5>
                    <p class="text-muted small">Search and display existing booking details.</p>
                </a>
            </div>

            <div class="col-md-4">
                <a href="billing.jsp" class="dashboard-card bg-white h-100">
                    <i class="bi bi-receipt card-icon"></i>
                    <h5 class="fw-bold">Calculate Bill</h5>
                    <p class="text-muted small">Compute total stay costs for check-outs.</p>
                </a>
            </div>

            <div class="col-md-4">
                <a href="help.jsp" class="dashboard-card bg-white h-100">
                    <i class="bi bi-question-circle card-icon"></i>
                    <h5 class="fw-bold">Help Section</h5>
                    <p class="text-muted small">View system guidelines for new staff members.</p>
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>