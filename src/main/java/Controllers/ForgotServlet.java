package Controllers;

import DAOs.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ForgotServlet", urlPatterns = {"/forgot"})
public class ForgotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username == null || username.trim().isEmpty()
                || new UserDAO().getByName(username.trim()) == null) {
            request.setAttribute("error", "Username not found!");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        request.setAttribute("username", username.trim());
        request.getRequestDispatcher("reset.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("forgot.jsp");
    }
}
