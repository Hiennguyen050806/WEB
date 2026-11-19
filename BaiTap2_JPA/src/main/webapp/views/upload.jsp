<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Upload File trong Java Servlet</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 30px; }
        .upload-card { background: white; width: 500px; margin: 20px auto; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-top: 0; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 6px; }
        input[type="text"], input[type="file"] { width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        input[type="submit"] { background: #007bff; color: white; border: none; padding: 10px 20px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        input[type="submit"]:hover { background: #0056b3; }
    </style>
</head>
<body>
    <div class="upload-card">
        <h2>Upload File Lên Server (@MultipartConfig)</h2>
        <form method="post" action="${pageContext.request.contextPath}/multiPartServlet" enctype="multipart/form-data">
            <div class="form-group">
                <label>Select file to upload:</label>
                <input type="file" name="multiPartServlet" required />
            </div>

            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" size="100" placeholder="Nhập tên hoặc ghi chú file" />
            </div>

            <input type="submit" value="Upload" />
            <a href="${pageContext.request.contextPath}/home" style="margin-left: 15px; color: #555; text-decoration: none;">&larr; Về trang chủ</a>
        </form>
    </div>
</body>
</html>
