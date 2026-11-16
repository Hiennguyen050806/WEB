<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản - Kích Hoạt OTP</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; margin: 0; padding: 0; }
        .auth-card { width: 420px; margin: 30px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-top: 0; }
        .form-group { margin-bottom: 12px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 9px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 11px; background: #28a745; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background: #218838; }
        .footer-links { text-align: center; margin-top: 15px; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
        .info-note { font-size: 12px; color: #666; margin-top: 4px; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="auth-card">
    <h2>Đăng Ký Tài Khoản</h2>

    <c:if test="${alert != null}">
        <div class="alert-error">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>Tên đăng nhập:</label>
            <input type="text" name="username" class="form-control" required placeholder="Nhập username" />
        </div>

        <div class="form-group">
            <label>Email nhận mã OTP:</label>
            <input type="email" name="email" class="form-control" required placeholder="example@gmail.com" />
            <div class="info-note">* Mã xác thực OTP sẽ được gửi về email này (và hiển thị tại Server Console).</div>
        </div>

        <div class="form-group">
            <label>Họ và tên:</label>
            <input type="text" name="fullname" class="form-control" required placeholder="Họ và tên" />
        </div>

        <div class="form-group">
            <label>Số điện thoại:</label>
            <input type="text" name="phone" class="form-control" placeholder="Số điện thoại" />
        </div>

        <div class="form-group">
            <label>Mật khẩu:</label>
            <input type="password" name="password" class="form-control" required placeholder="Mật khẩu" />
            <div class="info-note">* Mật khẩu sẽ được mã hóa an toàn bằng SHA-256 Hash.</div>
        </div>

        <button type="submit" class="btn-submit">Đăng Ký &amp; Nhận OTP</button>
    </form>

    <div class="footer-links">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
    </div>
</div>
</body>
</html>
