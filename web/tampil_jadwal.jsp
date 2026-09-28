<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.JadwalDAO, model.Jadwal, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Jadwal");
    List<Jadwal> listJadwal = new JadwalDAO().getAll();
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
            <div class="page-header d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <h1 class="page-title">Jadwal Pelajaran</h1>
                    <p class="page-subtitle">Total <%= listJadwal.size() %> sesi jadwal</p>
                </div>
                <a href="input_jadwal.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Tambah Jadwal
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>Hari</th>
                                    <th>Jam</th>
                                    <th>Kelas</th>
                                    <th>Mata Pelajaran</th>
                                    <th>Guru</th>
                                    <th>Ruang</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listJadwal.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="8" class="text-center text-secondary py-5">Belum ada jadwal</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Jadwal j : listJadwal) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td><span class="badge-soft" style="background:#eef2ff;color:#4F46E5;"><%= j.getHari() %></span></td>
                                    <td class="text-secondary"><%= j.getJamMulai() %> - <%= j.getJamSelesai() %></td>
                                    <td class="fw-semibold"><%= j.getNamaKelas() %></td>
                                    <td><%= j.getNamaMapel() %></td>
                                    <td><%= j.getNamaGuru() %></td>
                                    <td class="text-secondary"><%= j.getRuang() == null ? "-" : j.getRuang() %></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_jadwal.jsp?id=<%= j.getIdJadwal() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="JadwalServlet?action=hapus&id=<%= j.getIdJadwal() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus jadwal ini?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>