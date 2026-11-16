<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Website</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .main-container { width: 80%; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .welcome-box { padding: 20px; background-color: #e9ecef; border-left: 5px solid #007bff; border-radius: 4px; }
    </style>
</head>
<body>
<jsp:include page="/views/topbar.jsp" />

<div class="main-container">
    <h2>Chào mừng đến với hệ thống Website Bán Hàng</h2>
    <div class="welcome-box">
        <p>Xin chào, <strong>${sessionScope.account != null ? sessionScope.account.fullName : 'Khách'}</strong>!</p>
        <p>Bạn đã đăng nhập thành công vào hệ thống với vai trò: 
            <c:choose>
                <c:when test="${sessionScope.account.roleid == 1}"><strong>Quản trị viên (Admin)</strong></c:when>
                <c:when test="${sessionScope.account.roleid == 2}"><strong>Quản lý (Manager)</strong></c:when>
                <c:otherwise><strong>Khách hàng / Thành viên (User)</strong></c:otherwise>
            </c:choose>
        </p>
        <c:if test="${sessionScope.account.roleid == 1}">
            <p><a href="${pageContext.request.contextPath}/admin/category/list" style="color: #007bff; font-weight: bold;">Đi đến trang Quản lý danh mục (Category CRUD)</a></p>
        </c:if>
    </div>
</div>
</body>
</html>
