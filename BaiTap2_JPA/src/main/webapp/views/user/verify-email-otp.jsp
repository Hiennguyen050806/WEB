<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP Đổi Email Mới</title>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow border-0 rounded-4">
                <div class="card-header bg-warning text-dark text-center py-3 rounded-top-4">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-shield-check me-2"></i> Xác Thực Email Mới
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 text-warning mb-2">
                            <i class="bi bi-envelope-check"></i>
                        </div>
                        <p class="text-muted">
                            Hệ thống đã gửi một mã OTP (6 chữ số) đến địa chỉ email mới:
                            <br><strong class="text-primary">${sessionScope.pendingEmail}</strong>
                        </p>
                        <div class="alert alert-info py-2 small mb-0">
                            <i class="bi bi-info-circle me-1"></i> Mã OTP cũng được hiển thị trực tiếp trên <strong>Server Console</strong> để tiện kiểm tra.
                        </div>
                    </div>

                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${alert}</div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/verify-email-otp" method="post">
                        <div class="mb-3">
                            <label for="otp" class="form-label fw-semibold">Nhập mã OTP xác thực:</label>
                            <input type="text" class="form-control form-control-lg text-center fw-bold letter-spacing-2" 
                                   id="otp" name="otp" maxlength="6" placeholder="______" required autofocus
                                   style="letter-spacing: 0.5rem; font-size: 1.5rem;">
                            <div class="form-text text-center">Mã OTP gồm 6 chữ số và có hiệu lực trong vòng 10 phút.</div>
                        </div>

                        <div class="d-grid gap-2 pt-2">
                            <button type="submit" class="btn btn-warning btn-lg fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i> Xác nhận đổi Email
                            </button>
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Hủy bỏ và quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
