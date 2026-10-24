<%@page import="Models.ProductType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Delete Product Type</title>

        <style>
            body {
                background: #f5f7fa;
            }

            .delete-card {
                max-width: 600px;
                margin: auto;
                margin-top: 60px;
                border-radius: 15px;
                padding: 25px;
                background: white;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .type-img {
                width: 120px;
                height: 120px;
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

            <h3 class="text-center text-danger mb-4">⚠ Delete Product Type</h3>

            <%
                if (request.getAttribute("object") == null) {
            %>

            <div class="alert alert-danger text-center">
                Can't get Product Type data (ID not exist)
            </div>

            <div class="text-center">
                <a href="ProductType" class="btn btn-secondary btn-custom">Back</a>
            </div>

            <%
            } else {
                ProductType type = (ProductType) request.getAttribute("object");
            %>

            <!-- WARNING -->
            <div class="danger-box text-center mb-4">
                Are you sure you want to delete 
                <strong><%= type.getName()%></strong> (ID: <%= type.getId()%>) ?
            </div>

            <!-- TYPE INFO -->
            <div class="text-center mb-4">
                <img src="resources/image/productTypeImage/<%= type.getTypeImage()%>" 
                     class="type-img mb-3">
                <h5><%= type.getName()%></h5>
            </div>

            <!-- FORM -->
            <form method="POST">

                <!-- hidden -->
                <input type="hidden" name="id" value="<%= type.getId()%>">
                <input type="hidden" name="image" value="<%= type.getTypeImage()%>">

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
                    <a href="ProductType" class="btn btn-secondary btn-custom">
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