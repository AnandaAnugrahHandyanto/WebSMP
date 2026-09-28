<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NilaiDAO, dao.SiswaDAO, dao.MapelDAO, model.Nilai, model.Siswa, model.Mapel, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Nilai nilai = null;
    try {
        nilai = new NilaiDAO().getById(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        // ID tidak valid, redirect di bawah
    }

    if (nilai == null) {
        response.sendRedirect("tampil_nilai.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Edit Nilai");
    List<Siswa> listSiswa = new SiswaDAO().getAll();
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
            <div class="page-header">
                <h1 class="page-title">Edit Nilai</h1>
                <p class="page-subtitle">Nilai akhir = 30% Tugas + 30% UTS + 40% UAS</p>
            </div>

            <div class="card animate-fade" style="max-width:760px;">
                <div class="card-body">
                    <form action="NilaiServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= nilai.getIdNilai() %>">
                        <div class="col-md-6">
                            <label for="idSiswa" class="form-label">Siswa</label>
                            <select id="idSiswa" name="id_siswa" class="form-select" required>
                                <%
                                    for (Siswa s : listSiswa) {
                                %>
                                <option value="<%= s.getIdSiswa() %>" <%= s.getIdSiswa() == nilai.getIdSiswa() ? "selected" : "" %>><%= s.getNis() %> - <%= s.getNamaSiswa() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idMapel" class="form-label">Mata Pelajaran</label>
                            <select id="idMapel" name="id_mapel" class="form-select" required>
                                <%
                                    for (Mapel m : listMapel) {
                                %>
                                <option value="<%= m.getIdMapel() %>" <%= m.getIdMapel() == nilai.getIdMapel() ? "selected" : "" %>><%= m.getKodeMapel() %> - <%= m.getNamaMapel() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="nilaiTugas" class="form-label">Nilai Tugas</label>
                            <input type="number" id="nilaiTugas" name="nilai_tugas" class="form-control" value="<%= nilai.getNilaiTugas() %>" min="0" max="100" required>
                        </div>
                        <div class="col-md-4">
                            <label for="nilaiUts" class="form-label">Nilai UTS</label>
                            <input type="number" id="nilaiUts" name="nilai_uts" class="form-control" value="<%= nilai.getNilaiUts() %>" min="0" max="100" required>
                        </div>
                        <div class="col-md-4">
                            <label for="nilaiUas" class="form-label">Nilai UAS</label>
                            <input type="number" id="nilaiUas" name="nilai_uas" class="form-control" value="<%= nilai.getNilaiUas() %>" min="0" max="100" required>
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-1"></i> Update
                            </button>
                            <a href="tampil_nilai.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>