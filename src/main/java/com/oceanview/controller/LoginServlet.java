package com.oceanview.controller;

import com.oceanview.dao.UserDAOImpl;
import com.oceanview.model.User;

// IMPORTANT: If you are using Tomcat 10 or newer, change "javax" to "jakarta" in the 6 lines below!
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

/**
 * Controller to handle secure staff authentication requests.
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAOImpl userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize the Data Access Object when the servlet starts up
        userDAO = new UserDAOImpl();
    }

    /**
     * Handles the HTTP POST request triggered by the HTML login form submission.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Extract the credentials from the incoming request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. Perform basic server-side validation to restrict invalid entries
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=Missing credentials");
            return;
        }

        // 3. Authenticate against the database using our DAO
        Optional<User> authenticatedUser = userDAO.authenticate(username, password);

        if (authenticatedUser.isPresent()) {
            // 4. Success! Extract the user object
            User user = authenticatedUser.get();
            
            // 5. Create a secure session to remember the user across the application
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user.getUsername());
            
            // FIXED: Changed "userRole" to "loggedRole" so it matches your dashboard exactly!
            session.setAttribute("loggedRole", user.getRole()); 
            
            // 6. Redirect them to the main dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // 7. Failure! Send them back to the login page with an error message
            response.sendRedirect("login.jsp?error=Invalid username or password");
        }
    }
}