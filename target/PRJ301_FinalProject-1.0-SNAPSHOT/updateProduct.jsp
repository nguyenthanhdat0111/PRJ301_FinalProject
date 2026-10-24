
<%@page import="Models.ProductType"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ProductTypeDAO"%>
<%@page import="Models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Product Page</title>
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="w-75 m-auto">
                <!-- Page title -->
                <h1>Update Product</h1>
                <!-- END -->
                <%
                    if (request.getAttribute("object") == null) {
                %>
                <p class="d-block invalid-feedback">Can't get data of object, ID not exist</p>
                <a href="Product" class="btn btn-secondary" id="back">Back</a>
                <%
                } else {
                    Product product = (Product) request.getAttribute("object");
                %>
                <form method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="pId" class="form-label">Product Id</label>
                        <input type="number" class="form-control" name="id" id="pId" value="<%= product.getId()%>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="pName" class="form-label">Product Name</label>
                        <input type="text" class="form-control" id="pName" name="name" value="<%= product.getName()%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="pDescription" class="form-label">Product Description</label>
                        <input type="text" class="form-control" id="pDescription" name="description" value="<%= product.getDescription()%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="pPrice" class="form-label">Product Price</label>
                        <input type="number" min="0" step="1000" class="form-control" id="pPrice" name="price" value="<%= product.getPrice()%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="pQuantity" class="form-label">Product Quantity</label>
                        <input type="number" min="0" step="1" class="form-control" id="pQuantity" name="quantity" value="<%= product.getQuantity()%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="image" class="form-label">Product Image</label>
                        <input type="hidden" value="<%= product.getImage()%>" name="oldImage">
                        <input type="file" class="form-control" name="newImage">
                    </div>
                    <div class="mb-3">
                        <label for="type" class="form-label">Category Name</label>
                        <select class="form-select" for="type" name="typeId">
                            <%
                                ProductTypeDAO dao = new ProductTypeDAO();
                                List<ProductType> types = dao.getAll();
                                for (ProductType type : types){ 
                            %>
                            <option <%= (type.getId() == product.getType().getId()) ? "selected" : ""%> value="<%= type.getId()%>"><%= type.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <a href="Product" class="btn btn-secondary" id="back">Back</a>
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
