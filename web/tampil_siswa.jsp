<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SiswaDAO, model.Siswa, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    SiswaDAO dao = new SiswaDAO();
    List<Siswa> listSiswa = dao.getAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Siswa - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="index.jsp">Dashboard</a>
                    <a class="nav-link active" href="tampil_siswa.jsp">Data Siswa</a>
                    <a class="btn btn-danger btn-sm ms-3" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Data Siswa</h2>
                <a href="input_siswa.jsp" class="btn btn-success">+ Tambah Siswa</a>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>No</th>
                                <th>NIS</th>
                                <th>Nama Siswa</th>
                                <th>Jenis Kelamin</th>
                                <th>Kelas</th>
                                <th>Alamat</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int no = 1;
                                for (Siswa s : listSiswa) {
                            %>
                            <tr>
                                <td><%= no++ %></td>
                                <td><%= s.getNis() %></td>
                                <td><%= s.getNamaSiswa() %></td>
                                <td><%= s.getJenisKelamin() %></td>
                                <td><%= s.getNamaKelas() == null ? "-" : s.getNamaKelas() %></td>
                                <td><%= s.getAlamat() %></td>
                                <td>
                                    <a href="edit_siswa.jsp?id=<%= s.getIdSiswa() %>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="SiswaServlet?action=hapus&id=<%= s.getIdSiswa() %>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Yakin hapus data ini?')">Hapus</a>
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