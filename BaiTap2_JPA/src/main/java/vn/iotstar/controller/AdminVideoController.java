package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.VideoServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.ValidationUtil;

@SuppressWarnings("serial")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 20, // 20MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(urlPatterns = { "/admin/videos", "/admin/video/add", "/admin/video/insert",
        "/admin/video/edit", "/admin/video/update", "/admin/video/delete" })
public class AdminVideoController extends HttpServlet {
    private IVideoService videoService = new VideoServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/admin/videos")) {
            List<Video> list = videoService.findAll();
            req.setAttribute("videoList", list);
            req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/video/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/video/edit")) {
            String videoId = req.getParameter("id");
            Video video = videoService.findById(videoId);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("video", video);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
        } else if (uri.endsWith("/admin/video/delete")) {
            String videoId = req.getParameter("id");
            try {
                videoService.delete(videoId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.endsWith("/admin/video/insert")) {
            String videoId = req.getParameter("videoId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            int active = Integer.parseInt(req.getParameter("active") != null ? req.getParameter("active") : "1");
            int categoryId = 0;
            try {
                categoryId = Integer.parseInt(req.getParameter("categoryId"));
            } catch (Exception e) {
                // ignore
            }
            String posterUrl = req.getParameter("poster");

            // FORM VALIDATION: INSERT VIDEO
            Map<String, String> errors = new HashMap<>();
            if (ValidationUtil.isEmpty(videoId)) {
                errors.put("videoId", "Mã video không được để trống!");
            } else if (!ValidationUtil.isValidVideoId(videoId)) {
                errors.put("videoId", "Mã video chỉ gồm chữ, số, dấu gạch nối hoặc gạch dưới (tối đa 50 ký tự)!");
            } else if (videoService.findById(videoId.trim()) != null) {
                errors.put("videoId", "Mã video đã tồn tại trong hệ thống!");
            }

            if (ValidationUtil.isEmpty(title)) {
                errors.put("title", "Tiêu đề video không được để trống!");
            }

            Category category = (categoryId > 0) ? categoryService.findById(categoryId) : null;
            if (category == null) {
                errors.put("categoryId", "Vui lòng chọn danh mục hợp lệ!");
            }

            Part posterPart = null;
            try {
                posterPart = req.getPart("posterFile");
            } catch (Exception e) {
                // ignore
            }

            if (posterPart != null && posterPart.getSize() > 0) {
                String submittedFileName = Paths.get(posterPart.getSubmittedFileName()).getFileName().toString();
                if (!ValidationUtil.isValidImageFile(submittedFileName)) {
                    errors.put("posterFile", "File poster phải có định dạng ảnh hợp lệ (.jpg, .jpeg, .png, .gif, .webp)!");
                }
            }

            if (!errors.isEmpty()) {
                Video video = new Video();
                video.setVideoId(videoId);
                video.setTitle(title);
                video.setDescription(description);
                video.setActive(active);
                video.setPoster(posterUrl);
                video.setCategory(category);

                List<Category> categories = categoryService.findAll();
                req.setAttribute("categories", categories);
                req.setAttribute("video", video);
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
                return;
            }

            Video video = new Video();
            video.setVideoId(videoId.trim());
            video.setTitle(title);
            video.setDescription(description);
            video.setActive(active);
            video.setViews(0);

            // Gán Category
            video.setCategory(category);

            // Gán User sở hữu video (Quan hệ 1-n giữa User và Videos)
            HttpSession session = req.getSession(false);
            if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
                User currentUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
                video.setUser(currentUser);
            }

            // Upload poster file bằng Multipart
            String posterFile = handleUploadPoster(req, "posterFile");
            if (posterFile != null && !posterFile.isEmpty()) {
                video.setPoster(posterFile);
            } else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                video.setPoster(posterUrl);
            } else {
                video.setPoster("default-video.png");
            }

            videoService.insert(video);
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        } else if (uri.endsWith("/admin/video/update")) {
            String videoId = req.getParameter("videoId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            int active = Integer.parseInt(req.getParameter("active") != null ? req.getParameter("active") : "1");
            int categoryId = 0;
            try {
                categoryId = Integer.parseInt(req.getParameter("categoryId"));
            } catch (Exception e) {
                // ignore
            }
            String posterUrl = req.getParameter("poster");

            // FORM VALIDATION: EDIT / UPDATE VIDEO
            Map<String, String> errors = new HashMap<>();
            if (ValidationUtil.isEmpty(title)) {
                errors.put("title", "Tiêu đề video không được để trống!");
            }

            Category category = (categoryId > 0) ? categoryService.findById(categoryId) : null;
            if (category == null) {
                errors.put("categoryId", "Vui lòng chọn danh mục hợp lệ!");
            }

            Part posterPart = null;
            try {
                posterPart = req.getPart("posterFile");
            } catch (Exception e) {
                // ignore
            }

            if (posterPart != null && posterPart.getSize() > 0) {
                String submittedFileName = Paths.get(posterPart.getSubmittedFileName()).getFileName().toString();
                if (!ValidationUtil.isValidImageFile(submittedFileName)) {
                    errors.put("posterFile", "File poster phải có định dạng ảnh hợp lệ (.jpg, .jpeg, .png, .gif, .webp)!");
                }
            }

            if (!errors.isEmpty()) {
                Video video = videoService.findById(videoId);
                if (video == null) {
                    video = new Video();
                    video.setVideoId(videoId);
                }
                video.setTitle(title);
                video.setDescription(description);
                video.setActive(active);
                video.setCategory(category);
                if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                    video.setPoster(posterUrl);
                }

                List<Category> categories = categoryService.findAll();
                req.setAttribute("categories", categories);
                req.setAttribute("video", video);
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
                return;
            }

            Video video = videoService.findById(videoId);
            if (video != null) {
                video.setTitle(title);
                video.setDescription(description);
                video.setActive(active);

                video.setCategory(category);

                String posterFile = handleUploadPoster(req, "posterFile");
                if (posterFile != null && !posterFile.isEmpty()) {
                    if (video.getPoster() != null && !video.getPoster().startsWith("http")) {
                        deleteFile(Constant.DIR + File.separator + video.getPoster());
                    }
                    video.setPoster(posterFile);
                } else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                    video.setPoster(posterUrl);
                }

                videoService.update(video);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }

    private String handleUploadPoster(HttpServletRequest req, String partName) {
        try {
            Part part = req.getPart(partName);
            if (part != null && part.getSize() > 0) {
                String uploadPath = Constant.UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = (index != -1) ? filename.substring(index + 1) : "png";
                String fname = "video_" + System.currentTimeMillis() + "." + ext;

                part.write(uploadPath + File.separator + fname);
                return fname;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (IOException e) {
            System.err.println("Không thể xóa file: " + e.getMessage());
        }
    }
}
