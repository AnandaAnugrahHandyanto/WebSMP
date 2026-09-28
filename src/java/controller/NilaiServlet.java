package controller;

import dao.NilaiDAO;
import model.Nilai;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "NilaiServlet", urlPatterns = {"/NilaiServlet"})
public class NilaiServlet extends HttpServlet {

    private NilaiDAO nilaiDAO = new NilaiDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if ("hapus".equals(request.getParameter("action"))) {
            nilaiDAO.hapus(Integer.parseInt(request.getParameter("id")));
        }
        response.sendRedirect("tampil_nilai.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        Nilai n = new Nilai();
        n.setIdSiswa(Integer.parseInt(request.getParameter("id_siswa")));
        n.setIdMapel(Integer.parseInt(request.getParameter("id_mapel")));
        n.setNilaiTugas(Integer.parseInt(request.getParameter("nilai_tugas")));
        n.setNilaiUts(Integer.parseInt(request.getParameter("nilai_uts")));
        n.setNilaiUas(Integer.parseInt(request.getParameter("nilai_uas")));

        double akhir = Nilai.hitungNilaiAkhir(n.getNilaiTugas(), n.getNilaiUts(), n.getNilaiUas());
        n.setNilaiAkhir(Math.round(akhir * 100.0) / 100.0);
        n.setPredikat(Nilai.hitungPredikat(n.getNilaiAkhir()));

        if ("simpan".equals(action)) {
            nilaiDAO.simpan(n);
        } else if ("edit".equals(action)) {
            n.setIdNilai(Integer.parseInt(request.getParameter("id")));
            nilaiDAO.update(n);
        }
        response.sendRedirect("tampil_nilai.jsp");
    }
}