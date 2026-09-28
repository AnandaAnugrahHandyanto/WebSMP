<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String currentUri = request.getRequestURI();
    String currentPage = currentUri.substring(currentUri.lastIndexOf('/') + 1);
    String role = (String) session.getAttribute("role");

    String[][] menu = {
        {"index.jsp", "Dashboard", "bi-speedometer2", "admin"},
        {"guru_dashboard.jsp", "Dashboard", "bi-speedometer2", "guru"},
        {"siswa_dashboard.jsp", "Dashboard", "bi-speedometer2", "siswa"},
        {"tampil_siswa.jsp", "Data Siswa", "bi-people", "admin"},
        {"tampil_guru.jsp", "Data Guru", "bi-person-badge", "admin"},
        {"tampil_kelas.jsp", "Data Kelas", "bi-door-open", "admin"},
        {"tampil_mapel.jsp", "Data Mapel", "bi-book", "admin"},
        {"tampil_nilai.jsp", "Data Nilai", "bi-clipboard-data", "admin"},
        {"tampil_jadwal.jsp", "Data Jadwal", "bi-calendar-week", "admin"},
        {"tampil_absensi.jsp", "Data Absensi", "bi-check2-square", "admin"},
        {"setting_user.jsp", "Kelola User", "bi-people-fill", "admin"},
        {"setting_password.jsp", "Ganti Password", "bi-key-fill", "admin"},
        {"setting_password.jsp", "Ganti Password", "bi-key-fill", "guru"},
        {"setting_password.jsp", "Ganti Password", "bi-key-fill", "siswa"}
    };
%>
<aside class="sidebar animate-slide">
    <a href="index.jsp" class="sidebar-logo">
        <i class="bi bi-mortarboard-fill"></i>
        <span>WebSMP</span>
    </a>
    <nav class="sidebar-nav">
        <%
            for (String[] item : menu) {
                boolean visible = role == null || role.equals(item[3]);
                boolean active = currentPage.equals(item[0]);
                if (visible) {
        %>
        <a href="<%= item[0] %>" class="sidebar-link <%= active ? "active" : "" %>" title="<%= item[1] %>">
            <i class="bi <%= item[2] %>"></i>
            <span><%= item[1] %></span>
        </a>
        <%
                }
            }
        %>
    </nav>
    <div class="sidebar-footer">Login sebagai: <%= role == null ? "-" : role %></div>
</aside>
<div class="backdrop"></div>