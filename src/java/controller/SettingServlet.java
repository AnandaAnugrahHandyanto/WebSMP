package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SettingServlet", urlPatterns = {"/SettingServlet"})
public class SettingServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("delete".equals(request.getParameter("action"))) {
            userDAO.hapus(Integer.parseInt(request.getParameter("id")));
        }
        response.sendRedirect("setting_user.jsp?sukses=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("ganti-password".equals(action)) {
            handleGantiPassword(request, response);
            return;
        }

        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        userDAO.simpan(user);
        response.sendRedirect("setting_user.jsp?sukses=true");
    }

    private void handleGantiPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Object sessionId = request.getSession().getAttribute("idUser");
        if (!(sessionId instanceof Integer)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String passwordBaru = request.getParameter("password_baru");
        String konfirmasi = request.getParameter("konfirmasi_password");

        if (passwordBaru == null || !passwordBaru.equals(konfirmasi)) {
            response.sendRedirect("setting_password.jsp?error=konfirmasi");
            return;
        }

        userDAO.gantiPassword((Integer) sessionId, passwordBaru);
        response.sendRedirect("setting_password.jsp?sukses=true");
    }
}