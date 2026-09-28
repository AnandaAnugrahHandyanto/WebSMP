package controller;

import dao.MapelDAO;
import model.Mapel;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "MapelServlet", urlPatterns = {"/MapelServlet"})
public class MapelServlet extends HttpServlet {
    private MapelDAO mapelDAO = new MapelDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("hapus".equals(action)) {
            mapelDAO.hapus(Integer.parseInt(request.getParameter("id")));
        }
        response.sendRedirect("tampil_mapel.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Mapel m = new Mapel();
        m.setKodeMapel(request.getParameter("kode_mapel"));
        m.setNamaMapel(request.getParameter("nama_mapel"));
        m.setKkm(Integer.parseInt(request.getParameter("kkm")));

        String idGuru = request.getParameter("id_guru");
        if (idGuru != null && !idGuru.isEmpty()) {
            m.setIdGuruPengampu(Integer.parseInt(idGuru));
        }

        if ("simpan".equals(action)) {
            mapelDAO.simpan(m);
        } else if ("edit".equals(action)) {
            m.setIdMapel(Integer.parseInt(request.getParameter("id")));
            mapelDAO.update(m);
        }
        response.sendRedirect("tampil_mapel.jsp");
    }
}