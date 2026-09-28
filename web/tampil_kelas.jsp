<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.KelasDAO, model.Kelas, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    KelasDAO dao = new KelasDAO();
    List<Kelas> listKelas = dao.getAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Kelas - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="index.jsp">Dashboard</a>
                    <a class="nav-link" href="tampil_siswa.jsp">Data Siswa</a>
                    <a class="nav-link" href="tampil_guru.jsp">Data Guru</a>
                    <a class="nav-link active" href="tampil_kelas.jsp">Data Kelas</a>
                    <a class="btn btn-danger btn-sm ms-3" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Data Kelas</h2>
                <a href="input_kelas.jsp" class="btn btn-success">+ Tambah Kelas</a>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>No</th>
                                <th>Nama Kelas</th>
                                <th>Wali Kelas</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int no = 1;
                                for (Kelas k : listKelas) {
                            %>
                            <tr>
                                <td><%= no++ %></td>
                                <td><%= k.getNamaKelas() %></td>
                                <td><%= k.getNamaWaliKelas() == null ? "-" : k.getNamaWaliKelas() %></td>
                                <td>
                                    <a href="edit_kelas.jsp?id=<%= k.getIdKelas() %>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="KelasServlet?action=hapus&id=<%= k.getIdKelas() %>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Yakin hapus data kelas ini?')">Hapus</a>
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