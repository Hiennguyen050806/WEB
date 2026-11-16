<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Video Mới (JPA)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .form-box { width: 550px; margin: 30px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { margin-top: 0; color: #333; border-bottom: 2px solid #28a745; padding-bottom: 8px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .form-control { width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        textarea.form-control { height: 75px; resize: vertical; }
        .btn-submit { background: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .btn-submit:hover { background: #218838; }
        .btn-back { color: #666; text-decoration: none; margin-left: 15px; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="form-box">
    <h2>Thêm Video Mới</h2>
    <form action="<c:url value='/admin/video/insert'/>" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Mã Video (Video ID):</label>
            <input type="text" name="videoId" class="form-control" placeholder="vd: v01, demo01" required />
        </div>

        <div class="form-group">
            <label>Tiêu đề Video:</label>
            <input type="text" name="title" class="form-control" placeholder="Tiêu đề video" required />
        </div>

        <div class="form-group">
            <label>Danh mục (Category):</label>
            <select name="categoryId" class="form-control" required>
                <c:forEach items="${categories}" var="c">
                    <option value="${c.categoryid}">${c.categoryname}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Link Poster (URL):</label>
            <input type="text" name="poster" class="form-control" placeholder="https://example.com/poster.jpg" />
        </div>

        <div class="form-group">
            <label>Hoặc Upload Poster / Video File (Multipart):</label>
            <input type="file" name="posterFile" class="form-control" />
        </div>

        <div class="form-group">
            <label>Mô tả (Description / Link nhúng video):</label>
            <textarea name="description" class="form-control" placeholder="Nhập mô tả hoặc link video"></textarea>
        </div>

        <div class="form-group">
            <label>Trạng thái:</label>
            <input type="radio" name="active" value="1" checked id="act1" /> <label for="act1" style="display:inline; font-weight:normal; margin-right:15px;">Hoạt động</label>
            <input type="radio" name="active" value="0" id="act0" /> <label for="act0" style="display:inline; font-weight:normal;">Ẩn</label>
        </div>

        <button type="submit" class="btn-submit">Thêm Video</button>
        <a href="<c:url value='/admin/videos'/>" class="btn-back">Hủy bỏ</a>
    </form>
</div>
</body>
</html>
