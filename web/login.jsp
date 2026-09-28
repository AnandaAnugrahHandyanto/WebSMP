<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - WebSMP</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            min-height: 100vh;
            background: #f8fafc;
        }
        .login-brand {
            background: linear-gradient(150deg, #4F46E5 0%, #7C3AED 100%);
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px 48px;
            position: relative;
            overflow: hidden;
        }
        .login-brand::after {
            content: '';
            position: absolute;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.07);
            bottom: -180px;
            right: -140px;
        }
        .brand-title {
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -0.03em;
        }
        .brand-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .brand-list li {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
            opacity: 0.9;
        }
        .brand-list i {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 14px;
        }
        .input-icon {
            position: relative;
        }
        .input-icon i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 1rem;
        }
        .input-icon .form-control {
            padding-left: 42px;
        }
        .btn-login {
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            background: #4F46E5;
            border: none;
            color: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-login:hover {
            background: #4338CA;
            transform: translateY(-1px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-up {
            animation: fadeUp 0.5s ease-out;
        }
    </style>
</head>
<body>
    <div class="container-fluid min-vh-100 p-0">
        <div class="row g-0 min-vh-100">
            <div class="col-lg-6 d-none d-lg-block">
                <div class="login-brand h-100">
                    <div class="fade-up">
                        <div class="d-flex align-items-center gap-2 mb-5">
                            <i class="bi bi-mortarboard-fill fs-3"></i>
                            <span class="fs-5 fw-bold">WebSMP</span>
                        </div>
                        <h1 class="brand-title mb-3">Selamat Datang<br>Kembali</h1>
                        <p class="mb-4 opacity-75">Masuk untuk mengelola data akademik sekolah Anda.</p>
                        <ul class="brand-list">
                            <li>
                                <i class="bi bi-people-fill"></i>
                                <span>Kelola data siswa, guru, dan kelas</span>
                            </li>
                            <li>
                                <i class="bi bi-clipboard-data-fill"></i>
                                <span>Input dan rekap nilai siswa</span>
                            </li>
                            <li>
                                <i class="bi bi-calendar-week-fill"></i>
                                <span>Atur jadwal dan absensi</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="d-flex align-items-center justify-content-center h-100 p-4">
                    <div class="fade-up" style="width:100%;max-width:400px;">
                        <div class="d-lg-none d-flex align-items-center gap-2 mb-4">
                            <i class="bi bi-mortarboard-fill text-primary fs-3"></i>
                            <span class="fs-5 fw-bold">WebSMP</span>
                        </div>
                        <h2 class="fw-bold mb-1">Masuk ke Akun</h2>
                        <p class="text-secondary mb-4">Gunakan akun admin, guru, atau siswa Anda.</p>

                        <%
                            if (error != null && error.equals("true")) {
                        %>
                        <div class="alert alert-danger d-flex align-items-center gap-2 mb-4">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                            <span>Username atau password salah.</span>
                        </div>
                        <%
                            }
                        %>

                        <form action="LoginServlet" method="POST">
                            <div class="mb-3">
                                <label for="username" class="form-label fw-semibold small">Username</label>
                                <div class="input-icon">
                                    <i class="bi bi-person"></i>
                                    <input type="text" id="username" name="username" class="form-control" required autofocus>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label fw-semibold small">Password</label>
                                <div class="input-icon">
                                    <i class="bi bi-lock"></i>
                                    <input type="password" id="password" name="password" class="form-control" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-login w-100 mb-3">Masuk</button>
                        </form>

                        <a href="welcome.jsp" class="d-flex align-items-center justify-content-center gap-2 text-decoration-none text-secondary small">
                            <i class="bi bi-arrow-left"></i> Kembali ke Beranda
                        </a>

                        <div class="border-top pt-4 mt-4">
                            <p class="text-secondary small mb-2 fw-semibold">Akun demo</p>
                            <div class="d-flex flex-wrap gap-2">
                                <span class="badge text-bg-light border">admin / admin</span>
                                <span class="badge text-bg-light border">198501012010011001 / guru</span>
                                <span class="badge text-bg-light border">2024001 / siswa</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>