package com.oceanview.controller;

import com.oceanview.dao.UserDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddMemberServlet")
public class AddMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the data typed into the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // 2. Send it to the database
        UserDAOImpl userDAO = new UserDAOImpl();
        boolean isAdded = userDAO.addMember(username, password, role);

        // 3. Redirect based on success or failure
        if (isAdded) {
            // Success! Send them back to the dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // Failed! Send them back to the form with an error
            response.sendRedirect("add-member.jsp?error=Failed to add staff. Username might already exist.");
        }
    }
}