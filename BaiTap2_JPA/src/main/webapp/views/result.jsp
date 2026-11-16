<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết Quả Upload</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 30px;">
    <h2>Thông Báo Upload File</h2>
    <div style="padding: 15px; background: #e8f5e9; border: 1px solid #4caf50; border-radius: 4px; color: #2e7d32;">
        ${message}
    </div>
    <br>
    <a href="${pageContext.request.contextPath}/home">&larr; Về Trang Chủ</a> | 
    <a href="${pageContext.request.contextPath}/multiPartServlet">Tiếp tục upload</a>
</body>
</html>
