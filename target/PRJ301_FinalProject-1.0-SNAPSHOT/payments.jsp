<%@page import="Models.Payment"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Payment History</title>

        <style>
            body {
                background: #f5f7fa;
            }

            .payment-card {
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                padding: 15px;
            }

            .amount {
                font-size: 18px;
                font-weight: bold;
                color: green;
            }

            .date {
                font-size: 14px;
                color: gray;
            }

            .icon {
                font-size: 30px;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />                 

        <div class="container mt-4">

            <h3 class="mb-4">💳 Payment History</h3>

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
                if (request.getAttribute("data") != null) {
                    List<Payment> payments = (List<Payment>) request.getAttribute("data");
            %>

            <!-- LIST -->
            <div class="row">

                <%
                    for (Payment payment : payments) {
                %>

                <div class="col-md-6">
                    <div class="payment-card d-flex justify-content-between align-items-center">

                        <!-- LEFT -->
                        <div>
                            <div class="icon">💰</div>
                        </div>

                        <!-- CENTER -->
                        <div class="flex-grow-1 ms-3">
                            <div><strong>Payment ID:</strong> <%= payment.getId()%></div>
                            <div class="date">
                                <%= payment.getPaymentDate()%>
                            </div>
                        </div>

                        <!-- RIGHT -->
                        <div class="text-end">
                            <div class="amount">
                                <%= payment.getAmount()%> VND
                            </div>
                        </div>

                    </div>
                </div>

                <%
                    }
                %>

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