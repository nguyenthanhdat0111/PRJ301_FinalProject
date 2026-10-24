<%@page import="Models.ProductType"%>
<%@page import="DAOs.ProductTypeDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Create Product</title>

        <style>
            body {
                background: #f4f6f9;
            }

            .form-card {
                max-width: 800px;
                margin: auto;
                margin-top: 50px;
                border-radius: 15px;
                padding: 25px;
                background: white;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .preview-img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 10px;
                border: 1px solid #ddd;
                margin-top: 10px;
                display: none;
            }

            .btn-custom {
                border-radius: 20px;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="form-card">

            <h3 class="text-center mb-4">📦 Create Product</h3>

            <form method="POST" action="Product?action=create" enctype="multipart/form-data">

                <!-- NAME -->
                <div class="mb-3">
                    <label class="form-label">Product Name</label>
                    <input type="text" class="form-control" name="name"
                           placeholder="Enter product name" required>
                </div>

                <!-- DESCRIPTION -->
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <input type="text" class="form-control" name="description"
                           placeholder="Enter product description" required>
                </div>

                <!-- ROW PRICE + QUANTITY -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Price</label>
                        <input type="number" min="0" step="1000"
                               class="form-control" name="price" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Quantity</label>
                        <input type="number" min="0"
                               class="form-control" name="quantity" required>
                    </div>
                </div>

                <!-- IMAGE -->
                <div class="mb-3">
                    <label class="form-label">Product Image</label>
                    <input type="file" class="form-control" name="image" id="imageInput" required>

                    <!-- PREVIEW -->
                    <img id="preview" class="preview-img">
                </div>

                <!-- CATEGORY -->
                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select class="form-select" name="typeId">
                        <%
                            ProductTypeDAO dao = new ProductTypeDAO();
                            List<ProductType> types = dao.getAll();
                            for (ProductType type : types) {
                        %>
                        <option value="<%= type.getId()%>">
                            <%= type.getName()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

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
                        Back
                    </a>

                    <button type="submit" class="btn btn-success btn-custom">
                        Create
                    </button>
                </div>

            </form>

        </div>

        <!-- PREVIEW SCRIPT -->
        <script>
            const input = document.getElementById('imageInput');
            const preview = document.getElementById('preview');

            input.addEventListener('change', function () {
                const file = this.files[0];
                if (file) {
                    preview.style.display = "block";
                    preview.src = URL.createObjectURL(file);
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>