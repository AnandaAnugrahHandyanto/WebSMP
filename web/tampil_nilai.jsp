<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NilaiDAO, model.Nilai, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Data Nilai");
    List<Nilai> listNilai = new NilaiDAO().getAll();
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
                    <h1 class="page-title">Data Nilai</h1>
                    <p class="page-subtitle">Total <%= listNilai.size() %> data nilai</p>
                </div>
                <a href="input_nilai.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Input Nilai
                </a>
            </div>

            <div class="card animate-fade">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:60px;">No</th>
                                    <th>Siswa</th>
                                    <th>Kelas</th>
                                    <th>Mata Pelajaran</th>
                                    <th>Tugas</th>
                                    <th>UTS</th>
                                    <th>UAS</th>
                                    <th>Nilai Akhir</th>
                                    <th>Predikat</th>
                                    <th style="width:150px;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listNilai.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="10" class="text-center text-secondary py-5">Belum ada data nilai</td>
                                </tr>
                                <%
                                    } else {
                                        int no = 1;
                                        for (Nilai n : listNilai) {
                                %>
                                <tr>
                                    <td><%= no++ %></td>
                                    <td class="fw-semibold"><%= n.getNamaSiswa() %></td>
                                    <td><%= n.getKelas() == null ? "-" : n.getKelas() %></td>
                                    <td><%= n.getNamaMapel() %></td>
                                    <td class="text-secondary"><%= n.getNilaiTugas() %></td>
                                    <td class="text-secondary"><%= n.getNilaiUts() %></td>
                                    <td class="text-secondary"><%= n.getNilaiUas() %></td>
                                    <td class="fw-bold"><%= String.format("%.2f", n.getNilaiAkhir()) %></td>
                                    <td>
                                        <span class="badge-soft" style="background:<%= "A".equals(n.getPredikat()) ? "#d1fae5;color:#047857" : "B".equals(n.getPredikat()) ? "#dbeafe;color:#1d4ed8" : "C".equals(n.getPredikat()) ? "#fef3c7;color:#b45309" : "#fee2e2;color:#b91c1c" %>;">
                                            <%= n.getPredikat() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <a href="edit_nilai.jsp?id=<%= n.getIdNilai() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="NilaiServlet?action=hapus&id=<%= n.getIdNilai() %>"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Hapus"
                                               onclick="return confirm('Yakin hapus nilai ini?')">
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