<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục (JPA 3.0 & Jakarta 6.0)</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 20px; }
        .container { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; }
        a.btn-add { display: inline-block; background-color: #007bff; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; font-weight: bold; margin-bottom: 15px; }
        a.btn-add:hover { background-color: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f2f2f2; }
        img.thumb { height: 120px; width: 160px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc; }
        .status-active { color: #28a745; font-weight: bold; }
        .status-locked { color: #dc3545; font-weight: bold; }
        .action-link { text-decoration: none; color: #007bff; font-weight: bold; margin: 0 5px; }
        .action-delete { color: #dc3545; }
    </style>
</head>
<body>
<div class="container">
    <h2>Danh sách Danh mục (JPA 3.0 - Hibernate)</h2>
    <a href="<c:url value="/admin/category/add"/>" class="btn-add">+ Add Category</a>
    <hr>
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Images</th>
                <th>Category name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listcate}" var="cate" varStatus="STT">
                <tr>
                    <td>${STT.index + 1}</td>
                    <c:choose>
                        <c:when test="${cate.images != null && cate.images.startsWith('http')}">
                            <c:url value="${cate.images}" var="imgUrl"></c:url>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                        </c:otherwise>
                    </c:choose>
                    <td><img class="thumb" src="${imgUrl}" alt="${cate.categoryname}" onerror="this.src='https://via.placeholder.com/160x120?text=No+Image';" /></td>
                    <td style="font-weight: bold; text-align: left;">${cate.categoryname}</td>
                    <td>
                        <c:if test="${cate.status == 1}">
                            <span class="status-active">Hoạt động</span>
                        </c:if>
                        <c:if test="${cate.status != 1}">
                            <span class="status-locked">Khóa</span>
                        </c:if>
                    </td>
                    <td>
                        <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="action-link">Sửa</a> |
                        <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="action-link action-delete" onclick="return confirm('Bạn chắc chắn muốn xóa danh mục này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listcate}">
                <tr>
                    <td colspan="5" style="color: #888;">Chưa có dữ liệu danh mục nào.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
