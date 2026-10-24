
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
        <title>Add Balance Page</title>
        <style>
            body {
                background: linear-gradient(to right, #667eea, #764ba2);
            }

            .wallet-card {
                max-width: 500px;
                margin: auto;
                margin-top: 80px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .balance-box {
                background: linear-gradient(to right, #43e97b, #38f9d7);
                border-radius: 15px;
                padding: 20px;
                color: white;
                text-align: center;
            }

            .balance-amount {
                font-size: 28px;
                font-weight: bold;
            }

            .btn-deposit {
                background-color: #43e97b;
                border: none;
            }

            .btn-deposit:hover {
                background-color: #2ecc71;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="w-75 m-auto">
                <h1>Add Balance</h1>
                <%
                    if (request.getAttribute("object") == null && request.getAttribute("balance") == null) {
                %>
                <p class="d-block invalid-feedback">Can't get data of Product, ID not exist</p>
                <a href="Product" class="btn btn-secondary" id="back">Back</a>
                <%
                } else {
                    User user = (User) request.getAttribute("object");
                %>
                <h5>Current balance: <%= request.getAttribute("balance")%></h5>
                <form method="POST" action="Balance">
                    <input type="hidden" value="<%= user.getId()%>" name="id">
                    <div class  ="mb-3">
                        <label class="form-label">Product Price</label> 
                        <input type = "number" min = "1000" step = "1000" class="form-control" name="amount" required>
                    </div> 
                    <button type = "submit" class="btn btn-success" id="submit">Add</button>
                </form>
                <%
                    }
                    if (request.getAttribute("err") != null) {
                        String err = (String) request.getAttribute("err");
                %>
                <p class="d-block invalid-feedback"><%= err%></p>
                <%
                    }
                %>
            </div>
        </div>
        <script src="resources/js/bootstrap.bundle.js"></script>
    </body>
</html>
