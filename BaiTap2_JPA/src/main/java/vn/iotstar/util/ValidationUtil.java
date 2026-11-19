package vn.iotstar.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Regex kiểm tra định dạng email chuẩn
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    // Regex kiểm tra số điện thoại Việt Nam (10 số, bắt đầu bằng 03, 05, 07, 08, 09)
    private static final String PHONE_REGEX = "^(0[3|5|7|8|9])+([0-9]{8})$";
    private static final Pattern PHONE_PATTERN = Pattern.compile(PHONE_REGEX);

    // Regex username: chỉ gồm chữ, số, gạch dưới, từ 3 đến 30 ký tự
    private static final String USERNAME_REGEX = "^[a-zA-Z0-9_]{3,30}$";
    private static final Pattern USERNAME_PATTERN = Pattern.compile(USERNAME_REGEX);

    public static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        if (isEmpty(email)) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (isEmpty(phone)) {
            return true; // Cho phép để trống số điện thoại nếu không bắt buộc
        }
        return PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    public static boolean isValidUsername(String username) {
        if (isEmpty(username)) {
            return false;
        }
        return USERNAME_PATTERN.matcher(username.trim()).matches();
    }

    public static boolean isValidPassword(String password) {
        if (isEmpty(password)) {
            return false;
        }
        return password.trim().length() >= 6; // Mật khẩu tối thiểu 6 ký tự
    }

    public static boolean isValidImageFile(String fileName) {
        if (isEmpty(fileName)) {
            return false;
        }
        String lower = fileName.toLowerCase();
        return lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".png")
                || lower.endsWith(".gif") || lower.endsWith(".webp");
    }

    public static boolean isValidVideoId(String videoId) {
        if (isEmpty(videoId)) {
            return false;
        }
        return videoId.trim().matches("^[a-zA-Z0-9_-]{1,50}$");
    }
}
