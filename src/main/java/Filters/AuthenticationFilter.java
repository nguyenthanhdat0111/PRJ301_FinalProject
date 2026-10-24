package Filters;

import Models.User;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        boolean loginRequest = uri.equals(req.getContextPath() + "/Login");
        boolean signUpRequest = uri.equals(req.getContextPath() + "/SignUp");

        boolean forgotPage = uri.contains("forgot.jsp");
        boolean resetPage = uri.contains("reset.jsp");
        boolean forgotServlet = uri.contains("/forgot");
        boolean resetServlet = uri.contains("/reset");

        boolean resourceRequest = uri.startsWith(req.getContextPath() + "/resources");

        boolean loggedIn = false;
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            loggedIn = (user != null);
        }

        if (loginRequest
                || signUpRequest
                || resourceRequest
                || forgotPage
                || resetPage
                || forgotServlet
                || resetServlet
                || loggedIn) {

            chain.doFilter(request, response); // cho đi tiếp

        } else {
            res.sendRedirect(req.getContextPath() + "/Login"); // chặn
        }
    }

    @Override
    public void destroy() {
    }
}
