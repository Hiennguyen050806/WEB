<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục (JPA)</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 20px; }
        .container { width: 450px; margin: 30px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-top: 0; }
        label { font-weight: bold; color: #555; }
        input[type="text"], input[type="file"] { width: 100%; padding: 8px; margin: 6px 0 16px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        .radio-group { margin: 10px 0 20px; }
        .btn-submit { background-color: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .btn-submit:hover { background-color: #218838; }
        .btn-back { color: #6c757d; text-decoration: none; margin-left: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Thêm Danh Mục Mới (JPA)</h2>
    <form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
        <label for="categoryname">Category name:</label><br>
        <input type="text" id="categoryname" name="categoryname" required placeholder="Nhập tên danh mục"><br>

        <label for="images">Link images (URL):</label><br>
        <input type="text" id="images" name="images" placeholder="https://example.com/image.png"><br>

        <label for="images1">Upload images (File):</label><br>
        <input type="file" id="images1" name="images1"><br>

        <label>Status:</label><br>
        <div class="radio-group">
            <input type="radio" id="ston" name="status" value="1" checked>
            <label for="ston" style="font-weight: normal; margin-right: 15px;">Hoạt động</label>
            <input type="radio" id="stoff" name="status" value="0">
            <label for="stoff" style="font-weight: normal;">Khóa</label>
        </div>

        <input type="submit" value="Insert" class="btn-submit">
        <a href="<c:url value='/admin/categories'/>" class="btn-back">Quay lại</a>
    </form>
</div>
</body>
</html>
