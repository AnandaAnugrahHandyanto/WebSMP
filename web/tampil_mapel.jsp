<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.MapelDAO, model.Mapel, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Mapel");
    List<Mapel> listMapel = new MapelDAO().getAll();
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
                    <h1 class="page-title">Data Mata Pelajaran</h1>
                    <p class="page-subtitle">Total <%= listMapel.size() %> mata pelajaran</p>
                </div>
                <a href="input_mapel.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Tambah Mapel
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>Kode</th>
                                    <th>Nama Mapel</th>
                                    <th>Guru Pengampu</th>
                                    <th>KKM</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listMapel.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center text-secondary py-5">Belum ada mata pelajaran</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Mapel m : listMapel) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td><span class="badge-soft" style="background:#eef2ff;color:#4F46E5;"><%= m.getKodeMapel() %></span></td>
                                    <td class="fw-semibold"><%= m.getNamaMapel() %></td>
                                    <td><%= m.getNamaGuruPengampu() == null ? "-" : m.getNamaGuruPengampu() %></td>
                                    <td class="text-secondary"><%= m.getKkm() %></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_mapel.jsp?id=<%= m.getIdMapel() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="MapelServlet?action=hapus&id=<%= m.getIdMapel() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus mata pelajaran ini?')">
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