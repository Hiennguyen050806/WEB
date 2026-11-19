<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu - Hệ Thống Video</title>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4 p-md-5">
                    <h3 class="card-title text-center mb-3 fw-bold text-success">
                        <i class="bi bi-shield-lock-fill me-2"></i>Đặt Lại Mật Khẩu
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

                    <form action="${pageContext.request.contextPath}/reset-password" method="post" novalidate>
                        <input type="hidden" name="email" value="${email}" />

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mã xác thực OTP (6 số):</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-123"></i></span>
                                <input type="text" name="otp" maxlength="6" 
                                       class="form-control text-center fw-bold fs-5 ${errors.otp != null ? 'is-invalid' : ''}" 
                                       placeholder="123456" required />
                                <c:if test="${errors.otp != null}">
                                    <div class="invalid-feedback">${errors.otp}</div>
                                </c:if>
                            </div>
                            <div class="form-text small text-muted">Kiểm tra hộp thư email hoặc Server Console để lấy mã OTP.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu mới:</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                                <input type="password" name="newPassword" 
                                       class="form-control ${errors.newPassword != null ? 'is-invalid' : ''}" 
                                       placeholder="Tối thiểu 6 ký tự" required />
                                <c:if test="${errors.newPassword != null}">
                                    <div class="invalid-feedback">${errors.newPassword}</div>
                                </c:if>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Xác nhận mật khẩu mới:</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-check2-circle"></i></span>
                                <input type="password" name="confirmPassword" 
                                       class="form-control ${errors.confirmPassword != null ? 'is-invalid' : ''}" 
                                       placeholder="Nhập lại mật khẩu mới" required />
                                <c:if test="${errors.confirmPassword != null}">
                                    <div class="invalid-feedback">${errors.confirmPassword}</div>
                                </c:if>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold shadow-sm">
                            <i class="bi bi-check-lg me-1"></i> Xác Nhận Đổi Mật Khẩu
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
