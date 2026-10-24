

<%@page import="Models.ProductType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Product Type</title>
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="w-75 m-auto">
                <h1>Update Product Type</h1>
                <%
                    if (request.getAttribute("object") == null) {
                %>
                <p class="d-block invalid-feedback">Can't get data of object, ID not exist</p>
                <a href="Product" class="btn btn-secondary" id="back">Back</a>
                <%
                } else {
                    ProductType type = (ProductType) request.getAttribute("object");
                %>
                <form method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="pId" class="form-label">Product Id</label>
                        <input type="number" class="form-control" name="id" id="pId" value="<%= type.getId()%>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="pName" class="form-label">Product Name</label>
                        <input type="text" class="form-control" id="pName" name="name" value="<%= type.getName()%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="image" class="form-label">Product Image</label>
                        <input type="hidden" value="<%= type.getTypeImage()%>" name="oldImage">
                        <input type="file" class="form-control" id="image" name="newImage">
                    </div>
                    <a href="ProductType" class="btn btn-secondary" id="back">Back</a>
                    <button type="submit" class="btn btn-warning" id="submit">Update</button>
                </form>
                <%
                    if (request.getAttribute("err") != null) {
                        String err = (String) request.getAttribute("err");
                %>
                <p class="d-block invalid-feedback"><%= err%></p>
                <%
                        }
                    }
                %>
            </div>
        </div>
        <script src="resources/js/bootstrap.bundle.js"></script>
    </body>
</html>
