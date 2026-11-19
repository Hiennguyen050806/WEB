<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - Hệ Thống Video</title>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4 p-md-5">
                    <h3 class="card-title text-center mb-3 fw-bold text-primary">
                        <i class="bi bi-key-fill me-2"></i>Quên Mật Khẩu
                    </h3>
                    <p class="text-muted text-center small mb-4">
                        Nhập địa chỉ email tài khoản của bạn để nhận mã xác thực OTP đặt lại mật khẩu mới.
                    </p>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password" method="post" novalidate>
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Email tài khoản:</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="email" value="${email != null ? email : param.email}" 
                                       class="form-control ${emailError != null ? 'is-invalid' : ''}" 
                                       placeholder="email@example.com" required />
                                <c:if test="${emailError != null}">
                                    <div class="invalid-feedback">${emailError}</div>
                                </c:if>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm">
                            <i class="bi bi-send me-1"></i> Gửi Mã OTP Xác Nhận
                        </button>
                    </form>

                    <div class="text-center mt-4 small text-muted">
                        Nhớ lại mật khẩu? <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
