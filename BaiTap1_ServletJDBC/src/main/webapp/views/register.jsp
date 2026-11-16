<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản Mới</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f2f5; margin: 0; padding: 0; }
        .register-container { width: 420px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .btn-submit { width: 100%; padding: 12px; background-color: #28a745; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background-color: #218838; }
        .alert-danger { background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; font-size: 14px; }
        .footer-links { text-align: center; margin-top: 20px; font-size: 14px; }
        .footer-links a { color: #0088cc; text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/views/topbar.jsp" />

<div class="register-container">
    <h2>Tạo tài khoản mới</h2>

    <c:if test="${alert != null}">
        <div class="alert-danger">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label for="username">Tài khoản:</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required>
        </div>

        <div class="form-group">
            <label for="fullname">Họ tên:</label>
            <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Nhập họ và tên đầy đủ" required>
        </div>

        <div class="form-group">
            <label for="email">Nhập Email:</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="Nhập địa chỉ email" required>
        </div>

        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone" class="form-control" placeholder="Nhập số điện thoại">
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
        </div>

        <button type="submit" class="btn-submit">Tạo tài khoản</button>
    </form>

    <div class="footer-links">
        Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
</div>
</body>
</html>
