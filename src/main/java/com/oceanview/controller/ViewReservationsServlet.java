package com.oceanview.controller;

import com.oceanview.dao.ReservationDAOImpl;
import com.oceanview.model.Reservation;

// IMPORTANT: Change "javax" to "jakarta" if you are using Tomcat 10 or newer!
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller to fetch all reservations and forward them to the display view.
 */
@WebServlet("/ViewReservationsServlet")
public class ViewReservationsServlet extends HttpServlet {
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
        
        // 1. Security Check: Ensure the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=Unauthorized access. Please log in.");
            return;
        }

        // 2. Fetch all reservations from the database using the DAO
        List<Reservation> reservationsList = reservationDAO.findAll();

        // 3. Attach the list to the request object so the JSP can read it
        request.setAttribute("reservationsList", reservationsList);

        // 4. Forward the request and the data to the JSP page for rendering
        request.getRequestDispatcher("view-reservations.jsp").forward(request, response);
    }
}