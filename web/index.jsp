<%-- 
    Document   : index
    Created on : Sep 28, 2026, 9:53:31 PM
    Author     : anandaanugrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Sistem Akademik SMP</a>
                <div class="navbar-nav ms-auto">
                    <span class="navbar-text text-white me-3">Halo, <%= user %></span>
                    <a class="btn btn-danger btn-sm" href="logout.jsp">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="mb-4">Dashboard Admin</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Data Siswa</h5>
                            <p class="card-text">Kelola data siswa SMP.</p>
                            <a href="tampil_siswa.jsp" class="btn btn-light">Masuk</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-info mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Data Mapel</h5>
                            <p class="card-text">Kelola mata pelajaran.</p>
                            <a href="#" class="btn btn-light disabled">Segera Hadir</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Data Nilai</h5>
                            <p class="card-text">Input nilai siswa.</p>
                            <a href="#" class="btn btn-light disabled">Segera Hadir</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>