<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Forgot Password</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(to right, #4facfe, #00f2fe);
                height: 100vh;
            }

            .card {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .brand {
                font-size: 28px;
                font-weight: bold;
                color: #4facfe;
            }

            .btn-custom {
                background-color: #4facfe;
                border: none;
            }

            .btn-custom:hover {
                background-color: #007bff;
            }
        </style>
    </head>

    <body>

        <div class="container d-flex justify-content-center align-items-center" style="height:100vh;">
            <div class="card p-4" style="width: 400px;">

                <h3 class="text-center mb-3 brand">Forgot Password</h3>

                <!-- ERROR -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/forgot" method="post">
                    <div class="mb-3">
                        <label class="form-label">Enter your username</label>
                        <input type="text" name="username" class="form-control" placeholder="Username" required>
                    </div>
                    <button type="submit" class="btn btn-custom w-100 text-white">Send Request</button>
                </form>

                <div class="text-center mt-3">
                    <a href="login.jsp" class="text-decoration-none">← Back to Login</a>
                </div>

            </div>
        </div>

    </body>
</html>