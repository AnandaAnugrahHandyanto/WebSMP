<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SiswaDAO, dao.KelasDAO, model.Siswa, model.Kelas, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Siswa siswa = null;
    try {
        siswa = new SiswaDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (siswa == null) {
        response.sendRedirect("tampil_siswa.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Siswa");
    List<Kelas> listKelas = new KelasDAO().getAll();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <%@include file="fragment/head.jsp" %>
</head>
<body>
    <%@include file="fragment/sidebar.jsp" %>
    <div class="main-content">
        <%@include file="fragment/topbar.jsp" %>
        <div class="page-content">
            <div class="page-header">
                <h1 class="page-title">Edit Siswa</h1>
                <p class="page-subtitle">Perbarui data <%= siswa.getNamaSiswa() %></p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="SiswaServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= siswa.getIdSiswa() %>">
                        <div class="col-md-6">
                            <label for="nis" class="form-label">NIS</label>
                            <input type="text" id="nis" name="nis" class="form-control" value="<%= siswa.getNis() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="namaSiswa" class="form-label">Nama Siswa</label>
                            <input type="text" id="namaSiswa" name="nama_siswa" class="form-control" value="<%= siswa.getNamaSiswa() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="jenisKelamin" class="form-label">Jenis Kelamin</label>
                            <select id="jenisKelamin" name="jenis_kelamin" class="form-select" required>
                                <option value="L" <%= "L".equals(siswa.getJenisKelamin()) ? "selected" : "" %>>Laki-laki</option>
                                <option value="P" <%= "P".equals(siswa.getJenisKelamin()) ? "selected" : "" %>>Perempuan</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="tanggalLahir" class="form-label">Tanggal Lahir</label>
                            <input type="date" id="tanggalLahir" name="tanggal_lahir" class="form-control" value="<%= siswa.getTanggalLahir() == null ? "" : siswa.getTanggalLahir() %>">
                        </div>
                        <div class="col-md-6">
                            <label for="noHp" class="form-label">No HP</label>
                            <input type="text" id="noHp" name="no_hp" class="form-control" value="<%= siswa.getNoHp() == null ? "" : siswa.getNoHp() %>">
                        </div>
                        <div class="col-md-6">
                            <label for="idKelas" class="form-label">Kelas</label>
                            <select id="idKelas" name="id_kelas" class="form-select">
                                <option value="">-- Tanpa Kelas --</option>
                                <%
                                    for (Kelas k : listKelas) {
                                %>
                                <option value="<%= k.getIdKelas() %>" <%= k.getIdKelas() == siswa.getIdKelas() ? "selected" : "" %>><%= k.getNamaKelas() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="alamat" class="form-label">Alamat</label>
                            <textarea id="alamat" name="alamat" class="form-control" rows="3"><%= siswa.getAlamat() == null ? "" : siswa.getAlamat() %></textarea>
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
                            </button>
                            <a href="tampil_siswa.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>