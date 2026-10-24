package Controllers;

import DAOs.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ResetServlet", urlPatterns = {"/reset"})
public class ResetServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        String error = null;
        if (password == null || password.isEmpty() || confirm == null || confirm.isEmpty()) {
            error = "Password and confirm cannot be empty!";
        } else if (!password.equals(confirm)) {
            error = "Passwords do not match!";
        } else if (username == null || new UserDAO().updatePassword(username, password) != 1) {
            error = "Failed to reset password. Try again!";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("username", username);
            request.getRequestDispatcher("reset.jsp").forward(request, response);
            return;
        }

        request.setAttribute("success", "Password reset successfully! Please login.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("forgot.jsp");
    }
}
