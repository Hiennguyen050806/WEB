<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Mục (JDBC Servlet)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; margin: 0; padding: 0; }
        .container { width: 90%; margin: 30px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        h2 { color: #333; margin-top: 0; border-bottom: 2px solid #007bff; padding-bottom: 10px; }
        .action-bar { margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .btn-add { background: #28a745; color: white; padding: 10px 18px; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .btn-add:hover { background: #218838; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #dee2e6; padding: 12px; text-align: center; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f8f9fa; }
        .img-thumb { height: 100px; width: 120px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc; }
        .btn-edit { color: #007bff; text-decoration: none; font-weight: bold; }
        .btn-delete { color: #dc3545; text-decoration: none; font-weight: bold; margin-left: 8px; }
        .btn-edit:hover, .btn-delete:hover { text-decoration: underline; }
    </style>
</head>
<body>
<jsp:include page="/views/topbar.jsp" />

<div class="container">
    <h2>Quản lý danh mục (CRUD Servlet JDBC - PDF 14_HD)</h2>

    <div class="action-bar">
        <a href="<c:url value='/admin/category/add'/>" class="btn-add">+ Thêm danh mục mới</a>
        <a href="<c:url value='/home'/>" style="text-decoration: none; color: #555;">&larr; Về trang chủ</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Tên danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${cateList}" var="cate" varStatus="STT">
                <tr class="odd gradeX">
                    <td>${STT.index + 1}</td>
                    <td>
                        <c:choose>
                            <c:when test="${cate.icon != null && cate.icon.startsWith('http')}">
                                <c:url value="${cate.icon}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.icon}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img class="img-thumb" src="${imgUrl}" alt="${cate.catename}" onerror="this.src='https://via.placeholder.com/120x100?text=No+Image';" />
                    </td>
                    <td style="text-align: left; font-weight: bold;">${cate.catename}</td>
                    <td>
                        <a href="<c:url value='/admin/category/edit?id=${cate.cateid}'/>" class="btn-edit">Sửa</a> |
                        <a href="<c:url value='/admin/category/delete?id=${cate.cateid}'/>" class="btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty cateList}">
                <tr>
                    <td colspan="4" style="color: #888;">Chưa có danh mục nào. Hãy bấm 'Thêm danh mục mới'!</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
