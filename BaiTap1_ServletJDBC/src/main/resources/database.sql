-- ========================================================
-- CƠ SỞ DỮ LIỆU CHO BÀI TẬP 1 (SERVLET JDBC MVC)
-- Hỗ trợ SQL Server và MySQL
-- ========================================================

-- ====== 1. DÀNH CHO SQL SERVER ======
/*
CREATE DATABASE ShoppingServiceMVC;
GO
USE ShoppingServiceMVC;
GO

-- Bảng [User] (Theo PDF 06_MVC)
IF OBJECT_ID('dbo.[User]', 'U') IS NOT NULL DROP TABLE dbo.[User];
CREATE TABLE dbo.[User](
    [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [email] [nvarchar](100) NULL,
    [username] [nvarchar](50) NOT NULL UNIQUE,
    [fullname] [nvarchar](100) NULL,
    [password] [nvarchar](100) NOT NULL,
    [avatar] [nvarchar](255) NULL,
    [roleid] [int] NULL, -- 1: Admin, 2: Manager, khác: User
    [phone] [nvarchar](20) NULL,
    [createddate] [date] NULL
);
GO

-- Bảng Category (Theo PDF 14_HD)
IF OBJECT_ID('dbo.Category', 'U') IS NOT NULL DROP TABLE dbo.Category;
CREATE TABLE dbo.Category(
    [cate_id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [cate_name] [nvarchar](255) NOT NULL,
    [icons] [nvarchar](255) NULL
);
GO

-- Dữ liệu mẫu bảng [User] (mật khẩu mặc định: 123)
INSERT INTO dbo.[User](email, username, fullname, password, avatar, roleid, phone, createddate)
VALUES 
('admin@gmail.com', 'admin', N'Nguyễn Hữu Trung (Admin)', '123', 'avatar.png', 1, '0908617108', GETDATE()),
('manager@gmail.com', 'manager', N'Quản Lý Cửa Hàng', '123', 'avatar.png', 2, '0912345678', GETDATE()),
('user@gmail.com', 'user', N'Khách Hàng', '123', 'avatar.png', 3, '0987654321', GETDATE());
GO

-- Dữ liệu mẫu bảng Category
INSERT INTO dbo.Category(cate_name, icons)
VALUES 
(N'Quần Áo Nam', 'ao_nam.png'),
(N'Quần Áo Nữ', 'ao_nu.png'),
(N'Điện Thoại & Phụ Kiện', 'phone.png');
GO
*/

-- ====== 2. DÀNH CHO MYSQL ======
/*
CREATE DATABASE IF NOT EXISTS ShoppingServiceMVC CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ShoppingServiceMVC;

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(100) NULL,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `fullname` VARCHAR(100) NULL,
    `password` VARCHAR(100) NOT NULL,
    `avatar` VARCHAR(255) NULL,
    `roleid` INT NULL,
    `phone` VARCHAR(20) NULL,
    `createddate` DATE NULL
);

DROP TABLE IF EXISTS `Category`;
CREATE TABLE `Category` (
    `cate_id` INT AUTO_INCREMENT PRIMARY KEY,
    `cate_name` VARCHAR(255) NOT NULL,
    `icons` VARCHAR(255) NULL
);

INSERT INTO `User`(email, username, fullname, password, avatar, roleid, phone, createddate)
VALUES 
('admin@gmail.com', 'admin', 'Nguyễn Hữu Trung (Admin)', '123', 'avatar.png', 1, '0908617108', CURDATE()),
('manager@gmail.com', 'manager', 'Quản Lý Cửa Hàng', '123', 'avatar.png', 2, '0912345678', CURDATE()),
('user@gmail.com', 'user', 'Khách Hàng', '123', 'avatar.png', 3, '0987654321', CURDATE());

INSERT INTO `Category`(cate_name, icons)
VALUES 
('Quần Áo Nam', 'ao_nam.png'),
('Quần Áo Nữ', 'ao_nu.png'),
('Điện Thoại & Phụ Kiện', 'phone.png');
*/
