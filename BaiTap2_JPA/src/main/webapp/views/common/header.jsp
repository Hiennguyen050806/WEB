<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav style="background: #20232a; padding: 12px 30px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 2px 8px rgba(0,0,0,0.2);">
    <div style="display: flex; align-items: center; gap: 25px;">
        <a href="${pageContext.request.contextPath}/home" style="color: #61dafb; font-size: 20px; font-weight: bold; text-decoration: none;">VIDEO PORTAL</a>
        <a href="${pageContext.request.contextPath}/home" style="color: #ddd; text-decoration: none; font-size: 15px;">Trang Chủ (10 Video Mới)</a>
        <a href="${pageContext.request.contextPath}/video" style="color: #ddd; text-decoration: none; font-size: 15px;">Tất Cả Video (Phân trang)</a>
        <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
            <span style="color: #666;">|</span>
            <a href="${pageContext.request.contextPath}/admin/categories" style="color: #ffc107; text-decoration: none; font-size: 14px;">Quản lý Danh mục (JPA)</a>
            <a href="${pageContext.request.contextPath}/admin/videos" style="color: #ffc107; text-decoration: none; font-size: 14px;">Quản lý Video (JPA)</a>
        </c:if>
    </div>

    <div>
        <c:choose>
            <c:when test="${sessionScope.account == null}">
                <a href="${pageContext.request.contextPath}/login" style="color: white; background: #007bff; padding: 6px 14px; border-radius: 4px; text-decoration: none; font-size: 14px; margin-right: 8px;">Đăng nhập</a>
                <a href="${pageContext.request.contextPath}/register" style="color: white; background: #28a745; padding: 6px 14px; border-radius: 4px; text-decoration: none; font-size: 14px;">Đăng ký</a>
            </c:when>
            <c:otherwise>
                <span style="margin-right: 15px; font-size: 14px;">
                    Xin chào, <strong>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</strong>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <span style="background: #dc3545; color: white; padding: 2px 6px; border-radius: 3px; font-size: 11px;">Admin</span>
                    </c:if>
                </span>
                <a href="${pageContext.request.contextPath}/logout" style="color: #ff6b6b; text-decoration: none; font-weight: bold; font-size: 14px;">Đăng xuất</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
