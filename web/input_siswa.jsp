<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.KelasDAO, model.Kelas, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Tambah Siswa");
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
                <h1 class="page-title">Tambah Siswa</h1>
                <p class="page-subtitle">Lengkapi data siswa baru</p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="SiswaServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="simpan">
                        <div class="col-md-6">
                            <label for="nis" class="form-label">NIS</label>
                            <input type="text" id="nis" name="nis" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="namaSiswa" class="form-label">Nama Siswa</label>
                            <input type="text" id="namaSiswa" name="nama_siswa" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="jenisKelamin" class="form-label">Jenis Kelamin</label>
                            <select id="jenisKelamin" name="jenis_kelamin" class="form-select" required>
                                <option value="L">Laki-laki</option>
                                <option value="P">Perempuan</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="tanggalLahir" class="form-label">Tanggal Lahir</label>
                            <input type="date" id="tanggalLahir" name="tanggal_lahir" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label for="noHp" class="form-label">No HP</label>
                            <input type="text" id="noHp" name="no_hp" class="form-control" placeholder="08xxxxxxxxxx">
                        </div>
                        <div class="col-md-6">
                            <label for="idKelas" class="form-label">Kelas</label>
                            <select id="idKelas" name="id_kelas" class="form-select">
                                <option value="">-- Pilih Kelas --</option>
                                <%
                                    for (Kelas k : listKelas) {
                                %>
                                <option value="<%= k.getIdKelas() %>"><%= k.getNamaKelas() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="alamat" class="form-label">Alamat</label>
                            <textarea id="alamat" name="alamat" class="form-control" rows="3"></textarea>
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Simpan
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