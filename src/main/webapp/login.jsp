<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Login Page</title>

        <style>
            body {
                background: linear-gradient(to right, #4facfe, #00f2fe);
                height: 100vh;
            }

            .login-box {
                max-width: 900px;
                margin: auto;
                margin-top: 80px;
            }

            .card {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .brand {
                font-size: 30px;
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

        <jsp:include page="header.jsp" /> 

        <div class="container login-box">
            <div class="card p-4">
                <div class="row">

                    <!-- LEFT SIDE -->
                    <div class="col-md-6 d-none d-md-flex flex-column justify-content-center align-items-center">
                        <h2 class="brand">🛒 MyShop</h2>
                        <p class="text-muted">Buy everything you need!</p>
                        <img src="https://cdn-icons-png.flaticon.com/512/3081/3081559.png" width="150">
                    </div>

                    <!-- RIGHT SIDE -->
                    <div class="col-md-6">
                        <h3 class="text-center mb-4">Login</h3>

                        <form method="post" action="Login">

                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="username" placeholder="Enter Username" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                            </div>

                            <!-- SUCCESS MESSAGE -->
                            <% if (request.getAttribute("success") != null) { %>
                            <div class="alert alert-success p-2"><%= request.getAttribute("success")%></div>
                            <% } %>
                            <!-- ERROR MESSAGE -->
                            <%
                                if (request.getAttribute("err") != null) {
                                    String err = (String) request.getAttribute("err");
                            %>
                            <div class="alert alert-danger p-2">
                                <%= err%>
                            </div>
                            <%
                                }
                            %>

                            <div class="d-flex justify-content-between mb-3">
                                <div>
                                    <input type="checkbox"> Remember me
                                </div>
                                <a href="forgot.jsp">Forgot Password?</a>
                            </div>

                            <button type="submit" class="btn btn-custom w-100 text-white">
                                Login
                            </button>
                        </form>

                        <p class="text-center mt-3">
                            Don't have account? <a href="SignUp">Sign up</a>
                        </p>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>