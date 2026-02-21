<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SECURE SYSTEM ACCESS: Kick out unauthenticated users
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp?error=Unauthorized access. Please log in first.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Reservation - Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #f4f7f6; }
        .navbar-custom { background-color: #004d80; }
        .form-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            padding: 30px;
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
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card">
                    <h3 class="fw-bold text-secondary border-bottom pb-2 mb-4">
                        <i class="bi bi-person-plus-fill"></i> Guest Registration & Booking
                    </h3>
                    
                    <form action="AddReservationServlet" method="POST">
                        
                        <h5 class="text-primary mb-3">1. Guest Details</h5>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="fullName" class="form-label fw-bold">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="contactNumber" class="form-label fw-bold">Contact Number</label>
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
                            </div>
                            <div class="col-12">
                                <label for="address" class="form-label fw-bold">Home Address</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                        </div>

                        <h5 class="text-primary mb-3">2. Reservation Details</h5>
                        <div class="row g-3 mb-4">
                            <div class="col-md-12">
                                <label for="roomId" class="form-label fw-bold">Room Type</label>
                                <select class="form-select" id="roomId" name="roomId" required>
                                    <option value="" selected disabled>Select a room type...</option>
                                    <option value="1">Standard Single (LKR 5,000/night)</option>
                                    <option value="2">Standard Double (LKR 7,500/night)</option>
                                    <option value="3">Deluxe Ocean View (LKR 12,000/night)</option>
                                    <option value="4">Presidential Suite (LKR 25,000/night)</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="checkInDate" class="form-label fw-bold">Check-In Date</label>
                                <input type="date" class="form-control" id="checkInDate" name="checkInDate" required>
                            </div>
                            <div class="col-md-6">
                                <label for="checkOutDate" class="form-label fw-bold">Check-Out Date</label>
                                <input type="date" class="form-control" id="checkOutDate" name="checkOutDate" required>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <button type="reset" class="btn btn-secondary me-md-2">Clear Form</button>
                            <button type="submit" class="btn btn-primary px-4">Confirm Reservation</button>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>