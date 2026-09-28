<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.AbsensiDAO, dao.SiswaDAO, model.Absensi, model.Siswa, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Absensi absensi = null;
    try {
        absensi = new AbsensiDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (absensi == null) {
        response.sendRedirect("tampil_absensi.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Absensi");
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
                <h1 class="page-title">Edit Absensi</h1>
                <p class="page-subtitle">Perbarui kehadiran <%= absensi.getNamaSiswa() %></p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="AbsensiServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= absensi.getIdAbsensi() %>">
                        <div class="col-md-8">
                            <label for="idSiswa" class="form-label">Siswa</label>
                            <select id="idSiswa" name="id_siswa" class="form-select" required>
                                <%
                                    for (Siswa s : listSiswa) {
                                %>
                                <option value="<%= s.getIdSiswa() %>" <%= s.getIdSiswa() == absensi.getIdSiswa() ? "selected" : "" %>><%= s.getNis() %> - <%= s.getNamaSiswa() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="tanggal" class="form-label">Tanggal</label>
                            <input type="date" id="tanggal" name="tanggal" class="form-control" value="<%= absensi.getTanggal() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="status" class="form-label">Status</label>
                            <select id="status" name="status" class="form-select" required>
                                <%
                                    String[] statusList = {"Hadir", "Sakit", "Izin", "Alpa"};
                                    for (String s : statusList) {
                                %>
                                <option value="<%= s %>" <%= s.equals(absensi.getStatus()) ? "selected" : "" %>><%= s %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="keterangan" class="form-label">Keterangan</label>
                            <input type="text" id="keterangan" name="keterangan" class="form-control" value="<%= absensi.getKeterangan() == null ? "" : absensi.getKeterangan() %>">
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
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