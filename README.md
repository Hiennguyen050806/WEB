# HƯỚNG DẪN CẤU HÌNH VÀ CHẠY DỰ ÁN (BÀI TẬP 1 & BÀI TẬP 2)

Dự án gồm 2 project chuẩn Maven WebApp:
1. **`BaiTap1_ServletJDBC`**: Bài tập MVC thuần với Servlet, JDBC, Cookie Remember Me, Session, Register và Category CRUD theo PDF 06_MVC & PDF 14_HD.
2. **`BaiTap2_JPA`**: Bài tập CRUD với JPA 3.0 & Jakarta EE (Hibernate 7.x/6.x), bổ sung các tính năng nâng cao:
   - Kích hoạt tài khoản bằng mã **OTP gửi qua email** (và hiển thị Console).
   - Đăng nhập với mật khẩu được **mã hóa Hash (SHA-256)**, chức năng **Đăng xuất**.
   - **Quên mật khẩu** gửi mã xác nhận OTP qua email và đặt lại mật khẩu mới.
   - **CRUD bảng Videos** đầy đủ bằng công nghệ JPA.
   - **Hiển thị 10 video mới nhất** lên trang chủ `/home`.
   - **Hiển thị tất cả video phân trang 6 sp/trang** tại URL `/video`.
   - **Xem chi tiết và play video trực tiếp** khi bấm vào tiêu đề video trên `/home` hoặc `/video`.
   - **Upload file bằng Servlet Multipart** (`@MultipartConfig`).

---

## 1. CẤU HÌNH CƠ SỞ DỮ LIỆU

### A. Đối với Bài tập 1 (`BaiTap1_ServletJDBC`)
- **Tên Database**: `ShoppingServiceMVC`
- **File script**: `BaiTap1_ServletJDBC/src/main/resources/database.sql`
- Hỗ trợ SQL Server (`localhost:1433`) và MySQL (`localhost:3306`).
- Mật khẩu mặc định trong `DBConnection.java`: `1234567@a$` (hoặc `1234@a$`). Bạn có thể đổi lại đúng mật khẩu SQL của máy bạn trong `vn.iotstar.connection.DBConnection`.

### B. Đối với Bài tập 2 (`BaiTap2_JPA`)
- **Tên Database**: `webst2`
- **File script**: `BaiTap2_JPA/src/main/resources/database.sql`
- Trong file `persistence.xml`, Hibernate đã bật cấu hình tự sinh/cập nhật bảng:
  ```xml
  <property name="hibernate.hbm2ddl.auto" value="update" />
  ```
  Nên bạn chỉ cần tạo database rỗng `CREATE DATABASE webst2;` trên SQL Server, JPA sẽ tự động tạo các bảng `users`, `categories`, `videos`.
- File cấu hình DB: `BaiTap2_JPA/src/main/resources/META-INF/persistence.xml` (sửa user `sa` và password nếu khác).

---

## 2. CÁCH CHẠY DỰ ÁN TRÊN ECLIPSE / INTELLIJ IDEA VÀ TOMCAT

### Cách 1: Chạy bằng IntelliJ IDEA
1. Mở thư mục `D:\web` hoặc mở riêng từng thư mục `BaiTap1_ServletJDBC`, `BaiTap2_JPA`.
2. Chờ Maven tải và đồng bộ các dependency.
3. Chạy thử nghiệm file test tạo dữ liệu JPA:
   - Chuột phải vào `BaiTap2_JPA/src/main/java/vn/iotstar/config/Test.java` -> chọn **Run 'Test.main()'**.
4. Cấu hình Tomcat:
   - Vào **Run** -> **Edit Configurations...** -> bấm dấu `+` -> chọn **Tomcat Server** -> **Local**.
   - Tab **Deployment**: Bấm `+` -> Chọn **Artifact** -> chọn `BaiTap2_JPA:war exploded` (Application context đặt là `/BaiTap2_JPA` hoặc `/`).
   - Bấm **Apply** và **Run**.

### Cách 2: Chạy bằng Eclipse
1. Mở Eclipse -> **File** -> **Import...** -> **Existing Maven Projects** -> Chọn thư mục `BaiTap1_ServletJDBC` hoặc `BaiTap2_JPA`.
2. Chuột phải vào project -> **Run As** -> **Run on Server** (chọn Tomcat 10+).

---

## 3. CÁC ĐƯỜNG DẪN KIỂM TRA CHỨC NĂNG (URL TEST)

### A. Bài tập 2 (`BaiTap2_JPA`)
- **Trang chủ (10 video mới nhất)**: `http://localhost:8080/BaiTap2_JPA/home`
- **Tất cả video (phân trang 6sp/trang)**: `http://localhost:8080/BaiTap2_JPA/video`
- **Chi tiết & phát video**: Bấm vào bất kỳ tiêu đề video nào trên trang chủ hoặc trang `/video`.
- **Đăng ký tài khoản & OTP**: `http://localhost:8080/BaiTap2_JPA/register` (Mã OTP được gửi và in trực tiếp tại Server Console để bạn copy nhập ngay).
- **Đăng nhập**: `http://localhost:8080/BaiTap2_JPA/login`
- **Quên mật khẩu qua OTP**: `http://localhost:8080/BaiTap2_JPA/forgot-password`
- **Quản lý danh mục (Category JPA)**: `http://localhost:8080/BaiTap2_JPA/admin/categories`
- **Quản lý Video (Video JPA CRUD)**: `http://localhost:8080/BaiTap2_JPA/admin/videos`
- **Upload file demo (Multipart)**: `http://localhost:8080/BaiTap2_JPA/multiPartServlet`

---

## 4. HƯỚNG DẪN ĐẨY SOURCE CODE LÊN GITHUB ĐỂ NỘP BÀI

Mở Terminal / PowerShell tại thư mục `D:\web` và chạy các lệnh:
```bash
# 1. Khởi tạo Git
git init

# 2. Thêm tất cả file mã nguồn
git add .

# 3. Tạo commit đầu tiên
git commit -m "Complete Bai Tap 1 Servlet JDBC and Bai Tap 2 JPA CRUD with OTP, Hash, Video Pagination"

# 4. Đổi tên nhánh sang main
git branch -M main

# 5. Liên kết tới repository GitHub của bạn (thay bằng link repo GitHub của bạn)
git remote add origin https://github.com/<tai-khoan-cua-ban>/<ten-repository>.git

# 6. Đẩy code lên GitHub
git push -u origin main
```
Sau đó copy đường link repository GitHub nộp lên **utexlms**.
