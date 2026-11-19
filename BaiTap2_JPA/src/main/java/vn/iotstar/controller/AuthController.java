package vn.iotstar.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.ValidationUtil;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/login", "/logout", "/register", "/verify-otp", "/forgot-password", "/reset-password" })
public class AuthController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/logout")) {
            handleLogout(req, resp);
        } else if (uri.endsWith("/login")) {
            handleGetLogin(req, resp);
        } else if (uri.endsWith("/register")) {
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        } else if (uri.endsWith("/verify-otp")) {
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        } else if (uri.endsWith("/forgot-password")) {
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        } else if (uri.endsWith("/reset-password")) {
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.endsWith("/login")) {
            handlePostLogin(req, resp);
        } else if (uri.endsWith("/register")) {
            handlePostRegister(req, resp);
        } else if (uri.endsWith("/verify-otp")) {
            handlePostVerifyOtp(req, resp);
        } else if (uri.endsWith("/forgot-password")) {
            handlePostForgotPassword(req, resp);
        } else if (uri.endsWith("/reset-password")) {
            handlePostResetPassword(req, resp);
        }
    }

    private void handleGetLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Kiểm tra Remember Me Cookie
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (Constant.COOKIE_REMEMBER.equals(c.getName())) {
                    User user = userService.findByUsername(c.getValue());
                    if (user != null && user.getStatus() == 1) {
                        session = req.getSession(true);
                        session.setAttribute(Constant.SESSION_ACCOUNT, user);
                        session.setAttribute(Constant.SESSION_USERNAME, user.getUsername());
                        resp.sendRedirect(req.getContextPath() + "/home");
                        return;
                    }
                }
            }
        }

        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    /**
     * FORM VALIDATION: LOGIN
     */
    private void handlePostLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        Map<String, String> errors = new HashMap<>();

        if (ValidationUtil.isEmpty(username)) {
            errors.put("username", "Tên đăng nhập không được để trống!");
        }

        if (ValidationUtil.isEmpty(password)) {
            errors.put("password", "Mật khẩu không được để trống!");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        User user = userService.login(username.trim(), password);
        if (user == null) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không chính xác!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra kích hoạt tài khoản bằng OTP
        if (user.getStatus() != 1) {
            req.setAttribute("alert", "Tài khoản chưa được kích hoạt OTP! Vui lòng nhập mã OTP để kích hoạt.");
            req.setAttribute("email", user.getEmail());
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            return;
        }

        // Đăng nhập thành công
        HttpSession session = req.getSession(true);
        session.setAttribute(Constant.SESSION_ACCOUNT, user);
        session.setAttribute(Constant.SESSION_USERNAME, user.getUsername());

        // Xử lý Remember Me Cookie
        if ("on".equals(remember)) {
            Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, user.getUsername());
            cookie.setMaxAge(30 * 60);
            cookie.setPath("/");
            resp.addCookie(cookie);
        }

        // Phân quyền điều hướng
        if (user.getRoleid() == 1) {
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute(Constant.SESSION_ACCOUNT);
            session.invalidate();
        }

        Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        resp.addCookie(cookie);

        resp.sendRedirect(req.getContextPath() + "/login");
    }

    /**
     * FORM VALIDATION: REGISTER
     */
    private void handlePostRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        Map<String, String> errors = new HashMap<>();

        // 1. Kiểm tra username
        if (ValidationUtil.isEmpty(username)) {
            errors.put("username", "Tên đăng nhập không được để trống!");
        } else if (!ValidationUtil.isValidUsername(username)) {
            errors.put("username", "Tên đăng nhập từ 3-30 ký tự, không chứa ký tự đặc biệt hay khoảng trắng!");
        } else if (userService.checkExistUsername(username.trim())) {
            errors.put("username", "Tên đăng nhập đã tồn tại trong hệ thống!");
        }

        // 2. Kiểm tra email
        if (ValidationUtil.isEmpty(email)) {
            errors.put("email", "Email không được để trống!");
        } else if (!ValidationUtil.isValidEmail(email)) {
            errors.put("email", "Địa chỉ email không đúng định dạng!");
        } else if (userService.checkExistEmail(email.trim())) {
            errors.put("email", "Email này đã được sử dụng!");
        }

        // 3. Kiểm tra fullname
        if (ValidationUtil.isEmpty(fullname)) {
            errors.put("fullname", "Họ và tên không được để trống!");
        }

        // 4. Kiểm tra phone
        if (!ValidationUtil.isEmpty(phone) && !ValidationUtil.isValidPhone(phone)) {
            errors.put("phone", "Số điện thoại không đúng định dạng (10 chữ số, vd: 0908617108)!");
        }

        // 5. Kiểm tra mật khẩu
        if (ValidationUtil.isEmpty(password)) {
            errors.put("password", "Mật khẩu không được để trống!");
        } else if (!ValidationUtil.isValidPassword(password)) {
            errors.put("password", "Mật khẩu phải có độ dài từ 6 ký tự trở lên!");
        }

        // 6. Kiểm tra xác nhận mật khẩu
        if (!ValidationUtil.isEmpty(confirmPassword) && !confirmPassword.equals(password)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp!");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.register(username.trim(), password, email.trim(), fullname, phone);
        if (success) {
            req.setAttribute("success", "Đăng ký thành công! Vui lòng kiểm tra mã OTP gửi về email (hoặc console) để kích hoạt tài khoản.");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Đăng ký thất bại! Vui lòng thử lại.");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }

    private void handlePostVerifyOtp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (ValidationUtil.isEmpty(otp) || otp.trim().length() != 6) {
            req.setAttribute("alert", "Vui lòng nhập đúng mã OTP gồm 6 chữ số!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean ok = userService.verifyOtp(email.trim(), otp.trim());
        if (ok) {
            req.setAttribute("success", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn (5 phút)!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        }
    }

    /**
     * FORM VALIDATION: FORGOT PASSWORD
     */
    private void handlePostForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        if (ValidationUtil.isEmpty(email)) {
            req.setAttribute("emailError", "Vui lòng nhập địa chỉ email!");
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("emailError", "Định dạng email không hợp lệ!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean ok = userService.forgotPassword(email.trim());
        if (ok) {
            req.setAttribute("success", "Mã xác nhận OTP đã được gửi về email (hoặc kiểm tra server console)!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Email không tồn tại trong hệ thống!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        }
    }

    /**
     * FORM VALIDATION: RESET PASSWORD
     */
    private void handlePostResetPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();

        if (ValidationUtil.isEmpty(otp) || otp.trim().length() != 6) {
            errors.put("otp", "Mã OTP phải gồm đúng 6 chữ số!");
        }

        if (ValidationUtil.isEmpty(newPassword) || !ValidationUtil.isValidPassword(newPassword)) {
            errors.put("newPassword", "Mật khẩu mới tối thiểu 6 ký tự!");
        }

        if (ValidationUtil.isEmpty(confirmPassword) || !confirmPassword.equals(newPassword)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp!");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean ok = userService.resetPassword(email.trim(), otp.trim(), newPassword);
        if (ok) {
            req.setAttribute("success", "Đặt lại mật khẩu thành công! Mời bạn đăng nhập lại.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }
}
