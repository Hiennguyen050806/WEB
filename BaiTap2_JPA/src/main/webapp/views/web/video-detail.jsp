<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${video.title} - Xem &amp; Phát Video</title>
    <style>
        body { font-family: Arial, sans-serif; background: #0f0f0f; color: #fff; margin: 0; padding: 0; }
        .detail-container { width: 92%; max-width: 1250px; margin: 25px auto; display: flex; gap: 30px; }
        .player-column { flex: 7; }
        .sidebar-column { flex: 3; }
        .video-player-box { width: 100%; aspect-ratio: 16/9; background: #000; border-radius: 8px; overflow: hidden; }
        .video-player-box video { width: 100%; height: 100%; object-fit: contain; }
        .video-player-box iframe { width: 100%; height: 100%; border: none; }
        .video-info { margin-top: 15px; }
        .video-title { font-size: 22px; font-weight: bold; margin-bottom: 8px; }
        .video-stats { display: flex; justify-content: space-between; color: #aaa; font-size: 14px; border-bottom: 1px solid #333; padding-bottom: 12px; }
        .video-user-box { display: flex; align-items: center; gap: 12px; padding: 12px 0; border-bottom: 1px solid #333; }
        .user-avatar { width: 45px; height: 45px; border-radius: 50%; background: #007bff; display: flex; align-items: center; justify-content: center; font-weight: bold; color: white; }
        .video-desc { margin-top: 15px; line-height: 1.6; color: #ddd; background: #222; padding: 15px; border-radius: 8px; font-size: 14px; }
        .related-card { display: flex; gap: 10px; margin-bottom: 15px; text-decoration: none; color: #fff; }
        .related-thumb { width: 120px; height: 75px; object-fit: cover; border-radius: 4px; background: #222; }
        .related-title { font-size: 13px; font-weight: bold; margin: 0 0 5px; color: #eee; }
        .related-views { font-size: 11px; color: #888; }
    </style>
</head>
<body>
<jsp:include page="/views/common/header.jsp" />

<div class="detail-container">
    <!-- Cột chính phát video -->
    <div class="player-column">
        <div class="video-player-box">
            <c:choose>
                <c:when test="${video.description != null && video.description.contains('youtube.com')}">
                    <iframe src="${video.description}" allowfullscreen></iframe>
                </c:when>
                <c:otherwise>
                    <!-- HTML5 Player phát video upload hoặc file đính kèm -->
                    <video controls autoplay poster="<c:url value='/image?fname=${video.poster}'/>">
                        <source src="<c:url value='/image?fname=${video.poster}'/>" type="video/mp4">
                        Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
                    </video>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="video-info">
            <h1 class="video-title">${video.title}</h1>
            <div class="video-stats">
                <span>👁 ${video.views} lượt xem</span>
                <span>Danh mục: <strong style="color: #61dafb;">${video.category != null ? video.category.categoryname : 'Chung'}</strong></span>
            </div>

            <!-- Thông tin User đăng video (Mối quan hệ 1-n) -->
            <div class="video-user-box">
                <div class="user-avatar">
                    ${video.user != null ? video.user.username.substring(0,1).toUpperCase() : 'U'}
                </div>
                <div>
                    <div style="font-weight: bold; font-size: 15px;">
                        ${video.user != null ? (video.user.fullname != null ? video.user.fullname : video.user.username) : 'Quản trị viên hệ thống'}
                    </div>
                    <div style="font-size: 12px; color: #aaa;">
                        Email: ${video.user != null ? video.user.email : 'admin@iotstar.vn'}
                    </div>
                </div>
            </div>

            <div class="video-desc">
                <strong>Mô tả chi tiết:</strong><br><br>
                ${video.description != null ? video.description : 'Chưa có phần mô tả cho video này.'}
            </div>
        </div>
    </div>

    <!-- Cột video đề xuất / mới nhất -->
    <div class="sidebar-column">
        <h3 style="color: #61dafb; margin-top: 0; border-bottom: 1px solid #333; padding-bottom: 8px;">Video Đề Xuất</h3>
        <c:forEach items="${relatedVideos}" var="rv">
            <c:if test="${rv.videoId != video.videoId}">
                <a href="${pageContext.request.contextPath}/video/detail?id=${rv.videoId}" class="related-card">
                    <c:choose>
                        <c:when test="${rv.poster != null && rv.poster.startsWith('http')}">
                            <c:url value="${rv.poster}" var="rUrl" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${rv.poster}" var="rUrl" />
                        </c:otherwise>
                    </c:choose>
                    <img class="related-thumb" src="${rUrl}" alt="${rv.title}" onerror="this.src='https://via.placeholder.com/120x75?text=Video';" />
                    <div>
                        <div class="related-title">${rv.title}</div>
                        <div class="related-views">👁 ${rv.views} lượt xem</div>
                    </div>
                </a>
            </c:if>
        </c:forEach>
    </div>
</div>
</body>
</html>
