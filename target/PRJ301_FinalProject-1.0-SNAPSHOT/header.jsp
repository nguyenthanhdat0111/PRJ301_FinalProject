<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Models.User"%>

<%
    User currentUser = (User) session.getAttribute("user");
    boolean isAdmin = false;
    String text = "";
    String link = "";
    if (currentUser != null) {
        text = "Hi, " + currentUser.getUsername() + " | Logout";
        link = "Logout";
        isAdmin = "Admin".equals(currentUser.getRole());
    } else {
        text = "Login";
        link = "Login";
    }
    String currentPage = request.getRequestURI(); // e.g., /Project/Balance
%>

<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="Home">MyShop</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" 
                    aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <% if (isAdmin) {%>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/ProductType") ? "active" : ""%>" href="ProductType">Product Types</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/Product") ? "active" : ""%>" href="Product">Products</a>
                    </li>

                    <% } else {%>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/Home") ? "active" : ""%>" href="Home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/Cart") ? "active" : ""%>" href="Cart">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/Balance") ? "active" : ""%>" href="Balance">Balance</a>
                    </li>
                    <% }%>

                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/Order") ? "active" : ""%>" href="Order">Order</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPage.endsWith("/Payment") ? "active" : ""%>" href="Payment">Payment</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="<%= link%>"><%= text%></a>
                    </li>
                </ul>

                <form class="d-flex" role="search" method="GET" action="Home">
                    <input class="form-control me-2" type="search" placeholder="Search" name="search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
</header>