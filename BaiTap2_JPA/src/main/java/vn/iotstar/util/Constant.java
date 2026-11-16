package vn.iotstar.util;

import java.io.File;

public class Constant {
    public static final String SESSION_ACCOUNT = "account";
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";

    // Thư mục upload hình ảnh / video
    public static final String DIR = (new File("E:/upload").exists() || new File("E:/").exists())
            ? "E:/upload"
            : System.getProperty("user.home") + File.separator + "upload";

    public static final String UPLOAD_DIRECTORY = DIR;
    public static final String DEFAULT_FILENAME = "default.file";
}
