<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.SiswaDAO, dao.GuruDAO, dao.KelasDAO"%>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
    int totalSiswa = new SiswaDAO().getAll().size();
    int totalGuru = new GuruDAO().getAll().size();
    int totalKelas = new KelasDAO().getAll().size();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WebSMP - Sistem Akademik SMP</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: #f8fafc;
            color: #0f172a;
        }
        .hero {
            min-height: 100vh;
            background: linear-gradient(135deg, #4F46E5 0%, #7C3AED 55%, #A855F7 100%);
            color: #fff;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            width: 480px;
            height: 480px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            top: -160px;
            right: -120px;
        }
        .hero::after {
            content: '';
            position: absolute;
            width: 360px;
            height: 360px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.06);
            bottom: -140px;
            left: -100px;
        }
        .hero-nav {
            position: relative;
            z-index: 2;
        }
        .hero-content {
            position: relative;
            z-index: 2;
            flex: 1;
            display: flex;
            align-items: center;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 7px 16px;
            border-radius: 999px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .hero-title {
            font-size: clamp(2.4rem, 6vw, 4rem);
            font-weight: 800;
            letter-spacing: -0.04em;
            line-height: 1.1;
        }
        .hero-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 520px;
        }
        .btn-hero {
            padding: 12px 28px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: transform 0.25s, box-shadow 0.25s;
        }
        .btn-hero:hover {
            transform: translateY(-2px);
        }
        .btn-light-hero {
            background: #fff;
            color: #4F46E5;
            border: none;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.18);
        }
        .btn-outline-hero {
            background: transparent;
            color: #fff;
            border: 1.5px solid rgba(255, 255, 255, 0.6);
        }
        .btn-outline-hero:hover {
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
        }
        .stat-strip {
            position: relative;
            z-index: 2;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }
        .stat-strip-item {
            padding: 22px 0;
        }
        .stat-strip-value {
            font-size: 1.7rem;
            font-weight: 800;
        }
        .stat-strip-label {
            font-size: 0.82rem;
            opacity: 0.8;
        }
        .feature-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 26px;
            height: 100%;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 32px rgba(15, 23, 42, 0.1);
        }
        .feature-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 16px;
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .reveal {
            opacity: 0;
        }
        .reveal.visible {
            animation: fadeUp 0.6s ease-out forwards;
        }
    </style>
</head>
<body>
    <header class="hero" id="top">
        <nav class="navbar hero-nav py-3">
            <div class="container">
                <div class="d-flex align-items-center justify-content-between">
                    <span class="navbar-brand d-flex align-items-center gap-2 text-white fw-bold fs-5 mb-0">
                        <i class="bi bi-mortarboard-fill"></i> WebSMP
                    </span>
                    <a href="login.jsp" class="btn btn-light-hero btn-hero">Login</a>
                </div>
            </div>
        </nav>

        <div class="hero-content">
            <div class="container py-5">
                <div class="row align-items-center">
                    <div class="col-lg-7">
                        <span class="hero-badge mb-4">
                            <i class="bi bi-stars"></i> Platform akademik modern
                        </span>
                        <h1 class="hero-title mb-3">Sistem Akademik SMP</h1>
                        <p class="hero-subtitle mb-4">
                            Kelola data siswa, guru, kelas, dan nilai dalam satu platform.
                        </p>
                        <div class="d-flex flex-wrap gap-3">
                            <a href="login.jsp" class="btn btn-light-hero btn-hero">
                                <i class="bi bi-box-arrow-in-right me-2"></i>Masuk
                            </a>
                            <a href="#fitur" class="btn btn-outline-hero btn-hero">
                                Pelajari
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-5 d-none d-lg-block text-center">
                        <i class="bi bi-graph-up-arrow display-1 text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="stat-strip">
            <div class="container">
                <div class="row text-center">
                    <div class="col-4 stat-strip-item">
                        <div class="stat-strip-value"><%= totalSiswa %></div>
                        <div class="stat-strip-label">Siswa</div>
                    </div>
                    <div class="col-4 stat-strip-item">
                        <div class="stat-strip-value"><%= totalGuru %></div>
                        <div class="stat-strip-label">Guru</div>
                    </div>
                    <div class="col-4 stat-strip-item">
                        <div class="stat-strip-value"><%= totalKelas %></div>
                        <div class="stat-strip-label">Kelas</div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section class="py-5" id="fitur">
        <div class="container">
            <div class="text-center mb-5 reveal">
                <h2 class="fw-bold mb-2">Fitur Lengkap</h2>
                <p class="text-secondary mb-0">Semua kebutuhan manajemen sekolah dalam satu tempat</p>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-3 reveal">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:#eef2ff;color:#4F46E5;">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <h6 class="fw-bold">Data Siswa</h6>
                        <p class="text-secondary small mb-0">Kelola identitas dan kelas siswa secara terpusat.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 reveal">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:#ecfdf5;color:#059669;">
                            <i class="bi bi-person-badge-fill"></i>
                        </div>
                        <h6 class="fw-bold">Data Guru</h6>
                        <p class="text-secondary small mb-0">Atur data guru dan penugasan mengajar.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 reveal">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:#fef3c7;color:#d97706;">
                            <i class="bi bi-clipboard-data-fill"></i>
                        </div>
                        <h6 class="fw-bold">Penilaian</h6>
                        <p class="text-secondary small mb-0">Hitung nilai akhir dan predikat otomatis.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 reveal">
                    <div class="feature-card">
                        <div class="feature-icon" style="background:#fee2e2;color:#dc2626;">
                            <i class="bi bi-check2-square-fill"></i>
                        </div>
                        <h6 class="fw-bold">Absensi</h6>
                        <p class="text-secondary small mb-0">Pantau kehadiran siswa harian per bulan.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="py-4 border-top bg-white">
        <div class="container text-center">
            <p class="text-secondary small mb-0">WebSMP - Sistem Akademik Sekolah Menengah Pertama</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.reveal').forEach(function (el, index) {
            el.style.animationDelay = (index * 0.08) + 's';
            observer.observe(el);
        });
    </script>
</body>
</html>