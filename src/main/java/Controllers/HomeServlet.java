/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.ProductDAO;
import DAOs.ProductTypeDAO;
import Models.Product;
import Models.ProductType;
import java.io.IOException;

import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Phat
 */
public class HomeServlet extends HttpServlet {

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
            
        ProductTypeDAO typeDao = new ProductTypeDAO();
        List<ProductType> types = typeDao.getAll();
        request.setAttribute("types", types);
        
        ProductDAO proDao = new ProductDAO();
        List<Product> products = new java.util.ArrayList<>();
        String filter = request.getParameter("filter");
        String key = request.getParameter("search");
        if(filter != null){
            try {
                int typeId = Integer.parseInt(filter);
                products = proDao.getAvailableByTypeId(typeId);
            } catch (NumberFormatException e) {
                
            }
        } else if(key != null){
            products = proDao.getAvailableByKey(key);
        } else {
            products = proDao.getAll();
        }
        request.setAttribute("products", products);        
        request.getRequestDispatcher("home.jsp").forward(request, response);
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
        doGet(request, response);
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
