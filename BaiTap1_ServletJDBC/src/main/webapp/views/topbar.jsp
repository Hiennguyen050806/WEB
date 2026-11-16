<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="topbar" style="background-color: #f8f9fa; padding: 10px 20px; border-bottom: 1px solid #ddd; display: flex; justify-content: space-between; align-items: center;">
    <div>
        <strong>HỆ THỐNG QUẢN LÝ BÁN HÀNG</strong>
    </div>
    <div>
        <c:choose>
            <c:when test="${sessionScope.account == null}">
                <ul style="list-style: none; display: flex; gap: 15px; margin: 0; padding: 0;">
                    <li><a href="${pageContext.request.contextPath}/login" style="text-decoration: none; color: #007bff; font-weight: bold;">Đăng nhập</a></li>
                    <li>|</li>
                    <li><a href="${pageContext.request.contextPath}/register" style="text-decoration: none; color: #28a745; font-weight: bold;">Đăng ký</a></li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul style="list-style: none; display: flex; gap: 15px; margin: 0; padding: 0; align-items: center;">
                    <li>Xin chào, <strong>${sessionScope.account.fullName != null ? sessionScope.account.fullName : sessionScope.account.userName}</strong></li>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <li><span style="background: #dc3545; color: white; padding: 2px 6px; border-radius: 4px; font-size: 12px;">Admin</span></li>
                        <li><a href="${pageContext.request.contextPath}/admin/category/list" style="text-decoration: none; color: #17a2b8;">Quản lý Danh mục</a></li>
                    </c:if>
                    <li>|</li>
                    <li><a href="${pageContext.request.contextPath}/logout" style="text-decoration: none; color: #dc3545; font-weight: bold;">Đăng Xuất</a></li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>
