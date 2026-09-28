<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.GuruDAO, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Guru");
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
            <div class="page-header d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <h1 class="page-title">Data Guru</h1>
                    <p class="page-subtitle">Total <%= listGuru.size() %> guru terdaftar</p>
                </div>
                <a href="input_guru.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Tambah Guru
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>NIP</th>
                                    <th>Nama Guru</th>
                                    <th>Jenis Kelamin</th>
                                    <th>No HP</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listGuru.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center text-secondary py-5">Belum ada data guru</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Guru g : listGuru) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td class="fw-semibold"><%= g.getNip() %></td>
                                    <td><%= g.getNamaGuru() %></td>
                                    <td>
                                        <span class="badge-soft" style="background:<%= "P".equals(g.getJenisKelamin()) ? "#fce7f3;color:#db2777" : "#dbeafe;color:#2563eb" %>;">
                                            <%= "P".equals(g.getJenisKelamin()) ? "Perempuan" : "Laki-laki" %>
                                        </span>
                                    </td>
                                    <td class="text-secondary"><%= g.getNoHp() == null ? "-" : g.getNoHp() %></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_guru.jsp?id=<%= g.getIdGuru() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="GuruServlet?action=hapus&id=<%= g.getIdGuru() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus data guru ini?')">
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