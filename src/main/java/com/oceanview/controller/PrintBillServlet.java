package com.oceanview.controller;

import com.oceanview.dao.ReservationDAOImpl;
import com.oceanview.model.Reservation;

// IMPORTANT: Change "javax" to "jakarta" if you are using Tomcat 10+
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

/**
 * Controller to handle retrieving reservation details for billing and check-out.
 */
@WebServlet("/PrintBillServlet")
public class PrintBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAOImpl reservationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        reservationDAO = new ReservationDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            
            Optional<Reservation> reservation = reservationDAO.findById(reservationId);
            
            if (reservation.isPresent()) {
                request.setAttribute("billData", reservation.get());
                request.getRequestDispatcher("bill-receipt.jsp").forward(request, response);
            } else {
                response.sendRedirect("billing.jsp?error=Reservation not found. Please check the ID.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("billing.jsp?error=Invalid Reservation ID format.");
        }
    }
}