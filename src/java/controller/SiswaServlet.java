package controller;

import dao.SiswaDAO;
import model.Siswa;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SiswaServlet", urlPatterns = {"/SiswaServlet"})
public class SiswaServlet extends HttpServlet {

    private SiswaDAO siswaDAO = new SiswaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("tampil_siswa.jsp");
            return;
        }
        
        if (action.equals("hapus")) {
            int id = Integer.parseInt(request.getParameter("id"));
            siswaDAO.hapus(id);
            response.sendRedirect("tampil_siswa.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String nis = request.getParameter("nis");
        String namaSiswa = request.getParameter("nama_siswa");
        String jenisKelamin = request.getParameter("jenis_kelamin");
        String tanggalLahir = request.getParameter("tanggal_lahir");
        String alamat = request.getParameter("alamat");
        String noHp = request.getParameter("no_hp");
        String idKelasStr = request.getParameter("id_kelas");
        
        Siswa siswa = new Siswa();
        siswa.setNis(nis);
        siswa.setNamaSiswa(namaSiswa);
        siswa.setJenisKelamin(jenisKelamin);
        siswa.setTanggalLahir(tanggalLahir);
        siswa.setAlamat(alamat);
        siswa.setNoHp(noHp);
        
        // Handle id_kelas (bisa null atau kosong)
        if (idKelasStr != null && !idKelasStr.isEmpty()) {
            siswa.setIdKelas(Integer.parseInt(idKelasStr));
        }
        
        if (action.equals("simpan")) {
            siswaDAO.simpan(siswa);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            siswa.setIdSiswa(id);
            siswaDAO.update(siswa);
        }
        
        response.sendRedirect("tampil_siswa.jsp");
    }
}