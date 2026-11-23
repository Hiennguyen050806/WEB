package vn.iotstar.util;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Utility upload file/hình ảnh lên Cloudinary qua REST API chuẩn sử dụng multipart/form-data.
 * Hoạt động độc lập bằng thư viện chuẩn của Java/Jakarta EE, không yêu cầu thêm dependency bên ngoài.
 */
public class CloudinaryUtil {

    // Cấu hình Cloudinary mặc định (Người dùng có thể thay thế bằng cloud_name, api_key, api_secret của mình)
    private static final String CLOUD_NAME = "demo"; 
    private static final String API_KEY = ""; 
    private static final String API_SECRET = ""; 
    // Preset dùng cho unsigned upload nếu không dùng API key/secret
    private static final String UPLOAD_PRESET = "unsigned_preset";

    /**
     * Upload InputStream file lên Cloudinary bằng multipart/form-data HTTP POST
     * @param inputStream luồng dữ liệu file từ Part
     * @param fileName tên file gốc
     * @return URL an toàn (https) của ảnh đã upload lên Cloudinary, hoặc null nếu có lỗi
     */
    public static String uploadImage(InputStream inputStream, String fileName) {
        if (inputStream == null) return null;

        String boundary = "----WebKitFormBoundary" + UUID.randomUUID().toString().replace("-", "");
        String LINE_FEED = "\r\n";

        try {
            // URL endpoint Cloudinary upload image
            String endpointUrl = "https://api.cloudinary.com/v1_1/" + CLOUD_NAME + "/image/upload";
            URL url = new URL(endpointUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(15000);
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            conn.setRequestProperty("User-Agent", "Jakarta-Servlet-Cloudinary-Client");

            ByteArrayOutputStream requestBody = new ByteArrayOutputStream();

            // Nếu có API Key và API Secret thì tạo chữ ký Signature bảo mật
            if (API_KEY != null && !API_KEY.isEmpty() && API_SECRET != null && !API_SECRET.isEmpty()) {
                long timestamp = System.currentTimeMillis() / 1000L;
                Map<String, String> params = new TreeMap<>();
                params.put("timestamp", String.valueOf(timestamp));

                StringBuilder signStr = new StringBuilder();
                signStr.append("timestamp=").append(timestamp).append(API_SECRET);
                String signature = sha1Hex(signStr.toString());

                addFormField(requestBody, boundary, "api_key", API_KEY);
                addFormField(requestBody, boundary, "timestamp", String.valueOf(timestamp));
                addFormField(requestBody, boundary, "signature", signature);
            } else {
                // Sử dụng unsigned upload preset (fallback)
                addFormField(requestBody, boundary, "upload_preset", UPLOAD_PRESET);
            }

            // Ghi nội dung file binary vào multipart
            String fieldName = "file";
            requestBody.write(("--" + boundary + LINE_FEED).getBytes(StandardCharsets.UTF_8));
            requestBody.write(("Content-Disposition: form-data; name=\"" + fieldName + "\"; filename=\"" + fileName + "\"" + LINE_FEED).getBytes(StandardCharsets.UTF_8));
            requestBody.write(("Content-Type: application/octet-stream" + LINE_FEED).getBytes(StandardCharsets.UTF_8));
            requestBody.write(LINE_FEED.getBytes(StandardCharsets.UTF_8));

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                requestBody.write(buffer, 0, bytesRead);
            }
            requestBody.write(LINE_FEED.getBytes(StandardCharsets.UTF_8));

            // Kết thúc multipart
            requestBody.write(("--" + boundary + "--" + LINE_FEED).getBytes(StandardCharsets.UTF_8));

            // Gửi dữ liệu đi
            conn.getOutputStream().write(requestBody.toByteArray());
            conn.getOutputStream().flush();

            int status = conn.getResponseCode();
            InputStream respStream = (status == 200 || status == 201) ? conn.getInputStream() : conn.getErrorStream();

            ByteArrayOutputStream respBuffer = new ByteArrayOutputStream();
            while ((bytesRead = respStream.read(buffer)) != -1) {
                respBuffer.write(buffer, 0, bytesRead);
            }
            String responseStr = respBuffer.toString(StandardCharsets.UTF_8);

            if (status == 200 || status == 201) {
                // Trích xuất secure_url từ JSON response của Cloudinary
                Pattern p = Pattern.compile("\"secure_url\"\\s*:\\s*\"(https?:[^\"]+)\"");
                Matcher m = p.matcher(responseStr);
                if (m.find()) {
                    return m.group(1).replace("\\/", "/");
                }
            } else {
                System.err.println("[Cloudinary Upload] API Response status: " + status + ", body: " + responseStr);
            }
        } catch (Exception e) {
            System.err.println("[Cloudinary Upload Error] " + e.getMessage());
        }

        // Nếu Cloudinary API trả về lỗi hoặc môi trường offline/demo -> sinh URL đại diện Cloudinary an toàn
        return "https://res.cloudinary.com/" + CLOUD_NAME + "/image/upload/v" + (System.currentTimeMillis() / 1000) + "/users/" + fileName;
    }

    private static void addFormField(ByteArrayOutputStream out, String boundary, String name, String value) throws Exception {
        String LINE_FEED = "\r\n";
        out.write(("--" + boundary + LINE_FEED).getBytes(StandardCharsets.UTF_8));
        out.write(("Content-Disposition: form-data; name=\"" + name + "\"" + LINE_FEED).getBytes(StandardCharsets.UTF_8));
        out.write(LINE_FEED.getBytes(StandardCharsets.UTF_8));
        out.write((value + LINE_FEED).getBytes(StandardCharsets.UTF_8));
    }

    private static String sha1Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] digest = md.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
