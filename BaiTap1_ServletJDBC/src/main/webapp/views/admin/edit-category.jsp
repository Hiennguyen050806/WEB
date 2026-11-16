<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Danh Mục (JDBC Servlet)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; margin: 0; padding: 0; }
        .container { width: 500px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-top: 0; border-bottom: 2px solid #007bff; padding-bottom: 10px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #444; }
        .form-control { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .preview-img { height: 120px; width: 150px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; margin-top: 5px; }
        .btn-group { display: flex; gap: 10px; margin-top: 25px; }
        .btn-submit { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background: #0056b3; }
        .btn-reset { background: #6c757d; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
    </style>
</head>
<body>
<jsp:include page="/views/topbar.jsp" />

<div class="container">
    <h2>Chỉnh Sửa Danh Mục</h2>

    <c:url value="/admin/category/edit" var="editUrl" />
    <form role="form" action="${editUrl}" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.cateid}" />

        <div class="form-group">
            <label>Tên danh mục:</label>
            <input type="text" class="form-control" value="${category.catename}" name="catename" required />
        </div>

        <div class="form-group">
            <label>Ảnh hiện tại:</label><br>
            <c:choose>
                <c:when test="${category.icon != null && category.icon.startsWith('http')}">
                    <c:url value="${category.icon}" var="imgUrl" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image?fname=${category.icon}" var="imgUrl" />
                </c:otherwise>
            </c:choose>
            <img class="preview-img" src="${imgUrl}" alt="${category.catename}" onerror="this.src='https://via.placeholder.com/150x120?text=No+Image';" /><br><br>

            <label>Chọn ảnh mới (nếu muốn thay đổi):</label>
            <input type="file" name="icon" class="form-control" />
        </div>

        <div class="btn-group">
            <button type="submit" class="btn-submit">Cập nhật (Update)</button>
            <a href="<c:url value='/admin/category/list'/>" class="btn-reset">Hủy</a>
        </div>
    </form>
</div>
</body>
</html>
