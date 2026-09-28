<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SiswaDAO, model.Siswa, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Input Absensi");
    List<Siswa> listSiswa = new SiswaDAO().getAll();
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
                <h1 class="page-title">Input Absensi</h1>
                <p class="page-subtitle">Catat kehadiran siswa per hari</p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="AbsensiServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="simpan">
                        <div class="col-md-8">
                            <label for="idSiswa" class="form-label">Siswa</label>
                            <select id="idSiswa" name="id_siswa" class="form-select" required>
                                <option value="">-- Pilih Siswa --</option>
                                <%
                                    for (Siswa s : listSiswa) {
                                %>
                                <option value="<%= s.getIdSiswa() %>"><%= s.getNis() %> - <%= s.getNamaSiswa() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="tanggal" class="form-label">Tanggal</label>
                            <input type="date" id="tanggal" name="tanggal" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="status" class="form-label">Status</label>
                            <select id="status" name="status" class="form-select" required>
                                <option value="Hadir">Hadir</option>
                                <option value="Sakit">Sakit</option>
                                <option value="Izin">Izin</option>
                                <option value="Alpa">Alpa</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="keterangan" class="form-label">Keterangan</label>
                            <input type="text" id="keterangan" name="keterangan" class="form-control">
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Simpan
                            </button>
                            <a href="tampil_absensi.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>