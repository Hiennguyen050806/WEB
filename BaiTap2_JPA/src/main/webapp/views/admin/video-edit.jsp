<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Video (JPA)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .form-box { width: 550px; margin: 30px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { margin-top: 0; color: #333; border-bottom: 2px solid #007bff; padding-bottom: 8px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        textarea.form-control { height: 75px; resize: vertical; }
        .preview-img { width: 180px; height: 110px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc; margin-bottom: 8px; }
        .btn-submit { background: #007bff; color: white; border: none; padding: 10px 20px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .btn-submit:hover { background: #0056b3; }
        .btn-back { color: #666; text-decoration: none; margin-left: 15px; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="form-box">
    <h2>Cập Nhật Video</h2>
    <form action="<c:url value='/admin/video/update'/>" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Mã Video (Không được sửa):</label>
            <input type="text" name="videoId" value="${video.videoId}" class="form-control" readonly style="background:#eee;" />
        </div>

        <div class="form-group">
            <label>Tiêu đề Video:</label>
            <input type="text" name="title" value="${video.title}" class="form-control" required />
        </div>

        <div class="form-group">
            <label>Danh mục (Category):</label>
            <select name="categoryId" class="form-control" required>
                <c:forEach items="${categories}" var="c">
                    <option value="${c.categoryid}" ${video.category != null && video.category.categoryid == c.categoryid ? 'selected' : ''}>
                        ${c.categoryname}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Poster hiện tại:</label><br>
            <c:choose>
                <c:when test="${video.poster != null && video.poster.startsWith('http')}">
                    <c:url value="${video.poster}" var="pUrl" />
                </c:when>
                <c:otherwise>
                    <c:url value="/image?fname=${video.poster}" var="pUrl" />
                </c:otherwise>
            </c:choose>
            <img class="preview-img" src="${pUrl}" alt="${video.title}" onerror="this.src='https://via.placeholder.com/180x110?text=No+Poster';" /><br>
            <input type="text" name="poster" value="${video.poster}" class="form-control" placeholder="URL poster" />
        </div>

        <div class="form-group">
            <label>Chọn Poster mới (File):</label>
            <input type="file" name="posterFile" class="form-control" />
        </div>

        <div class="form-group">
            <label>Mô tả (Description):</label>
            <textarea name="description" class="form-control">${video.description}</textarea>
        </div>

        <div class="form-group">
            <label>Trạng thái:</label>
            <input type="radio" name="active" value="1" ${video.active == 1 ? 'checked' : ''} id="act1" /> <label for="act1" style="display:inline; font-weight:normal; margin-right:15px;">Hoạt động</label>
            <input type="radio" name="active" value="0" ${video.active != 1 ? 'checked' : ''} id="act0" /> <label for="act0" style="display:inline; font-weight:normal;">Ẩn</label>
        </div>

        <button type="submit" class="btn-submit">Lưu Thay Đổi</button>
        <a href="<c:url value='/admin/videos'/>" class="btn-back">Hủy bỏ</a>
    </form>
</div>
</body>
</html>
