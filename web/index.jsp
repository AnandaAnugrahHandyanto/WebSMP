<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.StatistikDAO, java.util.Map, java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if ("guru".equals(session.getAttribute("role"))) {
        response.sendRedirect("guru_dashboard.jsp");
        return;
    }
    if ("siswa".equals(session.getAttribute("role"))) {
        response.sendRedirect("siswa_dashboard.jsp");
        return;
    }

    request.setAttribute("pageTitle", "Dashboard");
    StatistikDAO statistik = new StatistikDAO();
    Map<String, Integer> siswaPerKelas = statistik.siswaPerKelas();
    Map<String, Double> rataNilai = statistik.rataRataNilaiPerMapel();
    List<String[]> siswaTerbaru = statistik.siswaTerbaru(5);

    String jsonLabelKelas = "";
    String jsonDataKelas = "";
    int idx = 0;
    for (Map.Entry<String, Integer> e : siswaPerKelas.entrySet()) {
        jsonLabelKelas += (idx > 0 ? "," : "") + "\"" + e.getKey().replace("\"", "") + "\"";
        jsonDataKelas += (idx > 0 ? "," : "") + e.getValue();
        idx++;
    }

    String jsonLabelNilai = "";
    String jsonDataNilai = "";
    idx = 0;
    for (Map.Entry<String, Double> e : rataNilai.entrySet()) {
        jsonLabelNilai += (idx > 0 ? "," : "") + "\"" + e.getKey().replace("\"", "") + "\"";
        jsonDataNilai += (idx > 0 ? "," : "") + e.getValue();
        idx++;
    }
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
                <h1 class="page-title">Dashboard</h1>
                <p class="page-subtitle">Ringkasan data akademik sekolah</p>
            </div>

            <div class="row g-3 mb-4 stagger">
                <div class="col-sm-6 col-xl-3">
                    <div class="card stat-card">
                        <div class="stat-icon" style="background:#eef2ff;color:#4F46E5;">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div class="stat-label">Total Siswa</div>
                        <div class="stat-value"><%= statistik.totalSiswa() %></div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="card stat-card">
                        <div class="stat-icon" style="background:#ecfdf5;color:#059669;">
                            <i class="bi bi-person-badge-fill"></i>
                        </div>
                        <div class="stat-label">Total Guru</div>
                        <div class="stat-value"><%= statistik.totalGuru() %></div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="card stat-card">
                        <div class="stat-icon" style="background:#fef3c7;color:#d97706;">
                            <i class="bi bi-door-open-fill"></i>
                        </div>
                        <div class="stat-label">Total Kelas</div>
                        <div class="stat-value"><%= statistik.totalKelas() %></div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="card stat-card">
                        <div class="stat-icon" style="background:#fee2e2;color:#dc2626;">
                            <i class="bi bi-book-fill"></i>
                        </div>
                        <div class="stat-label">Total Mapel</div>
                        <div class="stat-value"><%= statistik.totalMapel() %></div>
                    </div>
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-lg-6">
                    <div class="card h-100 animate-fade">
                        <div class="card-header">Distribusi Siswa per Kelas</div>
                        <div class="card-body">
                            <div style="height:280px;">
                                <canvas id="chartKelas"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card h-100 animate-fade">
                        <div class="card-header">Rata-rata Nilai per Mata Pelajaran</div>
                        <div class="card-body">
                            <div style="height:280px;">
                                <canvas id="chartNilai"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card animate-fade">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>Aktivitas Terbaru</span>
                    <a href="tampil_siswa.jsp" class="btn btn-sm btn-outline-primary">Lihat Semua</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead>
                                <tr>
                                    <th>NIS</th>
                                    <th>Nama Siswa</th>
                                    <th>Kelas</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (siswaTerbaru.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="3" class="text-center text-secondary py-4">Belum ada data siswa</td>
                                </tr>
                                <%
                                    } else {
                                        for (String[] row : siswaTerbaru) {
                                %>
                                <tr>
                                    <td><%= row[0] %></td>
                                    <td><%= row[1] %></td>
                                    <td><%= row[2] == null ? "-" : row[2] %></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="fragment/scripts.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    <script>
        Chart.defaults.font.family = "'Plus Jakarta Sans', sans-serif";
        Chart.defaults.color = getComputedStyle(document.body).color;

        var labelKelas = [<%= jsonLabelKelas %>];
        var dataKelas = [<%= jsonDataKelas %>];

        new Chart(document.getElementById('chartKelas'), {
            type: 'bar',
            data: {
                labels: labelKelas,
                datasets: [{
                    label: 'Jumlah Siswa',
                    data: dataKelas,
                    backgroundColor: '#4F46E5',
                    borderRadius: 8,
                    maxBarThickness: 56
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, ticks: { precision: 0 } },
                    x: { grid: { display: false } }
                }
            }
        });

        new Chart(document.getElementById('chartNilai'), {
            type: 'line',
            data: {
                labels: [<%= jsonLabelNilai %>],
                datasets: [{
                    label: 'Rata-rata Nilai',
                    data: [<%= jsonDataNilai %>],
                    borderColor: '#059669',
                    backgroundColor: 'rgba(5, 150, 105, 0.12)',
                    fill: true,
                    tension: 0.35,
                    pointRadius: 4,
                    pointBackgroundColor: '#059669'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true, max: 100 },
                    x: { grid: { display: false } }
                }
            }
        });
    </script>
</body>
</html>