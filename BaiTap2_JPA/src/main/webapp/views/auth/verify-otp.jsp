<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP Kích Hoạt Tài Khoản</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; margin: 0; padding: 0; }
        .auth-card { width: 400px; margin: 50px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); text-align: center; }
        h2 { color: #333; margin-top: 0; }
        .form-group { margin-bottom: 20px; text-align: left; }
        label { display: block; margin-bottom: 6px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 12px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 16px; text-align: center; letter-spacing: 4px; font-weight: bold; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; text-align: left; }
        .alert-success { background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; text-align: left; }
        .btn-submit { width: 100%; padding: 12px; background: #28a745; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background: #218838; }
        .hint-box { background: #e7f3fe; border-left: 4px solid #2196F3; padding: 10px; margin-bottom: 20px; text-align: left; font-size: 13px; color: #0c5460; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="auth-card">
    <h2>Xác Thực Mã OTP</h2>

    <div class="hint-box">
        Mã OTP 6 chữ số đã được gửi qua email (hoặc được in trên Server Console để bạn kiểm tra). Mã có hiệu lực trong 5 phút.
    </div>

    <c:if test="${alert != null}">
        <div class="alert-error">${alert}</div>
    </c:if>
    <c:if test="${success != null}">
        <div class="alert-success">${success}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="email" value="${email}" />

        <div class="form-group">
            <label>Email xác nhận:</label>
            <input type="text" class="form-control" value="${email}" disabled style="letter-spacing: normal; font-weight: normal; background: #f9f9f9;" />
        </div>

        <div class="form-group">
            <label>Nhập mã OTP (6 số):</label>
            <input type="text" name="otp" class="form-control" maxlength="6" placeholder="000000" required autofocus />
        </div>

        <button type="submit" class="btn-submit">Kích Hoạt Tài Khoản</button>
    </form>
</div>
</body>
</html>
