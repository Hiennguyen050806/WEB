<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản - Kích Hoạt OTP</title>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4 p-md-5">
                    <h3 class="card-title text-center mb-4 fw-bold text-success">
                        <i class="bi bi-person-plus-fill me-2"></i>Đăng Ký Tài Khoản
                    </h3>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span>:</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" name="username" value="${username != null ? username : param.username}" 
                                       class="form-control ${errors.username != null ? 'is-invalid' : ''}" 
                                       placeholder="Ví dụ: nguyenvana (3-30 ký tự)" required />
                                <c:if test="${errors.username != null}">
                                    <div class="invalid-feedback">${errors.username}</div>
                                </c:if>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email nhận mã OTP <span class="text-danger">*</span>:</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="email" value="${email != null ? email : param.email}" 
                                       class="form-control ${errors.email != null ? 'is-invalid' : ''}" 
                                       placeholder="email@example.com" required />
                                <c:if test="${errors.email != null}">
                                    <div class="invalid-feedback">${errors.email}</div>
                                </c:if>
                            </div>
                            <div class="form-text small text-muted"><i class="bi bi-info-circle me-1"></i>Mã OTP 6 chữ số sẽ được gửi về email (và console server).</div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span>:</label>
                                <input type="text" name="fullname" value="${fullname != null ? fullname : param.fullname}" 
                                       class="form-control ${errors.fullname != null ? 'is-invalid' : ''}" 
                                       placeholder="Nguyễn Văn A" required />
                                <c:if test="${errors.fullname != null}">
                                    <div class="invalid-feedback">${errors.fullname}</div>
                                </c:if>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Số điện thoại:</label>
                                <input type="text" name="phone" value="${phone != null ? phone : param.phone}" 
                                       class="form-control ${errors.phone != null ? 'is-invalid' : ''}" 
                                       placeholder="0901234567" />
                                <c:if test="${errors.phone != null}">
                                    <div class="invalid-feedback">${errors.phone}</div>
                                </c:if>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span>:</label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                                    <input type="password" name="password" 
                                           class="form-control ${errors.password != null ? 'is-invalid' : ''}" 
                                           placeholder="Tối thiểu 6 ký tự" required />
                                    <c:if test="${errors.password != null}">
                                        <div class="invalid-feedback">${errors.password}</div>
                                    </c:if>
                                </div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Xác nhận mật khẩu <span class="text-danger">*</span>:</label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light"><i class="bi bi-shield-check"></i></span>
                                    <input type="password" name="confirmPassword" 
                                           class="form-control ${errors.confirmPassword != null ? 'is-invalid' : ''}" 
                                           placeholder="Nhập lại mật khẩu" required />
                                    <c:if test="${errors.confirmPassword != null}">
                                        <div class="invalid-feedback">${errors.confirmPassword}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold mt-2 shadow-sm">
                            <i class="bi bi-send-check me-1"></i> Đăng Ký &amp; Nhận OTP Kích Hoạt
                        </button>
                    </form>

                    <div class="text-center mt-4 small text-muted">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none">Đăng nhập ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
