<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - Xác Thực JPA</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; margin: 0; padding: 0; }
        .auth-card { width: 380px; margin: 50px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-top: 0; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 6px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .alert-success { background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 12px; background: #007bff; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background: #0056b3; }
        .checkbox-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; font-size: 13px; }
        .footer-links { text-align: center; margin-top: 20px; font-size: 14px; }
        .footer-links a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="auth-card">
    <h2>Đăng Nhập</h2>

    <c:if test="${alert != null}">
        <div class="alert-error">${alert}</div>
    </c:if>
    <c:if test="${success != null}">
        <div class="alert-success">${success}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>Tên đăng nhập:</label>
            <input type="text" name="username" class="form-control" placeholder="Nhập username" required />
        </div>

        <div class="form-group">
            <label>Mật khẩu (Được mã hóa Hash):</label>
            <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required />
        </div>

        <div class="checkbox-row">
            <label><input type="checkbox" name="remember" value="on" /> Ghi nhớ đăng nhập</label>
            <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn-submit">Đăng Nhập</button>
    </form>

    <div class="footer-links">
        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
    </div>
</div>
</body>
</html>
