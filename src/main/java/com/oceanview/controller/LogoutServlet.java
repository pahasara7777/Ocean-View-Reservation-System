package com.oceanview.controller;

// IMPORTANT: Change "javax" to "jakarta" if you are using Tomcat 10+
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller to handle secure staff logout and session termination.
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Fetch the current session, but don't create a new one if it doesn't exist
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Invalidate the session, clearing all stored user data
            session.invalidate();
        }
        
        // Redirect back to the login page with a success message
        response.sendRedirect("login.jsp?error=You have been successfully logged out.");
    }
}