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
        .section-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #28a745; padding-bottom: 12px; margin-bottom: 20px; }
        .filter-tabs { display: flex; gap: 10px; }
        .tab-btn { padding: 8px 16px; border-radius: 4px; text-decoration: none; font-weight: bold; font-size: 14px; border: 1px solid #ccc; background: #fff; color: #333; }
        .tab-btn.active { background: #28a745; color: white; border-color: #28a745; }
        .video-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media (max-width: 900px) { .video-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 600px) { .video-grid { grid-template-columns: 1fr; } }
        .video-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: transform 0.2s; }
        .video-card:hover { transform: translateY(-4px); }
        .video-poster { width: 100%; height: 180px; object-fit: cover; background: #111; }
        .video-body { padding: 15px; }
        .video-title { font-size: 16px; font-weight: bold; margin: 0 0 10px; }
        .video-title a { color: #333; text-decoration: none; }
        .video-title a:hover { color: #28a745; }
        .video-meta { font-size: 13px; color: #666; display: flex; justify-content: space-between; margin-bottom: 6px; }
        .video-author { font-size: 12px; color: #007bff; font-weight: 500; }
        .pagination { display: flex; justify-content: center; gap: 8px; margin: 35px 0; }
        .page-link { padding: 8px 14px; background: white; border: 1px solid #ddd; color: #007bff; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .page-link.active { background: #007bff; color: white; border-color: #007bff; }
        .page-link:hover:not(.active) { background: #e9ecef; }
        .empty-box { grid-column: 1 / -1; text-align: center; padding: 50px; background: white; border-radius: 8px; color: #777; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div class="section-header">
        <div>
            <h2 style="margin: 0 0 5px 0;">
                <c:choose>
                    <c:when test="${isMyVideos}">
                        📁 Tất Cả Videos Của Bạn (${currentUser.fullname != null ? currentUser.fullname : currentUser.username})
                    </c:when>
                    <c:otherwise>
                        🎬 Tất Cả Video Hệ Thống
                    </c:otherwise>
                </c:choose>
            </h2>
            <span style="color: #666; font-size: 14px;">Phân trang: <strong>6 video/trang</strong> | Tổng: <strong>${totalVideos}</strong> video | Trang: <strong>${currentPage} / ${totalPages}</strong></span>
        </div>

        <!-- Chuyển đổi giữa video của tôi và tất cả video -->
        <div class="filter-tabs">
            <c:if test="${currentUser != null}">
                <a href="${pageContext.request.contextPath}/video?scope=my" class="tab-btn ${isMyVideos ? 'active' : ''}">Video Của Tôi</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/video?scope=all" class="tab-btn ${!isMyVideos ? 'active' : ''}">Tất Cả Video</a>
            <c:if test="${currentUser != null}">
                <a href="${pageContext.request.contextPath}/admin/video/add" class="tab-btn" style="background:#007bff; color:white; border-color:#007bff;">+ Đăng Video Mới</a>
            </c:if>
        </div>
    </div>

    <div class="video-grid">
        <c:forEach items="${videoList}" var="v">
            <div class="video-card">
                <!-- Click poster xem chi tiết và phát video -->
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
                        <!-- Click chuột vào tiêu đề để xem chi tiết và play video -->
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
                    <div class="video-author">
                        👤 Người đăng: ${v.user != null ? (v.user.fullname != null ? v.user.fullname : v.user.username) : 'Hệ thống'}
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty videoList}">
            <div class="empty-box">
                <p style="font-size: 16px;">Chưa có video nào trong danh sách này!</p>
                <c:if test="${currentUser != null}">
                    <a href="${pageContext.request.contextPath}/admin/video/add" style="color:#007bff; font-weight:bold;">Bấm vào đây để tải lên video đầu tiên của bạn</a>
                </c:if>
                <c:if test="${currentUser == null}">
                    <a href="${pageContext.request.contextPath}/login" style="color:#007bff; font-weight:bold;">Đăng nhập để xem và quản lý video cá nhân</a>
                </c:if>
            </div>
        </c:if>
    </div>

    <!-- Thanh phân trang 6sp/trang -->
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/video?scope=${scope}&page=${currentPage - 1}" class="page-link">&laquo; Trước</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${pageContext.request.contextPath}/video?scope=${scope}&page=${i}" class="page-link ${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/video?scope=${scope}&page=${currentPage + 1}" class="page-link">Sau &raquo;</a>
            </c:if>
        </div>
    </c:if>
</div>
</body>
</html>
