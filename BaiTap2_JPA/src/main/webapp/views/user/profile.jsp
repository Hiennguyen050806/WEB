<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân - Cập Nhật Thông Tin</title>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none"><i class="bi bi-house-door"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
                </ol>
            </nav>

            <!-- Card Profile -->
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-person-bounding-box me-2"></i> Hồ Sơ Người Dùng (User Profile)
                    </h5>
                </div>
                <div class="card-body p-4">

                    <!-- Thông báo thành công -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                            <div>${message}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Thông báo lỗi tổng quát -->
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                            <div>${alert}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/profile" method="post" enctype="multipart/form-data" class="needs-validation">
                        
                        <!-- Khu vực Avatar và Preview -->
                        <div class="text-center mb-4">
                            <div class="position-relative d-inline-block">
                                <c:choose>
                                    <c:when test="${not empty user.avatar}">
                                        <img id="avatarPreview" src="${user.avatar}" alt="Avatar" class="rounded-circle img-thumbnail shadow-sm" style="width: 140px; height: 140px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <img id="avatarPreview" src="https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg" alt="Default Avatar" class="rounded-circle img-thumbnail shadow-sm" style="width: 140px; height: 140px; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                                <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-success p-2 border border-2 border-white">
                                    <i class="bi bi-camera-fill"></i>
                                </span>
                            </div>
                            <div class="mt-2 text-muted small">
                                <span class="badge bg-light text-dark border">
                                    <i class="bi bi-cloud-arrow-up-fill text-primary"></i> Upload bằng Cloudinary Multipart
                                </span>
                            </div>
                        </div>

                        <!-- Username (Readonly) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập (Username):</label>
                            <input type="text" class="form-control bg-light" value="${user.username}" readonly>
                            <div class="form-text">Tên đăng nhập là duy nhất và cố định trong hệ thống.</div>
                        </div>

                        <!-- Fullname -->
                        <div class="mb-3">
                            <label for="fullname" class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span>:</label>
                            <input type="text" class="form-control ${not empty errors.fullname ? 'is-invalid' : ''}" id="fullname" name="fullname" value="${user.fullname}" placeholder="Nhập họ và tên đầy đủ">
                            <c:if test="${not empty errors.fullname}">
                                <div class="invalid-feedback">${errors.fullname}</div>
                            </c:if>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                            <input type="text" class="form-control ${not empty errors.phone ? 'is-invalid' : ''}" id="phone" name="phone" value="${user.phone}" placeholder="Nhập số điện thoại (vd: 0908617108)">
                            <c:if test="${not empty errors.phone}">
                                <div class="invalid-feedback">${errors.phone}</div>
                            </c:if>
                        </div>

                        <!-- Email (Có cơ chế gửi OTP khi đổi email mới) -->
                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">Địa chỉ Email <span class="text-danger">*</span>:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" id="email" name="email" value="${not empty inputEmail ? inputEmail : user.email}" placeholder="example@email.com">
                            </div>
                            <c:if test="${not empty errors.email}">
                                <div class="text-danger small mt-1">${errors.email}</div>
                            </c:if>
                            <div class="form-text text-primary">
                                <i class="bi bi-shield-lock-fill me-1"></i> Lưu ý: Khi nhập Email mới, hệ thống sẽ gửi mã xác thực <strong>OTP</strong> đến Email mới đó để xác nhận trước khi cập nhật.
                            </div>
                        </div>

                        <!-- Upload Avatar Multipart Cloudinary -->
                        <div class="mb-4">
                            <label for="avatarFile" class="form-label fw-semibold">Ảnh đại diện mới (Upload Cloudinary):</label>
                            <input class="form-control" type="file" id="avatarFile" name="avatarFile" accept="image/*" onchange="previewImage(this);">
                            <div class="form-text">Hỗ trợ các định dạng: JPG, PNG, GIF, WEBP (Tối đa 10MB).</div>
                        </div>

                        <!-- Nút lưu thay đổi -->
                        <div class="d-flex justify-content-between align-items-center pt-2">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm">
                                <i class="bi bi-floppy-fill me-1"></i> Cập nhật hồ sơ
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>
