<%@page import="Models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Delete Product</title>

        <style>
            body {
                background: #f5f7fa;
            }

            .delete-card {
                max-width: 700px;
                margin: auto;
                margin-top: 60px;
                border-radius: 15px;
                padding: 25px;
                background: white;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .product-img {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 10px;
            }

            .danger-box {
                background: #ffe5e5;
                border: 1px solid #ff4d4d;
                padding: 15px;
                border-radius: 10px;
            }

            .btn-custom {
                border-radius: 20px;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="delete-card">

            <h3 class="text-center text-danger mb-4">⚠ Delete Product</h3>

            <%
                if (request.getAttribute("object") == null) {
            %>

            <div class="alert alert-danger text-center">
                Can't get product data (ID not exist)
            </div>

            <div class="text-center">
                <a href="Product" class="btn btn-secondary btn-custom">Back</a>
            </div>

            <%
            } else {
                Product product = (Product) request.getAttribute("object");
            %>

            <!-- WARNING -->
            <div class="danger-box mb-4 text-center">
                Are you sure you want to delete 
                <strong><%= product.getName()%></strong> (ID: <%= product.getId()%>) ?
            </div>

            <!-- PRODUCT INFO -->
            <div class="row align-items-center mb-4">

                <div class="col-md-4 text-center">
                    <img src="resources/image/productImage/<%= product.getImage()%>" 
                         class="product-img">
                </div>

                <div class="col-md-8">
                    <p><strong>Name:</strong> <%= product.getName()%></p>
                    <p><strong>Description:</strong> <%= product.getDescription()%></p>
                    <p><strong>Price:</strong> <%= product.getPrice()%> VND</p>
                    <p><strong>Quantity:</strong> <%= product.getQuantity()%></p>
                    <p><strong>Category:</strong> <%= product.getType().getName()%></p>
                </div>

            </div>

            <!-- FORM -->
            <form method="POST">

                <!-- hidden để gửi id -->
                <input type="hidden" name="id" value="<%= product.getId()%>">
                <input type="hidden" name="image" value="<%= product.getImage()%>">

                <!-- ERROR -->
                <%
                    if (request.getAttribute("err") != null) {
                %>
                <div class="alert alert-danger text-center">
                    <%= request.getAttribute("err")%>
                </div>
                <%
                    }
                %>

                <!-- BUTTON -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="Product" class="btn btn-secondary btn-custom">
                        Cancel
                    </a>

                    <button type="submit" class="btn btn-danger btn-custom">
                        Delete
                    </button>
                </div>

            </form>

            <%
                }
            %>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>