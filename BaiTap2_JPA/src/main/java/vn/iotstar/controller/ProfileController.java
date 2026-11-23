package vn.iotstar.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.CloudinaryUtil;
import vn.iotstar.util.ValidationUtil;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/user/profile", "/user/verify-email-otp" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 25
)
public class ProfileController extends HttpServlet {

    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin mới nhất từ database
        User freshUser = userService.findById(currentUser.getId());
        if (freshUser != null) {
            session.setAttribute("account", freshUser);
            req.setAttribute("user", freshUser);
        }

        if ("/user/verify-email-otp".equals(path)) {
            String pendingEmail = (String) session.getAttribute("pendingEmail");
            if (pendingEmail == null) {
                resp.sendRedirect(req.getContextPath() + "/user/profile");
                return;
            }
            req.getRequestDispatcher("/views/user/verify-email-otp.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/user/verify-email-otp".equals(path)) {
            handleVerifyEmailOtp(req, resp);
        } else {
            handleUpdateProfile(req, resp);
        }
    }

    /**
     * Xử lý cập nhật thông tin User Profile: Fullname, Phone, Email mới (OTP), Avatar (Cloudinary Multipart)
     */
    private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy entity user từ DB để sửa
        User user = userService.findById(currentUser.getId());
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        Map<String, String> errors = new HashMap<>();

        // Validation Fullname
        if (ValidationUtil.isEmpty(fullname)) {
            errors.put("fullname", "Họ và tên không được để trống!");
        }

        // Validation Phone
        if (!ValidationUtil.isEmpty(phone) && !ValidationUtil.isValidPhone(phone)) {
            errors.put("phone", "Số điện thoại không đúng định dạng (10 chữ số)!");
        }

        // Validation Email
        if (ValidationUtil.isEmpty(email)) {
            errors.put("email", "Email không được để trống!");
        } else if (!ValidationUtil.isValidEmail(email)) {
            errors.put("email", "Định dạng email không hợp lệ!");
        } else if (!email.trim().equalsIgnoreCase(user.getEmail()) && userService.checkExistEmail(email.trim())) {
            errors.put("email", "Địa chỉ email này đã được tài khoản khác sử dụng!");
        }

        // Nếu có lỗi validation
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            user.setFullname(fullname);
            user.setPhone(phone);
            req.setAttribute("user", user);
            req.setAttribute("inputEmail", email);
            req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
            return;
        }

        // 1. Cập nhật Fullname và Phone
        user.setFullname(fullname.trim());
        user.setPhone(phone != null ? phone.trim() : null);

        // 2. Xử lý Upload Avatar lên Cloudinary bằng Multipart
        try {
            Part filePart = req.getPart("avatarFile");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                InputStream inputStream = filePart.getInputStream();

                // Gọi CloudinaryUtil upload multipart
                String cloudinaryUrl = CloudinaryUtil.uploadImage(inputStream, fileName);
                if (cloudinaryUrl != null) {
                    user.setAvatar(cloudinaryUrl);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        // 3. Kiểm tra thay đổi Email: Nếu email mới khác email hiện tại -> Gửi OTP đến email mới
        boolean isEmailChanged = !email.trim().equalsIgnoreCase(user.getEmail());
        if (isEmailChanged) {
            String newEmail = email.trim();
            // Lưu trạng thái chờ xác thực email
            session.setAttribute("pendingEmail", newEmail);
            userService.initiateEmailUpdate(user.getId(), newEmail);
            userService.update(user);
            session.setAttribute("account", user);

            req.setAttribute("message", "Hệ thống đã gửi mã OTP xác nhận đến email mới (" + newEmail + "). Vui lòng nhập mã để hoàn tất cập nhật!");
            resp.sendRedirect(req.getContextPath() + "/user/verify-email-otp");
            return;
        }

        // Nếu email không đổi, lưu thông tin ngay
        userService.update(user);
        session.setAttribute("account", user);
        req.setAttribute("user", user);
        req.setAttribute("message", "Cập nhật thông tin hồ sơ thành công!");
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    /**
     * Xác thực mã OTP để kích hoạt cập nhật email mới
     */
    private void handleVerifyEmailOtp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String pendingEmail = (String) session.getAttribute("pendingEmail");
        if (pendingEmail == null) {
            resp.sendRedirect(req.getContextPath() + "/user/profile");
            return;
        }

        String otp = req.getParameter("otp");
        if (ValidationUtil.isEmpty(otp) || otp.trim().length() != 6) {
            req.setAttribute("alert", "Vui lòng nhập đúng mã OTP gồm 6 chữ số!");
            req.getRequestDispatcher("/views/user/verify-email-otp.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.confirmEmailUpdate(currentUser.getId(), pendingEmail, otp.trim());
        if (success) {
            session.removeAttribute("pendingEmail");
            User updatedUser = userService.findById(currentUser.getId());
            session.setAttribute("account", updatedUser);
            req.setAttribute("user", updatedUser);
            req.setAttribute("message", "Chúc mừng! Cập nhật địa chỉ email mới thành công!");
            req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn (10 phút)!");
            req.getRequestDispatcher("/views/user/verify-email-otp.jsp").forward(req, resp);
        }
    }
}
