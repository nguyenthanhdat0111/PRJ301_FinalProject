<%@page import="Models.Product"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product Page</title>
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="w-75 m-auto">
                <h1>Add Quantity Product</h1>
                <form method="POST" action="Product?action=add">
                    <div class="mb-3">
                        <label for="type" class="form-label">Product Name</label>
                        <select class="form-select" for="type" name="id">
                            <%
                                ProductDAO dao = new ProductDAO();
                                List<Product> products = dao.getAll();
                                for (Product pro : products) {
                            %>
                            <option value="<%= pro.getId()%>"><%= pro.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Product Quantity</label>
                        <input type="number" min="1" step="1" class="form-control" id="quantity" name="quantity" required>
                    </div>
                    <a href="Product" class="btn btn-secondary" id="back">Back</a>
                    <button type="submit" class="btn btn-success" id="submit">Create</button>
                </form>
                <%
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
