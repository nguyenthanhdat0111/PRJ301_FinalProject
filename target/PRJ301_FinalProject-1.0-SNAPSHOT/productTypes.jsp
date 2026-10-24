<%@page import="java.util.List"%>
<%@page import="Models.ProductType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Product Types</title>

        <style>
            body {
                background-color: #f4f6f9;
            }

            .card-container {
                background: white;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .type-img {
                width: 70px;
                height: 70px;
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

            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="header-title">📂 Product Type Management</h3>

                <a href="ProductType?action=create" class="btn btn-success btn-custom">
                    + Create New
                </a>
            </div>

            <%
                if (request.getAttribute("data") != null) {
                    List<ProductType> types = (List<ProductType>) request.getAttribute("data");
            %>

            <div class="card-container">

                <table class="table table-hover align-middle">

                    <thead class="table-dark text-center">
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody class="text-center">

                        <%
                            for (ProductType type : types) {
                        %>

                        <tr>
                            <td><%= type.getId()%></td>

                            <td>
                                <img src="resources/image/productTypeImage/<%= type.getTypeImage()%>" 
                                     class="type-img">
                            </td>

                            <td>
                                <strong><%= type.getName()%></strong>
                            </td>

                            <td>
                                <a href="ProductType?action=update&id=<%= type.getId()%>" 
                                   class="btn btn-warning btn-sm btn-custom">
                                    Update
                                </a>

                                <a href="ProductType?action=delete&id=<%= type.getId()%>" 
                                   class="btn btn-danger btn-sm btn-custom"
                                   onclick="return confirm('Delete this type?');">
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