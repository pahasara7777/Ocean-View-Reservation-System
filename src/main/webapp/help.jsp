<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SECURE SYSTEM ACCESS: Ensure only authenticated staff can view internal guidelines
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
    <title>Staff Help Center - Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar-custom { background-color: #004d80; }
        .help-container {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-top: 30px;
            margin-bottom: 50px;
        }
        .accordion-button:not(.collapsed) {
            background-color: #e6f2ff;
            color: #004d80;
            font-weight: bold;
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

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="help-container">
                    <h2 class="fw-bold text-secondary border-bottom pb-3 mb-4">
                        <i class="bi bi-question-circle-fill text-primary"></i> System User Guide
                    </h2>
                    <p class="text-muted mb-4">Welcome to the Ocean View Resort Reservation System. Please review the guidelines below to familiarize yourself with the daily operations.</p>

                    <div class="accordion" id="helpAccordion">
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    1. How to Add a New Reservation
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    <strong>Registering a new guest:</strong> Navigate to the <em>"New Reservation"</em> page from the dashboard. You must fill in the guest's full name, contact number, and address. Then, select the room type and input the exact Check-In and Check-Out dates. The system will automatically calculate the total stay cost and assign a unique booking reference number.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    2. Viewing Existing Reservations
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    Click on <em>"View Reservations"</em> from the main dashboard. This will load a data table displaying all current bookings in the database, including the Guest ID, Room ID, dates, and total calculated cost. Use this page to verify guest details if they call to confirm their booking.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    3. Generating a Bill at Check-Out
                                </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    When a guest is ready to check out, navigate to <em>"Calculate Bill"</em>. You will need to ask the guest for their <strong>Reservation ID</strong> (Booking Reference). Enter this number into the search field to generate their final invoice. You can then use the "Print Invoice" button to provide them with a physical receipt.
                                </div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingFour">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                    4. Security & System Logout
                                </button>
                            </h2>
                            <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    Always protect guest data. If you are stepping away from the front desk, you must click the <strong>Logout</strong> button located in the top right corner of the navigation bar. This ensures unauthorized individuals cannot access the resort's database.
                                </div>
                            </div>
                        </div>

                    </div>
                    </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>