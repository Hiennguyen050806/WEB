<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; margin: 0; padding: 0; }
        .auth-card { width: 380px; margin: 50px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-top: 0; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 6px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 12px; background: #007bff; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background: #0056b3; }
        .footer-links { text-align: center; margin-top: 20px; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="auth-card">
    <h2>Quên Mật Khẩu</h2>
    <p style="font-size: 13px; color: #666; text-align: center;">Nhập email tài khoản của bạn để nhận mã xác nhận OTP đặt lại mật khẩu.</p>

    <c:if test="${alert != null}">
        <div class="alert-error">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group">
            <label>Email tài khoản:</label>
            <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required />
        </div>

        <button type="submit" class="btn-submit">Gửi Mã OTP</button>
    </form>

    <div class="footer-links">
        Nhớ mật khẩu? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
</div>
</body>
</html>
