<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.UserDAO, model.User, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Pengaturan User");
    List<User> listUser = new UserDAO().getAll();
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
                <h1 class="page-title">Pengaturan User</h1>
                <p class="page-subtitle">Kelola akun yang dapat mengakses sistem</p>
            </div>

            <%
                if (request.getParameter("sukses") != null) {
            %>
            <div class="alert alert-success d-flex align-items-center gap-2 mb-3">
                <i class="bi bi-check-circle-fill"></i>
                <span>Perubahan berhasil disimpan.</span>
            </div>
            <%
                }
            %>

            <div class="row g-3">
                <div class="col-lg-5">
                    <div class="card animate-fade">
                        <div class="card-header">Tambah User Baru</div>
                        <div class="card-body">
                            <form action="SettingServlet" method="POST" class="row g-3">
                                <input type="hidden" name="action" value="simpan-user">
                                <div class="col-12">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" id="username" name="username" class="form-control" required>
                                </div>
                                <div class="col-12">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="text" id="password" name="password" class="form-control" required>
                                </div>
                                <div class="col-12">
                                    <label for="role" class="form-label">Role</label>
                                    <select id="role" name="role" class="form-select" required>
                                        <option value="admin">Admin</option>
                                        <option value="guru">Guru</option>
                                        <option value="siswa">Siswa</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-person-plus me-1"></i> Tambah User
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="card animate-fade">
                        <div class="card-header">Daftar User</div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>Username</th>
                                            <th>Role</th>
                                            <th style="width:120px;">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (User u : listUser) {
                                        %>
                                        <tr>
                                            <td class="fw-semibold"><%= u.getUsername() %></td>
                                            <td>
                                                <span class="badge-soft" style="background:<%= "admin".equals(u.getRole()) ? "#eef2ff;color:#4F46E5" : "guru".equals(u.getRole()) ? "#ecfdf5;color:#059669" : "#fef3c7;color:#d97706" %>;">
                                                    <%= u.getRole() %>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="SettingServlet?action=delete&id=<%= u.getIdUser() %>"
                                                   class="btn btn-sm btn-outline-danger"
                                                   title="Hapus"
                                                   onclick="return confirm('Yakin hapus user ini?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
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
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>