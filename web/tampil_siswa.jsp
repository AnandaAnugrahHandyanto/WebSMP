<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SiswaDAO, model.Siswa, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Siswa");
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
            <div class="page-header d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <h1 class="page-title">Data Siswa</h1>
                    <p class="page-subtitle">Total <%= listSiswa.size() %> siswa terdaftar</p>
                </div>
                <a href="input_siswa.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Tambah Siswa
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>NIS</th>
                                    <th>Nama Siswa</th>
                                    <th>Jenis Kelamin</th>
                                    <th>Kelas</th>
                                    <th>Alamat</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listSiswa.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="7" class="text-center text-secondary py-5">Belum ada data siswa</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Siswa s : listSiswa) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td class="fw-semibold"><%= s.getNis() %></td>
                                    <td><%= s.getNamaSiswa() %></td>
                                    <td>
                                        <span class="badge-soft" style="background:<%= "P".equals(s.getJenisKelamin()) ? "#fce7f3;color:#db2777" : "#dbeafe;color:#2563eb" %>;">
                                            <%= "P".equals(s.getJenisKelamin()) ? "Perempuan" : "Laki-laki" %>
                                        </span>
                                    </td>
                                    <td><%= s.getNamaKelas() == null ? "-" : s.getNamaKelas() %></td>
                                    <td class="text-secondary"><%= s.getAlamat() == null ? "-" : s.getAlamat() %></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_siswa.jsp?id=<%= s.getIdSiswa() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="SiswaServlet?action=hapus&id=<%= s.getIdSiswa() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus data siswa ini?')">
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