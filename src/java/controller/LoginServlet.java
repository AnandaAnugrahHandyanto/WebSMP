package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.login(username, password);

        if (user == null) {
            response.sendRedirect("login.jsp?error=true");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user.getUsername());
        session.setAttribute("role", user.getRole());
        session.setAttribute("idUser", user.getIdUser());

        if ("guru".equals(user.getRole())) {
            response.sendRedirect("guru_dashboard.jsp");
        } else if ("siswa".equals(user.getRole())) {
            response.sendRedirect("siswa_dashboard.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}