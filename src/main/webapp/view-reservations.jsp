<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    // SECURE SYSTEM ACCESS: Kick out unauthenticated users
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp?error=Unauthorized access. Please log in first.");
        return;
    }
    
    // Retrieve the list of reservations sent over by the Servlet
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservationsList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reservations - Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #f4f7f6; }
        .navbar-custom { background-color: #004d80; }
        .table-container {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">
                <i class="bi bi-building"></i> Ocean View Resort
            </a>
            <div class="d-flex">
                <a class="btn btn-outline-light btn-sm me-2" href="dashboard.jsp">Back to Dashboard</a>
                <a class="btn btn-outline-light btn-sm" href="LogoutServlet">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <h3 class="fw-bold text-secondary mt-4 mb-3">
            <i class="bi bi-card-list"></i> Current Reservations
        </h3>
        
        <div class="table-container table-responsive">
            <table class="table table-hover table-bordered align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Booking Ref</th>
                        <th>Guest ID</th>
                        <th>Room ID</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Total Cost</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody class="text-center">
                    <% 
                        // Check if the list has data, then loop through it
                        if (reservations != null && !reservations.isEmpty()) {
                            for (Reservation res : reservations) { 
                    %>
                        <tr>
                            <td><span class="badge bg-secondary">#<%= res.getReservationId() %></span></td>
                            <td><%= res.getGuestId() %></td>
                            <td><%= res.getRoomId() %></td>
                            <td><%= res.getCheckInDate() %></td>
                            <td><%= res.getCheckOutDate() %></td>
                            <td class="fw-bold text-success">LKR <%= String.format("%,.2f", res.getTotalCost()) %></td>
                            <td><span class="badge bg-info text-dark"><%= res.getStatus() %></span></td>
                        </tr>
                    <% 
                            } 
                        } else { 
                    %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                <em>No reservations found in the system.</em>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>