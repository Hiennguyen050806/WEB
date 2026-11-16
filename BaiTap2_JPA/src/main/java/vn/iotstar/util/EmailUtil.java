package vn.iotstar.util;

import java.util.Random;

public class EmailUtil {

    /**
     * Sinh mã OTP ngẫu nhiên 6 chữ số
     */
    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Gửi mã OTP xác nhận tài khoản / quên mật khẩu
     * In ra màn hình console để giảng viên/sinh viên kiểm tra ngay lập tức khi test
     */
    public static boolean sendOtpEmail(String recipientEmail, String otpCode, String subject) {
        System.out.println("=================================================");
        System.out.println(">>> [EMAIL SERVICE] GỬI EMAIL THÀNH CÔNG! <<<");
        System.out.println("Người nhận: " + recipientEmail);
        System.out.println("Tiêu đề: " + subject);
        System.out.println("Mã OTP xác thực: [ " + otpCode + " ] (Có hiệu lực trong 5 phút)");
        System.out.println("=================================================");
        return true;
    }
}
