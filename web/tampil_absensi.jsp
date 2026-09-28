<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.AbsensiDAO, model.Absensi, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Absensi");
    List<Absensi> listAbsensi = new AbsensiDAO().getAll();
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
                    <h1 class="page-title">Data Absensi</h1>
                    <p class="page-subtitle">Total <%= listAbsensi.size() %> catatan kehadiran</p>
                </div>
                <a href="input_absensi.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Input Absensi
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>Tanggal</th>
                                    <th>Siswa</th>
                                    <th>Kelas</th>
                                    <th>Status</th>
                                    <th>Keterangan</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listAbsensi.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="7" class="text-center text-secondary py-5">Belum ada data absensi</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Absensi a : listAbsensi) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td class="text-secondary"><%= a.getTanggal() %></td>
                                    <td class="fw-semibold"><%= a.getNamaSiswa() %></td>
                                    <td><%= a.getKelas() == null ? "-" : a.getKelas() %></td>
                                    <td>
                                        <%
                                            String warna = "Hadir".equals(a.getStatus()) ? "#d1fae5;color:#047857"
                                                    : "Sakit".equals(a.getStatus()) ? "#fef3c7;color:#b45309"
                                                    : "Izin".equals(a.getStatus()) ? "#dbeafe;color:#1d4ed8"
                                                    : "#fee2e2;color:#b91c1c";
                                        %>
                                        <span class="badge-soft" style="background:<%= warna %>;"><%= a.getStatus() %></span>
                                    </td>
                                    <td class="text-secondary"><%= a.getKeterangan() == null || a.getKeterangan().isEmpty() ? "-" : a.getKeterangan() %></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_absensi.jsp?id=<%= a.getIdAbsensi() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="AbsensiServlet?action=hapus&id=<%= a.getIdAbsensi() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus data absensi ini?')">
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