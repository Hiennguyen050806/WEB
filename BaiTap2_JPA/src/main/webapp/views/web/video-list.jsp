<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Video - Phân Trang 6 Video / Trang</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .container { width: 90%; max-width: 1200px; margin: 25px auto; }
        .section-header { border-bottom: 2px solid #28a745; padding-bottom: 8px; margin-bottom: 20px; }
        .video-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media (max-width: 900px) { .video-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 600px) { .video-grid { grid-template-columns: 1fr; } }
        .video-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .video-poster { width: 100%; height: 180px; object-fit: cover; background: #111; }
        .video-body { padding: 15px; }
        .video-title { font-size: 16px; font-weight: bold; margin: 0 0 10px; }
        .video-title a { color: #333; text-decoration: none; }
        .video-title a:hover { color: #28a745; }
        .video-meta { font-size: 13px; color: #666; display: flex; justify-content: space-between; }
        .pagination { display: flex; justify-content: center; gap: 8px; margin: 35px 0; }
        .page-link { padding: 8px 14px; background: white; border: 1px solid #ddd; color: #007bff; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .page-link.active { background: #007bff; color: white; border-color: #007bff; }
        .page-link:hover:not(.active) { background: #e9ecef; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div class="section-header">
        <h2>🎬 Tất Cả Video (Phân trang 6 Video/Trang)</h2>
        <span style="color: #666; font-size: 14px;">Tổng cộng: <strong>${totalVideos}</strong> video | Trang: <strong>${currentPage} / ${totalPages}</strong></span>
    </div>

    <div class="video-grid">
        <c:forEach items="${videoList}" var="v">
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
                    <img class="video-poster" src="${pUrl}" alt="${v.title}" onerror="this.src='https://via.placeholder.com/350x180?text=Video+Player';" />
                </a>
                <div class="video-body">
                    <h3 class="video-title">
                        <!-- Nhấp vào tiêu đề video để xem chi tiết và phát video -->
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}">
                            ${v.title}
                        </a>
                    </h3>
                    <div class="video-meta">
                        <span>👁 ${v.views} lượt xem</span>
                        <span style="background: #e9ecef; padding: 2px 6px; border-radius: 3px;">
                            ${v.category != null ? v.category.categoryname : 'Mặc định'}
                        </span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Thanh phân trang 6sp/trang -->
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/video?page=${currentPage - 1}" class="page-link">&laquo; Trước</a>
        </c:if>

        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="${pageContext.request.contextPath}/video?page=${i}" class="page-link ${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/video?page=${currentPage + 1}" class="page-link">Sau &raquo;</a>
        </c:if>
    </div>
</div>
</body>
</html>
