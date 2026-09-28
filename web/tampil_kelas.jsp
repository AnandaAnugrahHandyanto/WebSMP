<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.KelasDAO, model.Kelas, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Kelas");
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
            <div class="page-header d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <h1 class="page-title">Data Kelas</h1>
                    <p class="page-subtitle">Total <%= listKelas.size() %> kelas terdaftar</p>
                </div>
                <a href="input_kelas.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Tambah Kelas
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>Nama Kelas</th>
                                    <th>Wali Kelas</th>
                                    <th>Jumlah Siswa</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listKelas.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-secondary py-5">Belum ada data kelas</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Kelas k : listKelas) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td class="fw-semibold"><%= k.getNamaKelas() %></td>
                                    <td><%= k.getNamaWaliKelas() == null ? "-" : k.getNamaWaliKelas() %></td>
                                    <td>
                                        <span class="badge-soft" style="background:#eef2ff;color:#4F46E5;">
                                            <%= k.getJumlahSiswa() %> siswa
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_kelas.jsp?id=<%= k.getIdKelas() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="KelasServlet?action=hapus&id=<%= k.getIdKelas() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus kelas ini? Siswa di dalamnya akan kehilangan kelas.')">
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