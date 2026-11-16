<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - 10 Video Mới Nhất (JPA)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .container { width: 90%; max-width: 1200px; margin: 25px auto; }
        .section-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #007bff; padding-bottom: 8px; margin-bottom: 20px; }
        .section-header h2 { margin: 0; color: #333; }
        .view-all { color: #007bff; text-decoration: none; font-weight: bold; }
        .video-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        .video-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: transform 0.2s; }
        .video-card:hover { transform: translateY(-4px); }
        .video-poster { width: 100%; height: 140px; object-fit: cover; background: #222; }
        .video-body { padding: 12px; }
        .video-title { font-size: 15px; font-weight: bold; margin: 0 0 8px; line-height: 1.3; }
        .video-title a { color: #212529; text-decoration: none; }
        .video-title a:hover { color: #007bff; }
        .video-meta { font-size: 12px; color: #6c757d; display: flex; justify-content: space-between; }
        .badge-cat { background: #e9ecef; color: #495057; padding: 2px 6px; border-radius: 3px; font-size: 11px; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div class="section-header">
        <h2>🔥 10 Video Mới Nhất</h2>
        <a href="${pageContext.request.contextPath}/video" class="view-all">Xem tất cả video (Phân trang) &rarr;</a>
    </div>

    <div class="video-grid">
        <c:forEach items="${top10Videos}" var="v">
            <div class="video-card">
                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}">
                    <c:choose>
                        <c:when test="${v.poster != null && v.poster.startsWith('http')}">
                            <c:url value="${v.poster}" var="pUrl" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${v.poster}" var="pUrl" />
                        </c:otherwise>
                    </c:choose>
                    <img class="video-poster" src="${pUrl}" alt="${v.title}" onerror="this.src='https://via.placeholder.com/260x140?text=Video+Poster';" />
                </a>
                <div class="video-body">
                    <h3 class="video-title">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}">
                            ${v.title}
                        </a>
                    </h3>
                    <div class="video-meta">
                        <span>👁 ${v.views} lượt xem</span>
                        <span class="badge-cat">${v.category != null ? v.category.categoryname : 'Chung'}</span>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty top10Videos}">
            <p style="color: #888; grid-column: 1 / -1; text-align: center; padding: 40px;">
                Chưa có video nào trong hệ thống! Vui lòng đăng nhập với tài khoản Admin để thêm Video hoặc chạy file `Test.java`.
            </p>
        </c:if>
    </div>
</div>
</body>
</html>
