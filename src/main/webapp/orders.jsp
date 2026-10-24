<%@page import="Models.OrderDetail"%>
<%@page import="Models.OrderList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Order List</title>

        <style>
            body {
                background-color: #f5f7fa;
            }

            .order-card {
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .product-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 10px;
            }

            .total-price {
                font-size: 20px;
                font-weight: bold;
                color: red;
            }

            .status {
                font-weight: bold;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="container mt-4">

            <h3 class="mb-4">📦 My Orders</h3>

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
                if (request.getAttribute("list") != null) {
                    List<OrderList> list = (List<OrderList>) request.getAttribute("list");

                    for (OrderList order : list) {
                        long totalPrice = 0;
            %>

            <!-- ORDER CARD -->
            <div class="card order-card p-3">

                <!-- ORDER HEADER -->
                <div class="d-flex justify-content-between mb-3">
                    <div>
                        <strong>Order ID:</strong> <%= order.getId()%><br>
                        <small class="text-muted">Date: <%= order.getOrderDate()%></small>
                    </div>

                    <div class="status text-primary">
                        <%= order.getStatus()%>
                    </div>
                </div>

                <hr>

                <!-- ORDER DETAILS -->
                <%
                    for (OrderDetail orderDetail : order.getOrderDetail()) {
                        totalPrice += orderDetail.getTotalPrice();
                %>

                <div class="d-flex align-items-center mb-3">

                    <img src="resources/image/productImage/<%= orderDetail.getProduct().getImage()%>" 
                         class="product-img me-3">

                    <div class="flex-grow-1">
                        <h6 class="mb-1"><%= orderDetail.getProduct().getName()%></h6>
                        <small class="text-muted">
                            <%= orderDetail.getProduct().getDescription()%>
                        </small>
                    </div>

                    <div class="text-end">
                        <p class="mb-1">x<%= orderDetail.getQuantity()%></p>
                        <p class="mb-1"><%= orderDetail.getUnitPrice()%> VND</p>
                        <p class="text-danger fw-bold">
                            <%= orderDetail.getTotalPrice()%> VND
                        </p>
                    </div>

                </div>

                <%
                    }
                %>

                <hr>

                <!-- TOTAL + ACTION -->
                <div class="d-flex justify-content-between align-items-center">

                    <div class="total-price">
                        Total: <%= totalPrice%> VND
                    </div>

                    <div class="d-flex">

                        <!-- PAYMENT -->
                        <form action="Payment" method="POST" class="me-2">
                            <input type="hidden" value="<%= totalPrice%>" name="amount">
                            <input type="hidden" value="<%= order.getId()%>" name="id">
                            <button type="submit" class="btn btn-success">
                                Pay Now
                            </button>
                        </form>

                        <!-- DELETE -->
                        <form action="Order?action=delete" method="POST">
                            <input type="hidden" value="<%= order.getId()%>" name="id">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Cancel this order?');">
                                Cancel
                            </button>
                        </form>

                    </div>

                </div>

            </div>

            <%
                }
            } else {
            %>

            <div class="alert alert-warning text-center">
                There is no data!
            </div>

            <%
                }
            %>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>