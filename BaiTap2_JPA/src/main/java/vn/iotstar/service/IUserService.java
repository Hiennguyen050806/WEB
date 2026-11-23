package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String rawPassword);

    boolean register(String username, String password, String email, String fullname, String phone);

    boolean verifyOtp(String email, String otp);

    boolean resendOtp(String email);

    boolean forgotPassword(String email);

    boolean resetPassword(String email, String otp, String newPassword);

    User findByUsername(String username);

    User findByEmail(String email);

    User findById(int id);

    void update(User user);

    boolean initiateEmailUpdate(int userId, String newEmail);

    boolean confirmEmailUpdate(int userId, String newEmail, String otp);

    boolean checkExistUsername(String username);

    boolean checkExistEmail(String email);

    List<User> findAll();
}
