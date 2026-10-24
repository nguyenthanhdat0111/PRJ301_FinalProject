<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Create Product Type</title>

        <style>
            body {
                background: #f4f6f9;
            }

            .form-card {
                max-width: 600px;
                margin: auto;
                margin-top: 60px;
                border-radius: 15px;
                padding: 25px;
                background: white;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .preview-img {
                width: 100%;
                height: 200px;
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

            <h3 class="text-center mb-4">📂 Create Product Type</h3>

            <form method="POST" action="ProductType?action=create" enctype="multipart/form-data">

                <!-- NAME -->
                <div class="mb-3">
                    <label class="form-label">Product Type Name</label>
                    <input type="text" class="form-control" name="name"
                           placeholder="Enter product type name" required>
                </div>

                <!-- IMAGE -->
                <div class="mb-3">
                    <label class="form-label">Product Image</label>
                    <input type="file" class="form-control" name="image" id="imageInput" required>

                    <!-- PREVIEW -->
                    <img id="preview" class="preview-img">
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
                    <a href="ProductType" class="btn btn-secondary btn-custom">
                        Back
                    </a>

                    <button type="submit" class="btn btn-success btn-custom">
                        Create
                    </button>
                </div>

            </form>

        </div>

        <!-- SCRIPT PREVIEW IMAGE -->
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