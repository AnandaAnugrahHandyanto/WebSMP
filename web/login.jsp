<%-- 
    Document   : login
    Created on : Sep 28, 2026, 9:43:55 PM
    Author     : anandaanugrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - Sistem Akademik SMP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; }
            .card { width: 400px; }
        </style>
    </head>
    <body>
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4>Login Admin</h4>
            </div>
            <div class="card-body">
                <!-- Form ini akan mengirim data ke LoginServlet -->
                <form action="LoginServlet" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Masuk</button>
                </form>
                
                <%
                    String error = request.getParameter("error");
                    if (error != null && error.equals("true")) {
                %>
                    <div class="alert alert-danger mt-3">Username atau Password salah!</div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>