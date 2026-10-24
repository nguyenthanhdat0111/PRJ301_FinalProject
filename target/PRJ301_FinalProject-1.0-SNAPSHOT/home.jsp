<%@page import="Models.ProductType"%>
<%@page import="java.util.List"%>
<%@page import="Models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Home Page</title>

        <style>
            body {
                background-color: #f5f7fa;
            }

            .category-box {
                border-radius: 10px;
                transition: 0.3s;
            }

            .category-box:hover {
                background-color: #e9ecef;
                transform: scale(1.03);
            }

            .product-card {
                border-radius: 15px;
                transition: 0.3s;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }

            .price {
                color: red;
                font-weight: bold;
            }

            .btn-cart {
                background-color: #ff5722;
                border: none;
            }

            .btn-cart:hover {
                background-color: #e64a19;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />                 

        <div class="container mt-4">
            <h2 class="mb-4">🛒 Products</h2>
        </div>

        <%
            if (request.getAttribute("products") != null && request.getAttribute("types") != null) {
                List<Product> products = (List<Product>) request.getAttribute("products");
                List<ProductType> types = (List<ProductType>) request.getAttribute("types");
        %>

        <div class="container">
            <div class="row">

                <!-- LEFT CATEGORY -->
                <div class="col-md-3">
                    <div class="card p-3 shadow-sm">
                        <h5>Categories</h5>

                        <a href="Home" class="btn btn-outline-primary w-100 mb-2">All</a>

                        <%
                            for (ProductType type : types) {
                        %>
                        <div class="d-flex align-items-center mb-2 p-2 category-box">
                            <img src="resources/image/productTypeImage/<%= type.getTypeImage()%>" width="40">
                            <a href="Home?filter=<%= type.getId()%>" class="ms-2 text-decoration-none">
                                <%= type.getName()%>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <!-- RIGHT PRODUCTS -->
                <div class="col-md-9">
                    <div class="row">

                        <%
                            for (Product product : products) {
                        %>

                        <div class="col-md-4 mb-4">
                            <div class="card product-card h-100">

                                <img src="resources/image/productImage/<%= product.getImage()%>" 
                                     class="card-img-top" 
                                     style="height:200px; object-fit:cover;">

                                <div class="card-body d-flex flex-column">

                                    <h6 class="card-title"><%= product.getName()%></h6>

                                    <p class="price"><%= product.getPrice()%> VND</p>

                                    <p class="card-text small text-muted">
                                        <%= product.getDescription()%>
                                    </p>

                                    <form action="Cart?action=add" method="POST" class="mt-auto">
                                        <input type="hidden" value="<%= product.getId()%>" name="id">
                                        <input type="hidden" value="<%= product.getPrice()%>" name="price">

                                        <div class="d-flex mb-2">
                                            <input type="number" min="1" name="quantity" 
                                                   class="form-control me-2" value="1">
                                        </div>

                                        <button class="btn btn-cart text-white w-100" type="submit">
                                            Add to Cart
                                        </button>
                                    </form>

                                </div>
                            </div>
                        </div>

                        <%
                            }
                        %>

                    </div>
                </div>

            </div>
        </div>

        <% } else { %>

        <div class="container text-center mt-5">
            <div class="alert alert-warning">
                There is no data!
            </div>
        </div>

        <% }%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>