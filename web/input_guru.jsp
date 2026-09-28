<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Tambah Guru");
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
                <h1 class="page-title">Tambah Guru</h1>
                <p class="page-subtitle">Lengkapi data guru baru</p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="GuruServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="simpan">
                        <div class="col-md-6">
                            <label for="nip" class="form-label">NIP</label>
                            <input type="text" id="nip" name="nip" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="jenisKelamin" class="form-label">Jenis Kelamin</label>
                            <select id="jenisKelamin" name="jenis_kelamin" class="form-select" required>
                                <option value="L">Laki-laki</option>
                                <option value="P">Perempuan</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="namaGuru" class="form-label">Nama Guru</label>
                            <input type="text" id="namaGuru" name="nama_guru" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label for="noHp" class="form-label">No HP</label>
                            <input type="text" id="noHp" name="no_hp" class="form-control" placeholder="08xxxxxxxxxx">
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Simpan
                            </button>
                            <a href="tampil_guru.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>