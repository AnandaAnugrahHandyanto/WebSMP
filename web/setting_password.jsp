<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Ganti Password");
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
                <h1 class="page-title">Ganti Password</h1>
                <p class="page-subtitle">Perbarui password akun <%= session.getAttribute("user") %></p>
            </div>

            <%
                if (request.getParameter("sukses") != null) {
            %>
            <div class="alert alert-success d-flex align-items-center gap-2 mb-3">
                <i class="bi bi-check-circle-fill"></i>
                <span>Password berhasil diubah.</span>
            </div>
            <%
                }
                if ("konfirmasi".equals(request.getParameter("error"))) {
            %>
            <div class="alert alert-danger d-flex align-items-center gap-2 mb-3">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <span>Konfirmasi password tidak cocok.</span>
            </div>
            <%
                }
            %>

            <div class="card animate-fade" style="max-width:560px;">
                <div class="card-body">
                    <form action="SettingServlet" method="POST" class="row g-3">
                        <input type="hidden" name="action" value="ganti-password">
                        <div class="col-12">
                            <label for="passwordBaru" class="form-label">Password Baru</label>
                            <input type="text" id="passwordBaru" name="password_baru" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label for="konfirmasi" class="form-label">Konfirmasi Password</label>
                            <input type="text" id="konfirmasi" name="konfirmasi_password" class="form-control" required>
                        </div>
                        <div class="col-12 d-flex gap-2 pt-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-key me-1"></i> Update Password
                            </button>
                            <a href="index.jsp" class="btn btn-outline-secondary">Batal</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>