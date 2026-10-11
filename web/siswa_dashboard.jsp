<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="config.Koneksi, java.sql.*, java.time.LocalDate, java.time.format.TextStyle, java.util.Locale"%>
<%
    if (session.getAttribute("user") == null || !"siswa".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nis = (String) session.getAttribute("user");
    int idSiswa = 0;
    String namaSiswa = "";
    String namaKelas = "";
    try (Connection conn = Koneksi.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT s.*, k.nama_kelas FROM siswa s LEFT JOIN kelas k ON s.id_kelas=k.id_kelas WHERE s.nis=?");
        ps.setString(1, nis);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            idSiswa = rs.getInt("id_siswa");
            namaSiswa = rs.getString("nama_siswa");
            namaKelas = rs.getString("nama_kelas");
        }
    } catch (Exception e) {}

    String hariIni = LocalDate.now().getDayOfWeek().getDisplayName(TextStyle.FULL, new Locale("id"));
    request.setAttribute("pageTitle", "Dashboard Siswa");
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
                <h1 class="page-title">Selamat datang, <%= namaSiswa %></h1>
                <p class="page-subtitle">Kelas: <%= namaKelas == null ? "-" : namaKelas %></p>
                <p>DEBUG: NIS = <%= nis %>, ID Siswa = <%= idSiswa %></p>
            </div>
            
            <div class="card animate-fade">
                <div class="card-header">Nilai Saya</div>
                <div class="card-body p-0">
                    <table class="table mb-0">
                        <thead><tr><th>Mapel</th><th>Tugas</th><th>UTS</th><th>UAS</th><th>Akhir</th><th>Predikat</th></tr></thead>
                        <tbody>
                            <%
                                try (Connection conn = Koneksi.getConnection()) {
                                    PreparedStatement ps = conn.prepareStatement("SELECT n.*, m.nama_mapel FROM nilai n JOIN mapel m ON n.id_mapel=m.id_mapel WHERE n.id_siswa=?");
                                    ps.setInt(1, idSiswa);
                                    ResultSet rs = ps.executeQuery();
                                    while(rs.next()){
                            %>
                            <tr>
                                <td><%= rs.getString("nama_mapel") %></td>
                                <td><%= rs.getInt("nilai_tugas") %></td>
                                <td><%= rs.getInt("nilai_uts") %></td>
                                <td><%= rs.getInt("nilai_uas") %></td>
                                <td><%= rs.getBigDecimal("nilai_akhir") %></td>
                                <td><%= rs.getString("predikat") %></td>
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