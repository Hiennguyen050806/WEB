package vn.iotstar.controller;

import java.io.File;
import java.io.FileNotFoundException;
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
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.ValidationUtil;

@SuppressWarnings("serial")
@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = cateService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // chuyển trang
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();
        if (url.contains("/admin/category/insert")) {
            // lấy dữ liệu từ form
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status") != null ? req.getParameter("status") : "1");
            String images = req.getParameter("images");

            // Validation cho FORM Insert Category
            Map<String, String> errors = new HashMap<>();
            if (ValidationUtil.isEmpty(categoryname)) {
                errors.put("categoryname", "Tên danh mục không được để trống!");
            }

            Part part = null;
            try {
                part = req.getPart("images1");
            } catch (Exception e) {
                // Ignore multipart parse errors
            }

            if (part != null && part.getSize() > 0) {
                String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                if (!ValidationUtil.isValidImageFile(submittedFileName)) {
                    errors.put("images1", "Ảnh tải lên phải có định dạng .jpg, .jpeg, .png, .gif hoặc .webp!");
                }
            }

            if (!errors.isEmpty()) {
                Category category = new Category();
                category.setCategoryname(categoryname);
                category.setStatus(status);
                category.setImages(images);

                req.setAttribute("errors", errors);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            // đưa dữ liệu vào model
            Category category = new Category();
            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR; // upload vào thư mục chỉ định
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            try {
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = (index != -1) ? filename.substring(index + 1) : "png";
                    fname = System.currentTimeMillis() + "." + ext;

                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages("avatar.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            // đưa model vào phương thức insert
            cateService.insert(category);
            // chuyển trang
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }

        if (url.contains("/admin/category/update")) {
            // lấy dữ liệu từ form
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status") != null ? req.getParameter("status") : "1");
            String images = req.getParameter("images");

            // Validation cho FORM Edit Category
            Map<String, String> errors = new HashMap<>();
            if (ValidationUtil.isEmpty(categoryname)) {
                errors.put("categoryname", "Tên danh mục không được để trống!");
            }

            Part part = null;
            try {
                part = req.getPart("images1");
            } catch (Exception e) {
                // Ignore multipart parse errors
            }

            if (part != null && part.getSize() > 0) {
                String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                if (!ValidationUtil.isValidImageFile(submittedFileName)) {
                    errors.put("images1", "Ảnh tải lên phải có định dạng .jpg, .jpeg, .png, .gif hoặc .webp!");
                }
            }

            if (!errors.isEmpty()) {
                Category category = cateService.findById(categoryid);
                if (category == null) {
                    category = new Category();
                    category.setCategoryid(categoryid);
                }
                category.setCategoryname(categoryname);
                category.setStatus(status);
                if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images);
                }

                req.setAttribute("errors", errors);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            // đưa dữ liệu vào model
            Category category = cateService.findById(categoryid);
            String fileold = (category != null && category.getImages() != null) ? category.getImages() : "avatar.png";
            
            if (category == null) {
                category = new Category();
                category.setCategoryid(categoryid);
            }
            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            try {
                if (part != null && part.getSize() > 0) {
                    // xóa file cũ trên thư mục nếu không phải link web
                    if (fileold != null && !fileold.startsWith("http")) {
                        deleteFile(uploadPath + File.separator + fileold);
                    }

                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = (index != -1) ? filename.substring(index + 1) : "png";
                    fname = System.currentTimeMillis() + "." + ext;

                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages(fileold);
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            // đưa model vào phương thức update
            cateService.update(category);
            // chuyển trang
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (IOException e) {
            System.err.println("Không thể xóa file: " + filePath + " (" + e.getMessage() + ")");
        }
    }
}
