<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập Vào Hệ Thống</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f2f5; margin: 0; padding: 0; }
        .login-container { width: 380px; margin: 60px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .checkbox-group { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 12px; background-color: #0088cc; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background-color: #006699; }
        .alert-danger { background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; font-size: 14px; }
        .alert-success { background-color: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; font-size: 14px; }
        .footer-links { text-align: center; margin-top: 20px; font-size: 14px; }
        .footer-links a { color: #0088cc; text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/views/topbar.jsp" />

<div class="login-container">
    <h2>Đăng Nhập Vào Hệ Thống</h2>

    <c:if test="${alert != null}">
        <div class="alert-danger">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Tài khoản:</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tài khoản (vd: admin)" required>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu (vd: 123)" required>
        </div>

        <div class="checkbox-group">
            <label><input type="checkbox" name="remember" value="on"> Nhớ tôi (Remember Me)</label>
            <a href="#" style="color: #888; text-decoration: none;">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn-submit">Đăng nhập</button>
    </form>

    <div class="footer-links">
        Nếu bạn chưa có tài khoản trên hệ thống, thì hãy <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </div>
</div>
</body>
</html>
