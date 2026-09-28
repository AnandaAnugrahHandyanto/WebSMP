package controller;

import dao.GuruDAO;
import model.Guru;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GuruServlet", urlPatterns = {"/GuruServlet"})
public class GuruServlet extends HttpServlet {

    private GuruDAO guruDAO = new GuruDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("tampil_guru.jsp");
            return;
        }
        
        if (action.equals("hapus")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                guruDAO.hapus(id);
            } catch (NumberFormatException e) {
                // Log error or redirect with message
            }
            response.sendRedirect("tampil_guru.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String nip = request.getParameter("nip");
        String namaGuru = request.getParameter("nama_guru");
        String jenisKelamin = request.getParameter("jenis_kelamin");
        String noHp = request.getParameter("no_hp");
        
        Guru guru = new Guru();
        guru.setNip(nip);
        guru.setNamaGuru(namaGuru);
        guru.setJenisKelamin(jenisKelamin);
        guru.setNoHp(noHp);
        
        if (action.equals("simpan")) {
            guruDAO.simpan(guru);
        } else if (action.equals("edit")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                guru.setIdGuru(id);
                guruDAO.update(guru);
            } catch (NumberFormatException e) {
                // Log error or redirect with message
            }
        }
        
        response.sendRedirect("tampil_guru.jsp");
    }
}
