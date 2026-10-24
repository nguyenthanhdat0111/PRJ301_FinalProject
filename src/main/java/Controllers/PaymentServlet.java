/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.OrderDAO;
import DAOs.PaymentDAO;
import DAOs.UserDAO;
import Models.Payment;
import Models.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Phat
 */
public class PaymentServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PaymentDAO paymentDao = new PaymentDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Payment> payments;
        if (user.getRole().equals("Admin")) {
            payments = paymentDao.getAll();
        } else {
            payments = paymentDao.getAll(user.getId());
        }
        request.setAttribute("data", payments);
        request.getRequestDispatcher("payments.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        UserDAO userDao = new UserDAO();
        PaymentDAO paymentDao = new PaymentDAO();
        OrderDAO orderDao = new OrderDAO();

        long amount = Long.parseLong(request.getParameter("amount"));
        int orderId = Integer.parseInt(request.getParameter("id"));
        if (userDao.getUserBalance(user.getId()) >= amount) {
            userDao.updateBalance(user.getId(), -amount);
            orderDao.updateOrderStatus(orderId, "completed");
            paymentDao.insert(orderId, amount);
            response.sendRedirect("Payment");
        } else {
            request.setAttribute("err", "Make payment failed. Your balance is overdraw");
            doGet(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


}
