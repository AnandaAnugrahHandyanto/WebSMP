package controller;

import dao.KelasDAO;
import model.Kelas;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "KelasServlet", urlPatterns = {"/KelasServlet"})
public class KelasServlet extends HttpServlet {

    private KelasDAO kelasDAO = new KelasDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("tampil_kelas.jsp");
            return;
        }
        
        if (action.equals("hapus")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                kelasDAO.hapus(id);
            } catch (NumberFormatException e) {
                // Log error or redirect with message
            }
            response.sendRedirect("tampil_kelas.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String namaKelas = request.getParameter("nama_kelas");
        String idWaliKelasStr = request.getParameter("id_wali_kelas");
        
        Kelas kelas = new Kelas();
        kelas.setNamaKelas(namaKelas);

        if (idWaliKelasStr != null && !idWaliKelasStr.isEmpty()) {
            kelas.setIdWaliKelas(Integer.parseInt(idWaliKelasStr));
        }

        if (action.equals("simpan")) {
            kelasDAO.simpan(kelas);
        } else if (action.equals("edit")) {
            kelas.setIdKelas(Integer.parseInt(request.getParameter("id")));
            kelasDAO.update(kelas);
        }
        
        response.sendRedirect("tampil_kelas.jsp");
    }
}
