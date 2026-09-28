<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.GuruDAO, model.Guru, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    GuruDAO dao = new GuruDAO();
    List<Guru> listGuru = dao.getAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Guru - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="index.jsp">Dashboard</a>
                    <a class="nav-link active" href="tampil_guru.jsp">Data Guru</a>
                    <a class="nav-link" href="tampil_siswa.jsp">Data Siswa</a>
                    <a class="btn btn-danger btn-sm ms-3" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Data Guru</h2>
                <a href="input_guru.jsp" class="btn btn-success">+ Tambah Guru</a>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>No</th>
                                <th>NIP</th>
                                <th>Nama Guru</th>
                                <th>Jenis Kelamin</th>
                                <th>No HP</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int no = 1;
                                for (Guru g : listGuru) {
                            %>
                            <tr>
                                <td><%= no++ %></td>
                                <td><%= g.getNip() %></td>
                                <td><%= g.getNamaGuru() %></td>
                                <td><%= g.getJenisKelamin() %></td>
                                <td><%= g.getNoHp() == null ? "-" : g.getNoHp() %></td>
                                <td>
                                    <a href="edit_guru.jsp?id=<%= g.getIdGuru() %>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="GuruServlet?action=hapus&id=<%= g.getIdGuru() %>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Yakin hapus data guru ini?')">Hapus</a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>