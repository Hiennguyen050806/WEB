<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/></title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body { display: flex; flex-direction: column; min-height: 100vh; background-color: #f8f9fa; }
        .main-content { flex: 1; padding: 25px 0; }
        .navbar-brand { font-weight: 800; letter-spacing: 0.5px; }
        footer { background: #212529; color: #adb5bd; padding: 25px 0; font-size: 14px; margin-top: auto; }
        footer a { color: #dee2e6; text-decoration: none; }
        footer a:hover { color: #0d6efd; }
    </style>
</head>
<body>
    <!-- Header Navbar (Bootstrap 5) -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand text-primary" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-circle-fill me-1"></i> VIDEO PORTAL
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door me-1"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/video">
                            <i class="bi bi-film me-1"></i> Video Phân Trang (6sp)
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/multiPartServlet">
                            <i class="bi bi-cloud-arrow-up me-1"></i> Upload Multipart
                        </a>
                    </li>
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-warning" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-gear-fill me-1"></i> Quản Trị (Admin)
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories"><i class="bi bi-tags me-1"></i> Quản lý Danh mục (JPA)</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/videos"><i class="bi bi-camera-reels me-1"></i> Quản lý Videos (JPA)</a></li>
                            </ul>
                        </li>
                    </c:if>
                </ul>

                <!-- User Account Info / Auth Buttons -->
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${sessionScope.account == null}">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm me-2">
                                <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">
                                <i class="bi bi-person-plus me-1"></i> Đăng ký
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/profile" class="text-white text-decoration-none me-3 small d-flex align-items-center">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.account.avatar}">
                                        <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle me-1 border border-light" style="width: 28px; height: 28px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person-circle fs-5 me-1"></i>
                                    </c:otherwise>
                                </c:choose>
                                <span>
                                    <strong>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</strong>
                                    <c:if test="${sessionScope.account.roleid == 1}">
                                        <span class="badge bg-danger ms-1">Admin</span>
                                    </c:if>
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline-info btn-sm me-2">
                                <i class="bi bi-person-gear me-1"></i> Hồ sơ
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                                <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Nội dung chính được Decorate bởi SiteMesh 3 -->
    <main class="main-content">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer Template (Bootstrap 5) -->
    <footer>
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-md-6 text-md-start">
                    <p class="mb-0">&copy; 2026 <strong>Lập Trình Web (WEBPR330479)</strong> - Sitemesh Decorator 3 &amp; Bootstrap 5</p>
                    <small class="text-muted">Bộ môn Công nghệ phần mềm - Khoa CNTT - HCMUTE</small>
                </div>
                <div class="col-md-6 text-md-end mt-2 mt-md-0">
                    <span class="badge bg-secondary me-2">JPA 3.0</span>
                    <span class="badge bg-secondary me-2">Jakarta EE 10</span>
                    <span class="badge bg-secondary">Bootstrap 5</span>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
