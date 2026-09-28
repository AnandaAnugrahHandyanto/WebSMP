<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="config.Koneksi, java.sql.*, java.time.LocalDate, java.time.format.TextStyle, java.util.Locale"%>
<%
    if (session.getAttribute("user") == null || !"guru".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nip = (String) session.getAttribute("user");
    int idGuru = 0;
    String namaGuru = "";
    try (Connection conn = Koneksi.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM guru WHERE nip = ?");
        ps.setString(1, nip);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            idGuru = rs.getInt("id_guru");
            namaGuru = rs.getString("nama_guru");
        }
    } catch (Exception e) {}

    String hariIni = LocalDate.now().getDayOfWeek().getDisplayName(TextStyle.FULL, new Locale("id"));
    request.setAttribute("pageTitle", "Dashboard Guru");
%>
<!DOCTYPE html>
<html lang="id">
<head><%@include file="fragment/head.jsp" %></head>
<body>
    <%@include file="fragment/sidebar.jsp" %>
    <div class="main-content">
        <%@include file="fragment/topbar.jsp" %>
        <div class="page-content">
            <div class="page-header">
                <h1 class="page-title">Selamat datang, <%= namaGuru %></h1>
            </div>
            
            <div class="card animate-fade">
                <div class="card-header">Jadwal Mengajar Hari Ini (<%= hariIni %>)</div>
                <div class="card-body p-0">
                    <table class="table mb-0">
                        <thead><tr><th>Jam</th><th>Kelas</th><th>Mapel</th><th>Ruang</th></tr></thead>
                        <tbody>
                            <%
                                try (Connection conn = Koneksi.getConnection()) {
                                    PreparedStatement ps = conn.prepareStatement("SELECT j.*, k.nama_kelas, m.nama_mapel FROM jadwal j JOIN kelas k ON j.id_kelas=k.id_kelas JOIN mapel m ON j.id_mapel=m.id_mapel WHERE j.id_guru=? AND j.hari=? ORDER BY j.jam_mulai");
                                    ps.setInt(1, idGuru);
                                    ps.setString(2, hariIni);
                                    ResultSet rs = ps.executeQuery();
                                    while(rs.next()){
                            %>
                            <tr>
                                <td><%= rs.getString("jam_mulai") %> - <%= rs.getString("jam_selesai") %></td>
                                <td><%= rs.getString("nama_kelas") %></td>
                                <td><%= rs.getString("nama_mapel") %></td>
                                <td><%= rs.getString("ruang") %></td>
                            </tr>
                            <% } } catch(Exception e) {} %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
</body>
</html>