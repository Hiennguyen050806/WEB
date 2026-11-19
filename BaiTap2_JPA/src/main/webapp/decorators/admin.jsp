<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/>${pageTitle != null ? pageTitle : 'Admin Dashboard - JPA 3.0'}</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body { min-height: 100vh; background-color: #f4f6f9; display: flex; flex-direction: column; }
        .sidebar { min-height: 100vh; background: #343a40; color: #fff; width: 250px; flex-shrink: 0; }
        .sidebar a { color: #c2c7d0; text-decoration: none; padding: 12px 20px; display: block; border-left: 3px solid transparent; }
        .sidebar a:hover, .sidebar a.active { color: #fff; background: #494e53; border-left-color: #0d6efd; }
        .sidebar .brand { font-size: 18px; font-weight: bold; padding: 18px 20px; border-bottom: 1px solid #4b545c; color: #fff; display: flex; align-items: center; gap: 8px; }
        .admin-layout { display: flex; flex: 1; }
        .admin-main { flex: 1; display: flex; flex-direction: column; min-width: 0; }
        .admin-topbar { background: #fff; border-bottom: 1px solid #dee2e6; padding: 12px 25px; display: flex; justify-content: space-between; align-items: center; }
        .admin-content { padding: 25px; flex: 1; }
        footer { background: #fff; border-top: 1px solid #dee2e6; padding: 15px 25px; font-size: 13px; color: #6c757d; }
    </style>
</head>
<body>
    <div class="admin-layout">
        <!-- Sidebar Navigation (Bootstrap 5) -->
        <aside class="sidebar">
            <div class="brand">
                <i class="bi bi-shield-lock-fill text-primary fs-4"></i> ADMIN PANEL
            </div>
            <div class="p-3 border-bottom border-secondary small text-muted">
                Xin chào: <strong class="text-white">${sessionScope.account != null ? sessionScope.account.fullname : 'Admin'}</strong>
            </div>
            <nav class="mt-2">
                <a href="${pageContext.request.contextPath}/admin/categories" class="active">
                    <i class="bi bi-folder-fill me-2"></i> Quản lý Danh mục (JPA)
                </a>
                <a href="${pageContext.request.contextPath}/admin/category/add">
                    <i class="bi bi-folder-plus me-2"></i> Thêm Danh mục mới
                </a>
                <a href="${pageContext.request.contextPath}/admin/videos">
                    <i class="bi bi-film me-2"></i> Quản lý Videos (JPA)
                </a>
                <a href="${pageContext.request.contextPath}/admin/video/add">
                    <i class="bi bi-cloud-plus-fill me-2"></i> Đăng Video mới
                </a>
                <hr class="border-secondary my-2">
                <a href="${pageContext.request.contextPath}/home" target="_blank">
                    <i class="bi bi-box-arrow-up-right me-2"></i> Xem Trang Chủ (User)
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="text-danger">
                    <i class="bi bi-power me-2"></i> Đăng xuất
                </a>
            </nav>
        </aside>

        <!-- Main Content Area -->
        <div class="admin-main">
            <!-- Top Navbar -->
            <header class="admin-topbar">
                <div class="d-flex align-items-center">
                    <span class="fs-5 fw-bold text-dark"><i class="bi bi-speedometer2 me-2"></i> Bảng Điều Khiển Quản Trị</span>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <span class="badge bg-danger">Hệ thống JPA 3.0</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                        <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                    </a>
                </div>
            </header>

            <!-- Nội dung chính được Decorate -->
            <main class="admin-content">
                <sitemesh:write property='body'/>
                ${body}
            </main>

            <!-- Admin Footer -->
            <footer>
                <div class="d-flex justify-content-between align-items-center">
                    <span>&copy; 2026 Admin Management System - SiteMesh Decorator 3 with Bootstrap 5</span>
                    <span>Version 1.0 (Jakarta EE 10 / JPA 3.0)</span>
                </div>
            </footer>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
