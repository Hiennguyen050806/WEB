package vn.iotstar.service.impl;

import java.util.Date;
import java.util.List;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.PasswordUtil;

public class UserServiceImpl implements IUserService {
    private IUserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String rawPassword) {
        User user = userDao.findByUsername(username);
        if (user != null) {
            // Kiểm tra mật khẩu mã hóa (hash)
            if (PasswordUtil.checkPassword(rawPassword, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }

        User user = new User();
        user.setUsername(username);
        // Mã hóa mật khẩu trước khi lưu vào CSDL
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setAvatar("avatar.png");
        user.setRoleid(3); // Mặc định role User
        user.setStatus(0); // Chưa kích hoạt tài khoản
        user.setCreatedDate(new Date());

        // Tạo mã OTP kích hoạt và thời hạn 5 phút
        String otp = EmailUtil.generateOtp();
        user.setOtpCode(otp);
        user.setOtpExpiry(new Date(System.currentTimeMillis() + 5 * 60 * 1000));

        userDao.insert(user);

        // Gửi OTP qua email
        EmailUtil.sendOtpEmail(email, otp, "Mã OTP kích hoạt tài khoản hệ thống");
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user == null && email.contains("@") == false) {
            user = userDao.findByUsername(email);
        }
        if (user != null && user.getOtpCode() != null) {
            if (user.getOtpCode().trim().equals(otp.trim())) {
                // Kiểm tra hạn sử dụng OTP
                if (user.getOtpExpiry() != null && user.getOtpExpiry().after(new Date())) {
                    user.setStatus(1); // Kích hoạt tài khoản thành công
                    user.setOtpCode(null);
                    user.setOtpExpiry(null);
                    userDao.update(user);
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean resendOtp(String email) {
        User user = userDao.findByEmail(email);
        if (user != null) {
            String otp = EmailUtil.generateOtp();
            user.setOtpCode(otp);
            user.setOtpExpiry(new Date(System.currentTimeMillis() + 5 * 60 * 1000));
            userDao.update(user);
            EmailUtil.sendOtpEmail(email, otp, "Gửi lại mã OTP kích hoạt tài khoản");
            return true;
        }
        return false;
    }

    @Override
    public boolean forgotPassword(String email) {
        User user = userDao.findByEmail(email);
        if (user != null) {
            String otp = EmailUtil.generateOtp();
            user.setOtpCode(otp);
            user.setOtpExpiry(new Date(System.currentTimeMillis() + 5 * 60 * 1000));
            userDao.update(user);
            EmailUtil.sendOtpEmail(email, otp, "Mã OTP khôi phục mật khẩu tài khoản");
            return true;
        }
        return false;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getOtpCode() != null) {
            if (user.getOtpCode().trim().equals(otp.trim())) {
                if (user.getOtpExpiry() != null && user.getOtpExpiry().after(new Date())) {
                    // Cập nhật mật khẩu mới đã mã hóa
                    user.setPassword(PasswordUtil.hashPassword(newPassword));
                    user.setOtpCode(null);
                    user.setOtpExpiry(null);
                    userDao.update(user);
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public boolean initiateEmailUpdate(int userId, String newEmail) {
        User user = userDao.findById(userId);
        if (user == null || newEmail == null) {
            return false;
        }

        // Sinh mã OTP 6 chữ số
        String otp = EmailUtil.generateOtp();
        long expiryTime = System.currentTimeMillis() + (10 * 60 * 1000); // 10 phút

        user.setOtpCode(otp);
        user.setOtpExpiry(new Date(expiryTime));
        userDao.update(user);

        // Gửi mã OTP tới email mới
        EmailUtil.sendOtpEmail(newEmail, otp, "Xác nhận cập nhật địa chỉ Email mới cho tài khoản " + user.getUsername());
        return true;
    }

    @Override
    public boolean confirmEmailUpdate(int userId, String newEmail, String otp) {
        User user = userDao.findById(userId);
        if (user != null && user.getOtpCode() != null && otp != null) {
            if (user.getOtpCode().trim().equals(otp.trim())) {
                if (user.getOtpExpiry() != null && user.getOtpExpiry().after(new Date())) {
                    user.setEmail(newEmail.trim());
                    user.setOtpCode(null);
                    user.setOtpExpiry(null);
                    userDao.update(user);
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }
}
