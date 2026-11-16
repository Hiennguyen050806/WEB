<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Videos (JPA)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .container { width: 90%; max-width: 1200px; margin: 30px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-bar { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-add { background: #28a745; color: white; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background: #007bff; color: white; }
        .thumb { width: 120px; height: 75px; object-fit: cover; border-radius: 4px; }
        .action-link { text-decoration: none; color: #007bff; font-weight: bold; margin: 0 4px; }
        .action-delete { color: #dc3545; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div class="header-bar">
        <h2>Quản Lý Danh Sách Video (JPA CRUD)</h2>
        <div>
            <a href="<c:url value='/admin/video/add'/>" class="btn-add">+ Thêm Video Mới</a>
            <a href="<c:url value='/admin/categories'/>" style="margin-left: 10px; color: #555; text-decoration: none;">&larr; Quản lý Danh mục</a>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>Video ID</th>
                <th>Poster</th>
                <th>Tiêu đề</th>
                <th>Danh mục</th>
                <th>Lượt xem</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${videoList}" var="v">
                <tr>
                    <td><strong>${v.videoId}</strong></td>
                    <td>
                        <c:choose>
                            <c:when test="${v.poster != null && v.poster.startsWith('http')}">
                                <c:url value="${v.poster}" var="pUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${v.poster}" var="pUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img class="thumb" src="${pUrl}" alt="${v.title}" onerror="this.src='https://via.placeholder.com/120x75?text=No+Poster';" />
                    </td>
                    <td style="text-align: left; font-weight: bold;">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" target="_blank" style="color: #007bff; text-decoration: none;">
                            ${v.title}
                        </a>
                    </td>
                    <td>${v.category != null ? v.category.categoryname : 'N/A'}</td>
                    <td>${v.views}</td>
                    <td>
                        <c:choose>
                            <c:when test="${v.active == 1}"><span style="color: #28a745; font-weight: bold;">Hoạt động</span></c:when>
                            <c:otherwise><span style="color: #dc3545; font-weight: bold;">Ẩn</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="<c:url value='/admin/video/edit?id=${v.videoId}'/>" class="action-link">Sửa</a> |
                        <a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" class="action-link action-delete" onclick="return confirm('Bạn chắc chắn muốn xóa video này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty videoList}">
                <tr>
                    <td colspan="7" style="color: #888;">Chưa có video nào trong CSDL.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
