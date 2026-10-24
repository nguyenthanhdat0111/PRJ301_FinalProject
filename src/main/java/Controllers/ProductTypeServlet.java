/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.ProductTypeDAO;
import Models.ProductType;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author Phat
 */
@MultipartConfig
public class ProductTypeServlet extends HttpServlet {

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
        ProductTypeDAO dao = new ProductTypeDAO();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "create":
                request.getRequestDispatcher("createProductType.jsp").forward(request, response);
                break;
            case "update": {
                String idStr = request.getParameter("id");
                int id;
                ProductType type;
                try {
                    id = Integer.parseInt(idStr);
                    type = dao.getById(id);
                    request.setAttribute("object", type);
                    request.getRequestDispatcher("updateProductType.jsp").forward(request, response);
                } catch (ServletException | IOException | NumberFormatException e) {
                    out.println("Error at get id for update: " + e.getMessage());
                }
                break;
            }
            case "delete": {
                String idStr = request.getParameter("id");
                int id;
                ProductType type;
                try {
                    id = Integer.parseInt(idStr);
                    type = dao.getById(id);
                    request.setAttribute("object", type);
                    request.getRequestDispatcher("deleteProductType.jsp").forward(request, response);

                } catch (NumberFormatException e) {
                    out.println("Error at get id for delete: " + e.getMessage());
                }
                break;
            }
            default:
                List<ProductType> types = dao.getAll();
                request.setAttribute("data", types);
                request.getRequestDispatcher("productTypes.jsp").forward(request, response);
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
        ProductTypeDAO dao = new ProductTypeDAO();
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        if (action == null) {
            doGet(request, response);
            return;
        }

        switch (action) {
            case "create":
                try {
                String name = request.getParameter("name");
                if (dao.getByName(name) != null) {
                    request.setAttribute("err", "Create failed. Product type name have already existed");
                    doGet(request, response);
                    return;
                }
                String uploadDir = getServletContext().getRealPath("resources/image/productTypeImage");
                File uploadFolder = new File(uploadDir);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }
                Part filePart = request.getPart("image");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadDir + File.separator + fileName;
                filePart.write(filePath);
                String image = fileName;
                if (dao.insert(name, image) == 1) {
                    response.sendRedirect("ProductType");
                } else {
                    request.setAttribute("err", "Create failed");
                    doGet(request, response);
                }
            } catch (IOException | NumberFormatException e) {
                out.println("Error at Insert new object: " + e.getMessage());
            }
            break;
            case "update":
                try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                ProductType pro = dao.getByName(name);
                if (pro == null || pro.getId() == id) {
                } else {
                    request.setAttribute("err", "Update failed. Product type name have already existed");
                    doGet(request, response);
                    return;
                }
                String image = request.getParameter("oldImage");
                Part filePart = request.getPart("newImage");
                if (filePart != null && filePart.getSize() > 0) {
                    if (image != null) {
                        String fullOldPath = getServletContext().getRealPath(image);
                        File oldFile = new File(fullOldPath);
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadDir = getServletContext().getRealPath("resources/image/productTypeImage");
                    filePart.write(uploadDir + File.separator + fileName);
                    image = fileName;
                }
                if (dao.update(id, name, image) == 1) {
                    response.sendRedirect("ProductType");
                } else {
                    request.setAttribute("err", "Update failed.");
                    doGet(request, response);
                }
            } catch (ServletException | IOException | NumberFormatException e) {
                out.println("Error at update object: " + e.getMessage());
            }
            break;
            case "delete":
                try {
                int id = Integer.parseInt(request.getParameter("id"));
                String path = request.getParameter("image");
                if (path != null) {
                    String fullPath = getServletContext().getRealPath("resources/image/productTypeImage/" + path);
                    File file = new File(fullPath);
                    if (file.exists()) {
                        file.delete();
                    }
                }
                if (dao.delete(id) == 1) {
                    response.sendRedirect("ProductType");
                } else {
                    request.setAttribute("err", "Delete failed");
                    doGet(request, response);
                }
            } catch (ServletException | IOException | NumberFormatException e) {
                out.println("Error at delete object: " + e.getMessage());
            }
            break;
            default:
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
