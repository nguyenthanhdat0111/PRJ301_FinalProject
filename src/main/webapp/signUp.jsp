<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Sign Up Page</title>

        <style>
            body {
                background: linear-gradient(to right, #43e97b, #38f9d7);
                height: 100vh;
            }

            .signup-box {
                max-width: 1000px;
                margin: auto;
                margin-top: 50px;
            }

            .card {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .brand {
                font-size: 28px;
                font-weight: bold;
                color: #43e97b;
            }

            .btn-custom {
                background-color: #43e97b;
                border: none;
            }

            .btn-custom:hover {
                background-color: #2ecc71;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" /> 

        <div class="container signup-box">
            <div class="card p-4">
                <div class="row">

                    <!-- LEFT SIDE -->
                    <div class="col-md-6 d-none d-md-flex flex-column justify-content-center align-items-center">
                        <h2 class="brand">🛒 MyShop</h2>
                        <p class="text-muted">Create your account and start shopping!</p>
                        <img src="https://cdn-icons-png.flaticon.com/512/2920/2920222.png" width="150">
                    </div>

                    <!-- RIGHT SIDE -->
                    <div class="col-md-6">
                        <h3 class="text-center mb-4">Sign Up</h3>

                        <form method="post" action="SignUp">

                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="username"
                                       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : ""%>"
                                       required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullname"
                                       value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : ""%>"
                                       required>
                            </div>

                            <!-- EMAIL -->
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email"
                                       placeholder="Enter your email"
                                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : ""%>"
                                       required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>

                            <!-- GENDER -->
                            <div class="mb-3">
                                <label class="form-label d-block">Gender</label>
                                <input type="radio" name="gender" value="Male" required> Male
                                <input type="radio" name="gender" value="Female" required> Female
                            </div>

                            <!-- ERROR -->
                            <%
                                if (request.getAttribute("err") != null) {
                            %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("err")%>
                            </div>
                            <%
                                }
                            %>

                            <button type="submit" class="btn btn-success w-100">Sign Up</button>
                        </form>

                        <p class="text-center mt-3">
                            Already have account? <a href="Login">Login</a>
                        </p>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>