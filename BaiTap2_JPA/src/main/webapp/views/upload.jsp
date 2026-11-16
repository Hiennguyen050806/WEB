<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>File Upload Demo (Servlet Multipart)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .box { background: #f8f9fa; padding: 20px; border-radius: 8px; width: 450px; margin-bottom: 20px; border: 1px solid #ddd; }
        input[type="submit"] { background: #007bff; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>
    <h2>File Upload Demo</h2>

    <div class="box">
        <h3>Servlet Multipart</h3>
        <form method="post" action="${pageContext.request.contextPath}/multiPartServlet" enctype="multipart/form-data">
            Choose a file: <input type="file" name="multiPartServlet" required /><br><br>
            <input type="submit" value="Upload" />
        </form>
    </div>
</body>
</html>
