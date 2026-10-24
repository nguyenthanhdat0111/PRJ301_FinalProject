<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reset Password</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(135deg, #74ebd5, #ACB6E5);
                height: 100vh;
            }

            .reset-card {
                max-width: 400px;
                margin: auto;
                margin-top: 100px;
                padding: 30px;
                border-radius: 15px;
                background: white;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }

            .btn-custom {
                border-radius: 25px;
            }
        </style>
    </head>

    <body>

        <div class="reset-card">

            <h3 class="text-center mb-4">🔐 Reset Password</h3>

            <!-- ERROR -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/reset" method="post">
                <input type="hidden" name="username" value="${username}">
                <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter new password" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" name="confirm" class="form-control" placeholder="Re-enter password" required>
                </div>
                <button type="submit" class="btn btn-success w-100 btn-custom">Reset Password</button>
            </form>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>