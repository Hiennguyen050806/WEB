-- ========================================================
-- CƠ SỞ DỮ LIỆU CHO BÀI TẬP 2 (JPA 3.0 & JAKARTA 6.0)
-- Database name: webst2
-- ========================================================

-- ====== DÀNH CHO SQL SERVER ======
/*
CREATE DATABASE webst2;
GO
USE webst2;
GO

-- Lưu ý: Hibernate có cấu hình hbm2ddl.auto = update nên sẽ tự động sinh bảng
-- nếu database webst2 đã tồn tại. Dưới đây là DDL nếu muốn tạo thủ công:

CREATE TABLE categories(
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NULL,
    images NVARCHAR(255) NULL,
    status INT NULL
);

CREATE TABLE videos(
    videoId VARCHAR(255) PRIMARY KEY,
    active BIT NULL,
    description NVARCHAR(MAX) NULL,
    poster NVARCHAR(255) NULL,
    title NVARCHAR(255) NULL,
    views INT NULL,
    categoryId INT NULL,
    CONSTRAINT FK_videos_categories FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
);

-- Dữ liệu mẫu:
INSERT INTO categories(categoryname, images, status) VALUES (N'Điện thoại', 'iphone.jpg', 1);
INSERT INTO categories(categoryname, images, status) VALUES (N'Laptop', 'macbook.jpg', 1);
*/
