<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String currentUri = request.getRequestURI();
    String currentPage = currentUri.substring(currentUri.lastIndexOf('/') + 1);
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null) {
        pageTitle = "Dashboard";
    }
    String user = (String) session.getAttribute("user");
%>
<header class="topbar">
    <div class="d-flex align-items-center gap-3">
        <button class="topbar-btn" type="button" onclick="toggleSidebar()" aria-label="Toggle navigasi">
            <i class="bi bi-list"></i>
        </button>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">Beranda</li>
                <li class="breadcrumb-item active"><%= pageTitle %></li>
            </ol>
        </nav>
    </div>
    <div class="d-flex align-items-center gap-2">
        <button class="topbar-btn" type="button" onclick="toggleTheme()" aria-label="Ganti tema">
            <i class="bi bi-moon-stars-fill" id="theme-icon"></i>
        </button>
        <div class="d-none d-sm-flex align-items-center gap-2 ps-2">
            <i class="bi bi-person-circle text-secondary"></i>
            <span class="small fw-semibold"><%= user == null ? "-" : user %></span>
        </div>
        <a href="logout.jsp" class="btn btn-sm btn-outline-primary">
            <i class="bi bi-box-arrow-right"></i> <span class="d-none d-sm-inline">Logout</span>
        </a>
    </div>
</header>