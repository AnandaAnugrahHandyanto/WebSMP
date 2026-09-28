<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.KelasDAO, model.Kelas, java.util.List, dao.SiswaDAO, model.Siswa"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    SiswaDAO siswaDAO = new SiswaDAO();
    Siswa siswa = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));
        siswa = siswaDAO.getById(id);
    } catch (NumberFormatException e) {
        // Handle invalid ID format
    }

    if (siswa == null) {
        response.sendRedirect("tampil_siswa.jsp");
        return;
    }
    
    // Fetch list of classes dynamically for dropdown
    List<Kelas> listKelas = new KelasDAO().getAll();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Siswa - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="tampil_siswa.jsp">Data Siswa</a>
                    <a class="btn btn-danger btn-sm ms-3" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2>Edit Siswa</h2>
            <div class="card mt-3">
                <div class="card-body">
                    <form action="SiswaServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= siswa.getIdSiswa() %>">
                        <div class="mb-3">
                            <label for="nis" class="form-label">NIS</label>
                            <input type="text" id="nis" name="nis" class="form-control" value="<%= siswa.getNis() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="namaSiswa" class="form-label">Nama Siswa</label>
                            <input type="text" id="namaSiswa" name="nama_siswa" class="form-control" value="<%= siswa.getNamaSiswa() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="jenisKelamin" class="form-label">Jenis Kelamin</label>
                            <select id="jenisKelamin" name="jenis_kelamin" class="form-select" required>
                                <option value="L" <%= "L".equals(siswa.getJenisKelamin()) ? "selected" : "" %>>Laki-laki</option>
                                <option value="P" <%= "P".equals(siswa.getJenisKelamin()) ? "selected" : "" %>>Perempuan</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="tanggalLahir" class="form-label">Tanggal Lahir</label>
                            <input type="date" id="tanggalLahir" name="tanggal_lahir" class="form-control" value="<%= siswa.getTanggalLahir() == null ? "" : siswa.getTanggalLahir() %>">
                        </div>
                        <div class="mb-3">
                            <label for="alamat" class="form-label">Alamat</label>
                            <textarea id="alamat" name="alamat" class="form-control" rows="3"><%= siswa.getAlamat() %></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="noHp" class="form-label">No HP</label>
                            <input type="text" id="noHp" name="no_hp" class="form-control" value="<%= siswa.getNoHp() == null ? "" : siswa.getNoHp() %>">
                        </div>
                        <div class="mb-3">
                            <label for="idKelas" class="form-label">Kelas</label>
                            <select id="idKelas" name="id_kelas" class="form-select">
                                <option value="">-- Pilih Kelas --</option>
                                <%
                                    for (Kelas k : listKelas) {
                                %>
                                <option value="<%= k.getIdKelas() %>" <%= (k.getIdKelas() == siswa.getIdKelas()) ? "selected" : "" %>><%= k.getNamaKelas() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Update</button>
                        <a href="tampil_siswa.jsp" class="btn btn-secondary">Batal</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>