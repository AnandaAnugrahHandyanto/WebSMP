<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.JadwalDAO, dao.KelasDAO, dao.MapelDAO, dao.GuruDAO, model.Jadwal, model.Kelas, model.Mapel, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Jadwal jadwal = null;
    try {
        jadwal = new JadwalDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (jadwal == null) {
        response.sendRedirect("tampil_jadwal.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Jadwal");
    List<Kelas> listKelas = new KelasDAO().getAll();
    List<Mapel> listMapel = new MapelDAO().getAll();
    List<Guru> listGuru = new GuruDAO().getAll();

    String jamMulai = jadwal.getJamMulai() != null && jadwal.getJamMulai().length() >= 5 ? jadwal.getJamMulai().substring(0, 5) : "";
    String jamSelesai = jadwal.getJamSelesai() != null && jadwal.getJamSelesai().length() >= 5 ? jadwal.getJamSelesai().substring(0, 5) : "";
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
                <h1 class="page-title">Edit Jadwal</h1>
                <p class="page-subtitle">Perbarui sesi <%= jadwal.getNamaMapel() %> di <%= jadwal.getNamaKelas() %></p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="JadwalServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= jadwal.getIdJadwal() %>">
                        <div class="col-md-6">
                            <label for="idKelas" class="form-label">Kelas</label>
                            <select id="idKelas" name="id_kelas" class="form-select" required>
                                <%
                                    for (Kelas k : listKelas) {
                                %>
                                <option value="<%= k.getIdKelas() %>" <%= k.getIdKelas() == jadwal.getIdKelas() ? "selected" : "" %>><%= k.getNamaKelas() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idMapel" class="form-label">Mata Pelajaran</label>
                            <select id="idMapel" name="id_mapel" class="form-select" required>
                                <%
                                    for (Mapel m : listMapel) {
                                %>
                                <option value="<%= m.getIdMapel() %>" <%= m.getIdMapel() == jadwal.getIdMapel() ? "selected" : "" %>><%= m.getNamaMapel() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idGuru" class="form-label">Guru</label>
                            <select id="idGuru" name="id_guru" class="form-select" required>
                                <%
                                    for (Guru g : listGuru) {
                                %>
                                <option value="<%= g.getIdGuru() %>" <%= g.getIdGuru() == jadwal.getIdGuru() ? "selected" : "" %>><%= g.getNamaGuru() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="hari" class="form-label">Hari</label>
                            <select id="hari" name="hari" class="form-select" required>
                                <%
                                    String[] hariList = {"Senin", "Selasa", "Rabu", "Kamis", "Jumat"};
                                    for (String h : hariList) {
                                %>
                                <option value="<%= h %>" <%= h.equals(jadwal.getHari()) ? "selected" : "" %>><%= h %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="jamMulai" class="form-label">Jam Mulai</label>
                            <input type="time" id="jamMulai" name="jam_mulai" class="form-control" value="<%= jamMulai %>" required>
                        </div>
                        <div class="col-md-4">
                            <label for="jamSelesai" class="form-label">Jam Selesai</label>
                            <input type="time" id="jamSelesai" name="jam_selesai" class="form-control" value="<%= jamSelesai %>" required>
                        </div>
                        <div class="col-md-4">
                            <label for="ruang" class="form-label">Ruang</label>
                            <input type="text" id="ruang" name="ruang" class="form-control" value="<%= jadwal.getRuang() == null ? "" : jadwal.getRuang() %>">
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
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