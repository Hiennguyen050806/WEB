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

-- Lưu ý: Hibernate có cấu hình hbm2ddl.auto = update nên sẽ tự động sinh/cập nhật bảng
-- khi chạy ứng dụng nếu database webst2 đã tồn tại.

-- 1. Bảng users
CREATE TABLE users(
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fullname NVARCHAR(100) NULL,
    phone VARCHAR(20) NULL,
    avatar NVARCHAR(255) NULL,
    roleid INT NULL,
    status INT NULL,
    otpCode VARCHAR(10) NULL,
    otpExpiry DATETIME2 NULL,
    createdDate DATETIME2 NULL
);

-- 2. Bảng categories
CREATE TABLE categories(
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NULL,
    images NVARCHAR(255) NULL,
    status INT NULL
);

-- 3. Bảng videos (có mối quan hệ 1-n với bảng users và categories)
CREATE TABLE videos(
    videoId VARCHAR(255) PRIMARY KEY,
    active INT NULL,
    description NVARCHAR(500) NULL,
    poster NVARCHAR(500) NULL,
    title NVARCHAR(500) NULL,
    views INT NULL,
    categoryId INT NULL,
    userId INT NULL,
    CONSTRAINT FK_videos_categories FOREIGN KEY (categoryId) REFERENCES categories(categoryId),
    CONSTRAINT FK_videos_users FOREIGN KEY (userId) REFERENCES users(id)
);

-- Dữ liệu mẫu Admin:
INSERT INTO users(username, password, email, fullname, roleid, status, createdDate)
VALUES ('admin', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'admin@iotstar.vn', N'Quản Trị Viên', 1, 1, GETDATE());
-- Mật khẩu hash SHA-256 của '123' là a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3
*/
