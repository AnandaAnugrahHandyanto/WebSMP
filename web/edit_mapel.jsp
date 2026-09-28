<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.MapelDAO, dao.GuruDAO, model.Mapel, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Mapel mapel = null;
    try {
        mapel = new MapelDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (mapel == null) {
        response.sendRedirect("tampil_mapel.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Mapel");
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
            <div class="page-header">
                <h1 class="page-title">Edit Mata Pelajaran</h1>
                <p class="page-subtitle">Perbarui data <%= mapel.getNamaMapel() %></p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="MapelServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= mapel.getIdMapel() %>">
                        <div class="col-md-4">
                            <label for="kodeMapel" class="form-label">Kode Mapel</label>
                            <input type="text" id="kodeMapel" name="kode_mapel" class="form-control" value="<%= mapel.getKodeMapel() %>" required>
                        </div>
                        <div class="col-md-8">
                            <label for="namaMapel" class="form-label">Nama Mapel</label>
                            <input type="text" id="namaMapel" name="nama_mapel" class="form-control" value="<%= mapel.getNamaMapel() %>" required>
                        </div>
                        <div class="col-md-8">
                            <label for="idGuru" class="form-label">Guru Pengampu</label>
                            <select id="idGuru" name="id_guru" class="form-select">
                                <option value="">-- Tanpa Pengampu --</option>
                                <%
                                    for (Guru g : listGuru) {
                                %>
                                <option value="<%= g.getIdGuru() %>" <%= g.getIdGuru() == mapel.getIdGuruPengampu() ? "selected" : "" %>><%= g.getNamaGuru() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="kkm" class="form-label">KKM</label>
                            <input type="number" id="kkm" name="kkm" class="form-control" value="<%= mapel.getKkm() %>" min="0" max="100" required>
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
                            </button>
                            <a href="tampil_mapel.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>