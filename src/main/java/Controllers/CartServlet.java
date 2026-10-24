/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import Models.Cart;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class CartServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        CartDAO dao = new CartDAO();

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "delete": {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    if (dao.delete(id) == 1) {
                        response.sendRedirect("Cart");
                    } else {
                        request.setAttribute("err", "Delete failed");
                        request.setAttribute("data", dao.getAll(user.getId()));
                        request.getRequestDispatcher("carts.jsp").forward(request, response);
                    }
                } catch (ServletException | IOException | NumberFormatException e) {
                    out.println("Error at delete object: " + e.getMessage());
                }
                break;
            }
            default:
                List<Cart> carts = dao.getAll(user.getId());
                request.setAttribute("data", carts);
                request.getRequestDispatcher("carts.jsp").forward(request, response);
                break;
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CartDAO dao = new CartDAO();
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
                int id = Integer.parseInt(request.getParameter("id"));
                long price = Long.parseLong(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                int userId = user.getId();
                if (dao.getByProductId(userId, id) != null) {
                    if (dao.update(userId, id, quantity) == 1) {
                        response.sendRedirect("Cart");
                    } else {
                        request.setAttribute("err", "Create failed");
                        doGet(request, response);
                    }
                } else {
                    if (dao.insert(userId, id, price, quantity) == 1) {
                        response.sendRedirect("Cart");
                    } else {
                        request.setAttribute("err", "Create failed");
                        doGet(request, response);
                    }
                }
            } catch (IOException | NumberFormatException e) {
                out.println("Error at Insert new object: " + e.getMessage());
            }
            break;
            case "delete":
                try {
                int id = Integer.parseInt(request.getParameter("cartId"));
                if (dao.delete(id) == 1) {
                    response.sendRedirect("Cart");
                } else {
                    request.setAttribute("err", "Delete failed");
                    request.setAttribute("data", dao.getAll(user.getId()));
                    request.getRequestDispatcher("carts.jsp").forward(request, response);
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
