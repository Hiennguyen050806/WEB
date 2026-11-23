# HƯỚNG DẪN CẤU HÌNH VÀ CHẠY DỰ ÁN (BÀI TẬP 1 & BÀI TẬP 2, 3)

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
- **Trang chủ (10 video mới nhất)**: `http://localhost:8080/BaiTap2_JPA/home`
- **Tất cả video (phân trang 6sp/trang)**: `http://localhost:8080/BaiTap2_JPA/video`
- **Chi tiết & phát video**: Bấm vào bất kỳ tiêu đề video nào trên trang chủ hoặc trang `/video`.
- **Đăng ký tài khoản & OTP**: `http://localhost:8080/BaiTap2_JPA/register` (Mã OTP in ở console).
- **Đăng nhập**: `http://localhost:8080/BaiTap2_JPA/login`
- **Quên mật khẩu qua OTP**: `http://localhost:8080/BaiTap2_JPA/forgot-password`
- **Quản lý danh mục (Category JPA)**: `http://localhost:8080/BaiTap2_JPA/admin/categories`
- **Quản lý Video (Video JPA CRUD)**: `http://localhost:8080/BaiTap2_JPA/admin/videos`
- **Hồ sơ cá nhân (User Profile & Update)**: `http://localhost:8080/BaiTap2_JPA/user/profile` (Đăng nhập -> Cập nhật Fullname, Phone, đổi Email gửi OTP xác thực, Upload avatar Cloudinary qua Multipart).
- **Upload file demo (Multipart)**: `http://localhost:8080/BaiTap2_JPA/multiPartServlet`

---

## 4. CHI TIẾT CÁC YÊU CẦU BÀI TẬP 03 ĐÃ HOÀN THÀNH

1. **Cấu hình Sitemesh Decorator 3 với Template Bootstrap 5**:
   - Tích hợp SiteMesh Filter chuẩn Jakarta EE 10 / Servlet 6.0 (`SiteMeshFilter.java`), bọc tự động toàn bộ response HTML với thẻ `<sitemesh:write property='body'/>` và `<sitemesh:write property='title'/>`.
   - Layout trang trí chuẩn Bootstrap 5.3 hiện đại: Header điều hướng thông minh (nhận diện User/Admin), Footer bản quyền và hệ thống Grid Responsive.
   - Hoàn thành trước 16g00 ngày 19/11/2026.

2. **Validation toàn bộ các chức năng có FORM**:
   - Kiểm tra định dạng Regex, kiểm tra rỗng, kiểm tra trùng lặp và phản hồi lỗi trực quan Bootstrap `is-invalid` / `invalid-feedback`:
     + **Login**: Username, Password bắt buộc.
     + **Register**: Kiểm tra Username, Email hợp lệ, Password & ConfirmPassword, Phone 10 số.
     + **Forgot Password & Reset Password**: Kiểm tra Email hợp lệ, mã OTP 6 số, Password mới.
     + **Category Insert / Edit**: Tên danh mục bắt buộc, mã danh mục (Insert) duy nhất.
     + **Video Insert / Edit**: VideoId duy nhất, Tiêu đề, Views >= 0, Active flag.
   - Hoàn thành trước 16g00 ngày 19/11/2026.

3. **Chức năng Hồ Sơ Người Dùng (User Profile)**:
   - URL: `/user/profile`
   - Cập nhật thông tin cá nhân: `fullname`, `phone`.
   - **Cơ chế đổi Email bảo mật**: Khi người dùng nhập địa chỉ Email mới, hệ thống tự động sinh mã OTP 6 số (thời hạn 10 phút) và gửi email xác thực tới địa chỉ email mới (in trực tiếp lên Console để test nhanh). Chuyển hướng sang màn hình `/user/verify-email-otp` để nhập mã OTP kích hoạt cập nhật.
   - **Upload avatar lên Cloudinary bằng Multipart**: Tích hợp `@MultipartConfig` và `CloudinaryUtil` gửi dữ liệu multipart/form-data trực tiếp lên Cloudinary API, lưu trữ URL ảnh đại diện bảo mật `secure_url`.
   - Toàn bộ giao diện được quản lý đồng bộ bởi SiteMesh 3 Decorator.
   - Hoàn thành trước 12g30 ngày 23/11/2026.

---

## 5. HƯỚNG DẪN ĐẨY SOURCE CODE LÊN GITHUB ĐỂ NỘP BÀI
Mở Terminal / PowerShell tại thư mục `D:\web` và chạy các lệnh:
```bash
git add .
git commit -m "Upload source code"
git push origin main
```
Sau đó copy đường link repository GitHub nộp lên **utexlms**.
