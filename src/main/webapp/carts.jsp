<%@page import="Models.Cart"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Cart</title>

        <style>
            body {
                background-color: #f5f7fa;
            }

            .cart-card {
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                padding: 15px;
            }

            .product-img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 10px;
            }

            .price {
                color: red;
                font-weight: bold;
            }

            .total-box {
                border-radius: 15px;
                background: white;
                padding: 20px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="container mt-4">

            <h3 class="mb-4">🛒 My Cart</h3>

            <%
                if (request.getAttribute("err") != null) {
            %>
            <div class="alert alert-danger text-center">
                <%= request.getAttribute("err")%>
            </div>
            <%
                }
            %>

            <%
                if (request.getAttribute("data") != null && !((List<Cart>) request.getAttribute("data")).isEmpty()) {
                    List<Cart> carts = (List<Cart>) request.getAttribute("data");
                    long total = 0;
            %>

            <form action="Order?action=add" method="POST">

                <!-- LIST CART -->
                <%
                    for (Cart cart : carts) {
                        long itemTotal = cart.getQuantity() * cart.getUnitPrice();
                        total += itemTotal;
                %>

                <div class="cart-card d-flex align-items-center">

                    <!-- CHECK -->
                    <input type="checkbox" name="<%= cart.getId()%>" value="true" class="me-3">

                    <!-- IMAGE -->
                    <img src="resources/image/productImage/<%= cart.getProduct().getImage()%>" 
                         class="product-img me-3">

                    <!-- INFO -->
                    <div class="flex-grow-1">
                        <h6><%= cart.getProduct().getName()%></h6>
                        <small class="text-muted">
                            <%= cart.getProduct().getDescription()%>
                        </small>
                    </div>

                    <!-- QUANTITY -->
                    <div class="me-3">
                        <label>Qty</label>
                        <input type="number" min="1"
                               name="<%= cart.getId() + "quantity"%>"
                               value="<%= cart.getQuantity()%>"
                               class="form-control" style="width:80px;">
                    </div>

                    <!-- PRICE -->
                    <div class="text-end me-3">
                        <p class="mb-1">Unit: <%= cart.getUnitPrice()%></p>
                        <p class="price"><%= itemTotal%> VND</p>
                    </div>

                    <!-- HIDDEN -->
                    <input type="hidden" name="<%= cart.getId() + "proId"%>" value="<%= cart.getProduct().getId()%>">
                    <input type="hidden" name="<%= cart.getId() + "unitPrice"%>" value="<%= cart.getUnitPrice()%>">

                    <!-- DELETE -->
                    <a href="Cart?action=delete&id=<%= cart.getId()%>" 
                       class="btn btn-danger btn-sm">
                        Delete
                    </a>

                </div>

                <%
                    }
                %>

                <!-- TOTAL + ACTION -->
                <div class="total-box mt-4 d-flex justify-content-between align-items-center">

                    <h5>Total: <span class="price"><%= total%> VND</span></h5>

                    <button type="submit" class="btn btn-success">
                        Place Order
                    </button>

                </div>

            </form>

            <% } else { %>

            <div class="alert alert-warning text-center">
                Your cart is empty!
            </div>

            <% }%>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>