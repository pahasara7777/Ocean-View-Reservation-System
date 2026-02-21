<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp"); return;
    }
    Reservation bill = (Reservation) request.getAttribute("billData");
    if (bill == null) {
        response.sendRedirect("billing.jsp"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice #<%= bill.getReservationId() %> - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #eee; padding-top: 20px; }
        .invoice-card { background: #fff; max-width: 800px; margin: 0 auto; padding: 40px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .invoice-title { color: #004d80; font-weight: bold; }
        /* Hide buttons when printing */
        @media print {
            .no-print { display: none !important; }
            body { background-color: #fff; padding-top: 0; }
            .invoice-card { box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body>

    <div class="container invoice-card">
        <div class="row border-bottom pb-3 mb-4">
            <div class="col-sm-6">
                <h2 class="invoice-title">Ocean View Resort</h2>
                <p class="text-muted mb-0">123 Beachside Avenue, Galle, Sri Lanka</p>
                <p class="text-muted">Phone: +94 91 123 4567</p>
            </div>
            <div class="col-sm-6 text-end">
                <h1 class="text-secondary mb-0">INVOICE</h1>
                <p class="fw-bold mb-0">Booking Ref: #<%= bill.getReservationId() %></p>
                <p class="text-muted">Date: <%= java.time.LocalDate.now() %></p>
            </div>
        </div>

        <div class="row mb-5">
            <div class="col-sm-12">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Guest ID</th>
                            <th>Room ID</th>
                            <th>Check-In Date</th>
                            <th>Check-Out Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= bill.getGuestId() %></td>
                            <td><%= bill.getRoomId() %></td>
                            <td><%= bill.getCheckInDate() %></td>
                            <td><%= bill.getCheckOutDate() %></td>
                            <td><%= bill.getStatus() %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6 offset-sm-6">
                <table class="table table-borderless">
                    <tr class="border-top border-bottom border-2">
                        <td class="fw-bold fs-5 text-end">Total Amount Due:</td>
                        <td class="fw-bold fs-5 text-success text-end">LKR <%= String.format("%,.2f", bill.getTotalCost()) %></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row text-center mt-5 no-print">
            <div class="col-12">
                <button onclick="window.print()" class="btn btn-primary btn-lg me-2">Print Invoice</button>
                <a href="dashboard.jsp" class="btn btn-secondary btn-lg">Return to Dashboard</a>
            </div>
        </div>
        
        <div class="text-center mt-5 pt-4 border-top">
            <p class="text-muted fst-italic">Thank you for staying at Ocean View Resort. We hope to see you again soon!</p>
        </div>
    </div>

</body>
</html>