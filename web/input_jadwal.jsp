<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.KelasDAO, dao.MapelDAO, dao.GuruDAO, model.Kelas, model.Mapel, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Tambah Jadwal");
    List<Kelas> listKelas = new KelasDAO().getAll();
    List<Mapel> listMapel = new MapelDAO().getAll();
    List<Guru> listGuru = new GuruDAO().getAll();
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
                <h1 class="page-title">Tambah Jadwal</h1>
                <p class="page-subtitle">Atur sesi pelajaran mingguan</p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="JadwalServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="simpan">
                        <div class="col-md-6">
                            <label for="idKelas" class="form-label">Kelas</label>
                            <select id="idKelas" name="id_kelas" class="form-select" required>
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
                        <div class="col-md-6">
                            <label for="idMapel" class="form-label">Mata Pelajaran</label>
                            <select id="idMapel" name="id_mapel" class="form-select" required>
                                <option value="">-- Pilih Mapel --</option>
                                <%
                                    for (Mapel m : listMapel) {
                                %>
                                <option value="<%= m.getIdMapel() %>"><%= m.getNamaMapel() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idGuru" class="form-label">Guru</label>
                            <select id="idGuru" name="id_guru" class="form-select" required>
                                <option value="">-- Pilih Guru --</option>
                                <%
                                    for (Guru g : listGuru) {
                                %>
                                <option value="<%= g.getIdGuru() %>"><%= g.getNamaGuru() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="hari" class="form-label">Hari</label>
                            <select id="hari" name="hari" class="form-select" required>
                                <option>Senin</option>
                                <option>Selasa</option>
                                <option>Rabu</option>
                                <option>Kamis</option>
                                <option>Jumat</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="jamMulai" class="form-label">Jam Mulai</label>
                            <input type="time" id="jamMulai" name="jam_mulai" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label for="jamSelesai" class="form-label">Jam Selesai</label>
                            <input type="time" id="jamSelesai" name="jam_selesai" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label for="ruang" class="form-label">Ruang</label>
                            <input type="text" id="ruang" name="ruang" class="form-control" placeholder="Contoh: 7A">
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Simpan
                            </button>
                            <a href="tampil_jadwal.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>