package com.oceanview.controller;

import com.oceanview.dao.UserDAOImpl;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller to handle viewing and managing staff accounts.
 */
@WebServlet("/ManageStaffServlet")
public class ManageStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests: Fetches the list of all staff to display on the page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security Check: Kick out unauthorized users
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("loggedRole");
        if (role == null || (!role.equalsIgnoreCase("Manager") && !role.equalsIgnoreCase("Admin"))) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        // 2. Fetch the list of users from the database
        UserDAOImpl userDAO = new UserDAOImpl();
        List<User> staffList = userDAO.findAll(); // This uses the method we just updated!

        // 3. Attach the list to the request and forward it to the JSP page
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("manage-staff.jsp").forward(request, response);
    }

    /**
     * Handles POST requests: Specifically catches the "Delete" button clicks.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security Check
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("loggedRole");
        if (role == null || (!role.equalsIgnoreCase("Manager") && !role.equalsIgnoreCase("Admin"))) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        // 2. If the action is "delete", process the removal
        if ("delete".equals(action)) {
            String usernameToDelete = request.getParameter("username");
            String loggedInUser = (String) session.getAttribute("loggedUser");

            // ETHICAL IT FEATURE: Prevent self-deletion to avoid system lockouts
            if (usernameToDelete != null && usernameToDelete.equals(loggedInUser)) {
                response.sendRedirect("ManageStaffServlet?error=Security Policy: You cannot delete your own active account.");
                return;
            }

            // 3. Tell the database to delete the user
            UserDAOImpl userDAO = new UserDAOImpl();
            boolean isDeleted = userDAO.deleteUserByUsername(usernameToDelete);

            // 4. Refresh the page with a success or error message
            if (isDeleted) {
                response.sendRedirect("ManageStaffServlet?message=Staff member successfully removed.");
            } else {
                response.sendRedirect("ManageStaffServlet?error=Failed to remove staff member.");
            }
        }
    }
}