<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP Kích Hoạt Tài Khoản</title>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4 p-md-5">
                    <h3 class="card-title text-center mb-3 fw-bold text-success">
                        <i class="bi bi-shield-check me-2"></i>Kích Hoạt Tài Khoản
                    </h3>

                    <div class="alert alert-info py-2 small" role="alert">
                        <i class="bi bi-info-circle-fill me-1"></i> Mã OTP 6 chữ số đã được gửi qua email (hoặc in ở Server Console). Mã có hiệu lực trong 5 phút.
                    </div>

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

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <input type="hidden" name="email" value="${email}" />

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email tài khoản:</label>
                            <input type="text" class="form-control bg-light" value="${email}" disabled />
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Nhập mã xác thực OTP (6 số):</label>
                            <input type="text" name="otp" maxlength="6" 
                                   class="form-control text-center fw-bold fs-4" 
                                   style="letter-spacing: 6px;" 
                                   placeholder="000000" required autofocus />
                        </div>

                        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold shadow-sm">
                            <i class="bi bi-check2-circle me-1"></i> Kích Hoạt Ngay
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
