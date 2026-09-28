<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.GuruDAO, model.Guru"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Guru guru = null;
    try {
        guru = new GuruDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (guru == null) {
        response.sendRedirect("tampil_guru.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Guru");
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
                <h1 class="page-title">Edit Guru</h1>
                <p class="page-subtitle">Perbarui data <%= guru.getNamaGuru() %></p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="GuruServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= guru.getIdGuru() %>">
                        <div class="col-md-6">
                            <label for="nip" class="form-label">NIP</label>
                            <input type="text" id="nip" name="nip" class="form-control" value="<%= guru.getNip() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="jenisKelamin" class="form-label">Jenis Kelamin</label>
                            <select id="jenisKelamin" name="jenis_kelamin" class="form-select" required>
                                <option value="L" <%= "L".equals(guru.getJenisKelamin()) ? "selected" : "" %>>Laki-laki</option>
                                <option value="P" <%= "P".equals(guru.getJenisKelamin()) ? "selected" : "" %>>Perempuan</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="namaGuru" class="form-label">Nama Guru</label>
                            <input type="text" id="namaGuru" name="nama_guru" class="form-control" value="<%= guru.getNamaGuru() %>" required>
                        </div>
                        <div class="col-12">
                            <label for="noHp" class="form-label">No HP</label>
                            <input type="text" id="noHp" name="no_hp" class="form-control" value="<%= guru.getNoHp() == null ? "" : guru.getNoHp() %>">
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
                            </button>
                            <a href="tampil_guru.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>