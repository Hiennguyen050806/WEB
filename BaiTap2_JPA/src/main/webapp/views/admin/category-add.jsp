<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục (JPA)</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold text-primary">
                        <i class="bi bi-folder-plus me-2"></i>Thêm Danh Mục Mới (JPA)
                    </h5>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary btn-sm">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </a>
                </div>
                <div class="card-body p-4">
                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${alert}
                        </div>
                    </c:if>

                    <form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data" novalidate>
                        <div class="mb-3">
                            <label for="categoryname" class="form-label fw-semibold">
                                Tên danh mục <span class="text-danger">*</span>:
                            </label>
                            <input type="text" id="categoryname" name="categoryname" 
                                   value="${cate.categoryname != null ? cate.categoryname : param.categoryname}" 
                                   class="form-control ${errors.categoryname != null ? 'is-invalid' : ''}" 
                                   placeholder="Nhập tên danh mục..." required />
                            <c:if test="${errors.categoryname != null}">
                                <div class="invalid-feedback">${errors.categoryname}</div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="images" class="form-label fw-semibold">Hình ảnh (Đường dẫn URL):</label>
                            <input type="text" id="images" name="images" 
                                   value="${cate.images != null ? cate.images : param.images}" 
                                   class="form-control" 
                                   placeholder="https://example.com/image.png" />
                        </div>

                        <div class="mb-3">
                            <label for="images1" class="form-label fw-semibold">Tải lên tệp ảnh (Upload Multipart):</label>
                            <input type="file" id="images1" name="images1" 
                                   class="form-control ${errors.images1 != null ? 'is-invalid' : ''}" 
                                   accept="image/*" />
                            <c:if test="${errors.images1 != null}">
                                <div class="invalid-feedback">${errors.images1}</div>
                            </c:if>
                            <div class="form-text small text-muted">Hỗ trợ các định dạng .jpg, .jpeg, .png, .gif, .webp.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái:</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="ston" name="status" value="1" 
                                       ${(cate.status == null || cate.status == 1) ? 'checked' : ''} />
                                <label class="form-check-label text-success fw-semibold" for="ston">
                                    <i class="bi bi-check-circle me-1"></i> Hoạt động
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="stoff" name="status" value="0" 
                                       ${(cate.status != null && cate.status == 0) ? 'checked' : ''} />
                                <label class="form-check-label text-danger fw-semibold" for="stoff">
                                    <i class="bi bi-x-circle me-1"></i> Khóa
                                </label>
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary px-4 shadow-sm">
                                <i class="bi bi-save me-1"></i> Lưu Danh Mục
                            </button>
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary px-4">Hủy bỏ</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
