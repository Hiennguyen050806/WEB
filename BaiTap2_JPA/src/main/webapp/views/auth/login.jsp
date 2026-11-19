<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - Hệ Thống Video &amp; Bán Hàng</title>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4 p-md-5">
                    <h3 class="card-title text-center mb-4 fw-bold text-primary">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Đăng Nhập
                    </h3>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                        </div>
                    </c:if>
                    <c:if test="${success != null}">
                        <div class="alert alert-success py-2 small" role="alert">
                            <i class="bi bi-check-circle-fill me-1"></i> ${success}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập:</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" name="username" value="${username != null ? username : param.username}" 
                                       class="form-control ${errors.username != null ? 'is-invalid' : ''}" 
                                       placeholder="Nhập tên đăng nhập" required />
                                <c:if test="${errors.username != null}">
                                    <div class="invalid-feedback">${errors.username}</div>
                                </c:if>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu (SHA-256):</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                                <input type="password" name="password" 
                                       class="form-control ${errors.password != null ? 'is-invalid' : ''}" 
                                       placeholder="Nhập mật khẩu" required />
                                <c:if test="${errors.password != null}">
                                    <div class="invalid-feedback">${errors.password}</div>
                                </c:if>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3 small">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="remember" value="on" id="rememberMe">
                                <label class="form-check-label text-muted" for="rememberMe">Ghi nhớ đăng nhập</label>
                            </div>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">Quên mật khẩu?</a>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập
                        </button>
                    </form>

                    <div class="text-center mt-4 small text-muted">
                        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-decoration-none">Đăng ký ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
