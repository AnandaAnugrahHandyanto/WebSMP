<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.GuruDAO, model.Guru"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    GuruDAO guruDAO = new GuruDAO();
    Guru guru = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));
        guru = guruDAO.getById(id);
    } catch (NumberFormatException e) {
        // Handle invalid ID format
    }

    if (guru == null) {
        response.sendRedirect("tampil_guru.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Guru - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="tampil_guru.jsp">Data Guru</a>
                    <a class="nav-link" href="tampil_siswa.jsp">Data Siswa</a>
                    <a class="btn btn-danger btn-sm ms-3" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2>Edit Guru</h2>
            <div class="card mt-3">
                <div class="card-body">
                    <form action="GuruServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= guru.getIdGuru() %>">
                        <div class="mb-3">
                            <label for="nip" class="form-label">NIP</label>
                            <input type="text" id="nip" name="nip" class="form-control" value="<%= guru.getNip() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="namaGuru" class="form-label">Nama Guru</label>
                            <input type="text" id="namaGuru" name="nama_guru" class="form-control" value="<%= guru.getNamaGuru() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="jenisKelamin" class="form-label">Jenis Kelamin</label>
                            <select id="jenisKelamin" name="jenis_kelamin" class="form-select" required>
                                <option value="L" <%= "L".equals(guru.getJenisKelamin()) ? "selected" : "" %>>Laki-laki</option>
                                <option value="P" <%= "P".equals(guru.getJenisKelamin()) ? "selected" : "" %>>Perempuan</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="noHp" class="form-label">No HP</label>
                            <input type="text" id="noHp" name="no_hp" class="form-control" value="<%= guru.getNoHp() == null ? "" : guru.getNoHp() %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Update</button>
                        <a href="tampil_guru.jsp" class="btn btn-secondary">Batal</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>