/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.SiswaDAO;
import model.Siswa;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author anandaanugrah
 */
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
        String nama = request.getParameter("nama");
        String kelas = request.getParameter("kelas");
        String alamat = request.getParameter("alamat");
        
        Siswa siswa = new Siswa();
        siswa.setNis(nis);
        siswa.setNama(nama);
        siswa.setKelas(kelas);
        siswa.setAlamat(alamat);
        
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