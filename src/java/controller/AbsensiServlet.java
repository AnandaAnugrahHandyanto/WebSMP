package controller;

import dao.AbsensiDAO;
import model.Absensi;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AbsensiServlet", urlPatterns = {"/AbsensiServlet"})
public class AbsensiServlet extends HttpServlet {

    private AbsensiDAO absensiDAO = new AbsensiDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("hapus".equals(request.getParameter("action"))) {
            absensiDAO.hapus(Integer.parseInt(request.getParameter("id")));
        }
        response.sendRedirect("tampil_absensi.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        Absensi a = new Absensi();
        a.setIdSiswa(Integer.parseInt(request.getParameter("id_siswa")));
        a.setTanggal(request.getParameter("tanggal"));
        a.setStatus(request.getParameter("status"));
        a.setKeterangan(request.getParameter("keterangan"));

        if ("simpan".equals(action)) {
            absensiDAO.simpan(a);
        } else if ("edit".equals(action)) {
            a.setIdAbsensi(Integer.parseInt(request.getParameter("id")));
            absensiDAO.update(a);
        }
        response.sendRedirect("tampil_absensi.jsp");
    }
}