<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.GuruDAO, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Guru> listGuru = new GuruDAO().getAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tambah Kelas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="tampil_siswa.jsp">Data Siswa</a>
                    <a class="nav-link" href="tampil_guru.jsp">Data Guru</a>
                    <a class="nav-link active" href="tampil_kelas.jsp">Data Kelas</a>
                    <a class="btn btn-danger btn-sm ms-3" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2>Tambah Kelas Baru</h2>
            <div class="card mt-3">
                <div class="card-body">
                    <form action="KelasServlet" method="POST">
                        <input type="hidden" name="action" value="simpan">
                        <div class="mb-3">
                            <label for="namaKelas" class="form-label">Nama Kelas</label>
                            <input type="text" id="namaKelas" name="nama_kelas" class="form-control" placeholder="Contoh: VII A" required>
                        </div>
                        <div class="mb-3">
                            <label for="idWaliKelas" class="form-label">Wali Kelas</label>
                            <select id="idWaliKelas" name="id_wali_kelas" class="form-select">
                                <option value="">-- Pilih Wali Kelas --</option>
                                <%
                                    for (Guru g : listGuru) {
                                %>
                                <option value="<%= g.getIdGuru() %>"><%= g.getNamaGuru() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Simpan</button>
                        <a href="tampil_kelas.jsp" class="btn btn-secondary">Batal</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>