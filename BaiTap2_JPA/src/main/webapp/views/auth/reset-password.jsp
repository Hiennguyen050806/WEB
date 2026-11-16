<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; margin: 0; padding: 0; }
        .auth-card { width: 400px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-top: 0; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 6px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .alert-success { background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 12px; background: #28a745; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background: #218838; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="auth-card">
    <h2>Đặt Lại Mật Khẩu Mới</h2>

    <c:if test="${alert != null}">
        <div class="alert-error">${alert}</div>
    </c:if>
    <c:if test="${success != null}">
        <div class="alert-success">${success}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="email" value="${email}" />

        <div class="form-group">
            <label>Mã xác thực OTP (6 số):</label>
            <input type="text" name="otp" class="form-control" placeholder="Nhập OTP" required />
        </div>

        <div class="form-group">
            <label>Mật khẩu mới:</label>
            <input type="password" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required />
        </div>

        <div class="form-group">
            <label>Xác nhận mật khẩu mới:</label>
            <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required />
        </div>

        <button type="submit" class="btn-submit">Xác Nhận Đổi Mật Khẩu</button>
    </form>
</div>
</body>
</html>
