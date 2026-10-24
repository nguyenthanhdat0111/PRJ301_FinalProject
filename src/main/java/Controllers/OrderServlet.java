/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.OrderDAO;
import DAOs.OrderDetailDAO;
import Models.Cart;
import Models.OrderList;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
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
public class OrderServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        OrderDAO dao = new OrderDAO();
        if (user.getRole().equals("Admin")) {
            String filter;
            if (request.getParameter("filter") == null) {
                filter = "";
            } else {
                filter = request.getParameter("filter");
            }
            List<OrderList> list;
            switch (filter) {
                case "pending":
                    list = dao.getAll("pending");
                    break;
                case "completed": {
                    list = dao.getAll("completed");
                    break;
                }
                case "cancelled": {
                    list = dao.getAll("cancelled");
                    break;
                }
                default:
                    list = dao.getAll();
                    break;
            }
            request.setAttribute("list", list);
            request.getRequestDispatcher("orderManage.jsp").forward(request, response);
        } else {
            List<OrderList> list = dao.getOrderByUserId(user.getId());
            request.setAttribute("list", list);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDao = new OrderDAO();
        OrderDetailDAO orderDetailDao = new OrderDetailDAO();
        CartDAO cartDao = new CartDAO();
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String action = request.getParameter("action");
        if (action == null) {
            doGet(request, response);
            return;
        }

        switch (action) {
            case "add":
                try {
                orderDao.insert(user.getId());
                int orderId = orderDao.getMaxID();
                List<Cart> carts = cartDao.getAll(user.getId());
                for (Cart cart : carts) {
                    String cartId = String.valueOf(cart.getId());
                    boolean isCheck = request.getParameter(cartId) != null;
                    if (isCheck) {
                        int proId = Integer.parseInt(request.getParameter(cartId + "proId"));
                        int quantity = Integer.parseInt(request.getParameter(cartId + "quantity"));
                        Long price = Long.parseLong(request.getParameter(cartId + "unitPrice"));
                        orderDetailDao.insert(orderId, proId, quantity, price);
                        cartDao.delete(cart.getId());
                    }
                }
                response.sendRedirect("Order");
            } catch (NumberFormatException e) {
                out.println("Error at Insert new object: " + e.getMessage());
            }
            break;
            case "delete":
                try {
                int id = Integer.parseInt(request.getParameter("id"));
                if (orderDao.updateOrderStatus(id, "cancelled") == 1) {
                    response.sendRedirect("Order");
                } else {
                    request.setAttribute("err", "Delete failed");
                    doGet(request, response);
                }
            } catch (ServletException | IOException | NumberFormatException e) {
                out.println("Error at delete object: " + e.getMessage());
            }
            break;
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
