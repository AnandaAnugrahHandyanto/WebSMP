<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.KelasDAO, dao.GuruDAO, model.Kelas, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Kelas kelas = null;
    try {
        kelas = new KelasDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (kelas == null) {
        response.sendRedirect("tampil_kelas.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Kelas");
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
                <h1 class="page-title">Edit Kelas</h1>
                <p class="page-subtitle">Perbarui data <%= kelas.getNamaKelas() %></p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="KelasServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= kelas.getIdKelas() %>">
                        <div class="col-md-6">
                            <label for="namaKelas" class="form-label">Nama Kelas</label>
                            <input type="text" id="namaKelas" name="nama_kelas" class="form-control" value="<%= kelas.getNamaKelas() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="idWaliKelas" class="form-label">Wali Kelas</label>
                            <select id="idWaliKelas" name="id_wali_kelas" class="form-select">
                                <option value="">-- Tanpa Wali Kelas --</option>
                                <%
                                    for (Guru g : listGuru) {
                                %>
                                <option value="<%= g.getIdGuru() %>" <%= g.getIdGuru() == kelas.getIdWaliKelas() ? "selected" : "" %>><%= g.getNamaGuru() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
                            </button>
                            <a href="tampil_kelas.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>