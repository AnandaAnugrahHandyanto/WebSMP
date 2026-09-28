package controller;

import dao.JadwalDAO;
import model.Jadwal;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "JadwalServlet", urlPatterns = {"/JadwalServlet"})
public class JadwalServlet extends HttpServlet {

    private JadwalDAO jadwalDAO = new JadwalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("hapus".equals(request.getParameter("action"))) {
            jadwalDAO.hapus(Integer.parseInt(request.getParameter("id")));
        }
        response.sendRedirect("tampil_jadwal.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        Jadwal j = new Jadwal();
        j.setIdKelas(Integer.parseInt(request.getParameter("id_kelas")));
        j.setIdMapel(Integer.parseInt(request.getParameter("id_mapel")));
        j.setIdGuru(Integer.parseInt(request.getParameter("id_guru")));
        j.setHari(request.getParameter("hari"));
        j.setJamMulai(request.getParameter("jam_mulai"));
        j.setJamSelesai(request.getParameter("jam_selesai"));
        j.setRuang(request.getParameter("ruang"));

        if ("simpan".equals(action)) {
            jadwalDAO.simpan(j);
        } else if ("edit".equals(action)) {
            j.setIdJadwal(Integer.parseInt(request.getParameter("id")));
            jadwalDAO.update(j);
        }
        response.sendRedirect("tampil_jadwal.jsp");
    }
}