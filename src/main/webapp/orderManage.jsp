

<%@page import="Models.OrderDetail"%>
<%@page import="Models.OrderList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Manage Page</title>
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />                 
        <div class="container">
            <h1>Order list</h1>
            <a href="Order?filter=pending" class="btn btn-secondary">Pending</a>
            <a href="Order?filter=completed" class="btn btn-success">Completed</a>
            <a href="Order?filter=cancelled" class="btn btn-warning">cancelled</a>
            <%
                if (request.getAttribute("err") != null) {
                    String err = (String) request.getAttribute("err");
            %>
            <p class="d-block invalid-feedback"><%= err%></p>
            <%
                }
            %>
        </div>
        <%
            if (request.getAttribute("list") != null) {
                List<OrderList> list = (List<OrderList>) request.getAttribute("list");
        %>
        <div class="container">
            <div class="row">
                <%
                    for (OrderList order : list) {
                        long totalPrice = 0;
                %>
                <div class="col-4 shadow-sm p-3 mt-5 bg-body-tertiary rounded">
                    <h5>ID: <%= order.getId()%></h5>
                    <p>Order Date: <%= order.getOrderDate()%></p>
                    <p>Status: <%= order.getStatus()%></p>
                </div>
                <div class="col-8 shadow p-3 mt-5 bg-body-tertiary rounded">
                    <%
                        for (OrderDetail orderDetail : order.getOrderDetail()) {
                            totalPrice += orderDetail.getTotalPrice();
                    %>
                    <div class="row shadow-sm p-3 bg-body-tertiary rounded">
                        <div class="col-5">
                            <h5><%=orderDetail.getProduct().getName()%></h5>
                            <p><%=orderDetail.getProduct().getDescription()%></p>
                        </div>
                        <div class="col-2">
                            <img src="resources/image/productImage/<%= orderDetail.getProduct().getImage()%>" class="card-img-top" height="100%" alt="<%= orderDetail.getProduct().getImage()%>">
                        </div>
                        <div class="col-5">
                            <p>Quantity: <%=orderDetail.getQuantity()%></p>
                            <p>Unit Price: <%=orderDetail.getUnitPrice()%></p>
                            <p>Total Price <%=orderDetail.getTotalPrice()%></p>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <% } else {
        %>
        <p class="d-block invalid-feedback text-center fs-3">There is no data!</p>
        <%
            }
        %>
    </div>
    <script src="resources/js/bootstrap.bundle.js"></script>
    </body>
</html>
