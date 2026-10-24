<%@page import="java.util.List"%>
<%@page import="Models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Product Management</title>

        <style>
            body {
                background-color: #f4f6f9;
            }

            .table-container {
                background: white;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .product-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 10px;
            }

            .btn-custom {
                border-radius: 20px;
            }

            .header-title {
                font-weight: bold;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />                 

        <div class="container mt-4">

            <!-- TITLE + BUTTON -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="header-title">📦 Product Management</h3>

                <div>
                    <a href="Product?action=create" class="btn btn-success btn-custom me-2">
                        + Create
                    </a>
                    <a href="Product?action=add" class="btn btn-primary btn-custom">
                        + Add Quantity
                    </a>
                </div>
            </div>

            <%
                if (request.getAttribute("data") != null) {
                    List<Product> products = (List<Product>) request.getAttribute("data");
            %>

            <div class="table-container">

                <table class="table table-hover align-middle">

                    <thead class="table-dark text-center">
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Qty</th>
                            <th>Type</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody class="text-center">

                        <%
                            for (Product product : products) {
                        %>

                        <tr>
                            <td><%= product.getId()%></td>

                            <td>
                                <img src="resources/image/productImage/<%= product.getImage()%>" 
                                     class="product-img">
                            </td>

                            <td class="text-start">
                                <strong><%= product.getName()%></strong><br>
                                <small class="text-muted"><%= product.getDescription()%></small>
                            </td>

                            <td class="text-danger fw-bold">
                                <%= product.getPrice()%> VND
                            </td>

                            <td>
                                <span class="badge bg-info">
                                    <%= product.getQuantity()%>
                                </span>
                            </td>

                            <td>
                                <span class="badge bg-secondary">
                                    <%= product.getType().getName()%>
                                </span>
                            </td>

                            <td>
                                <a href="Product?action=update&id=<%= product.getId()%>" 
                                   class="btn btn-warning btn-sm btn-custom">
                                    Update
                                </a>

                                <a href="Product?action=delete&id=<%= product.getId()%>" 
                                   class="btn btn-danger btn-sm btn-custom"
                                   onclick="return confirm('Are you sure to delete?');">
                                    Delete
                                </a>
                            </td>
                        </tr>

                        <%
                            }
                        %>

                    </tbody>
                </table>

            </div>

            <% } else { %>

            <div class="alert alert-warning text-center">
                There is no data!
            </div>

            <% }%>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>