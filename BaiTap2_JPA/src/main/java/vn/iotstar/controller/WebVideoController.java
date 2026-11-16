package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.VideoServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/home", "/video", "/video/detail" })
public class WebVideoController extends HttpServlet {
    private IVideoService videoService = new VideoServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    private static final int PAGE_SIZE = 6; // 6 video / sản phẩm mỗi trang theo yêu cầu

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/home")) {
            handleHome(req, resp);
        } else if (uri.endsWith("/video/detail")) {
            handleDetail(req, resp);
        } else if (uri.endsWith("/video")) {
            handleVideoListPagination(req, resp);
        }
    }

    /**
     * Yêu cầu 1: Hiển thị 10 video mới nhất lên trang chủ /home
     */
    private void handleHome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Video> top10Videos = videoService.findTop10Latest();
        List<Category> categories = categoryService.findAll();

        req.setAttribute("top10Videos", top10Videos);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }

    /**
     * Yêu cầu 2: Hiển thị tất cả video phân trang 6sp/trang trên URL /video
     */
    private void handleVideoListPagination(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Video> videoList = videoService.findAll(page, PAGE_SIZE);
        int totalPages = videoService.getTotalPages(PAGE_SIZE);
        int totalVideos = videoService.count();
        List<Category> categories = categoryService.findAll();

        req.setAttribute("videoList", videoList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalVideos", totalVideos);
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/views/web/video-list.jsp").forward(req, resp);
    }

    /**
     * Yêu cầu 3: Hiển thị chi tiết và play 01 video khi bấm vào tiêu đề
     */
    private void handleDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("id");
        if (videoId != null && !videoId.trim().isEmpty()) {
            // Tăng lượt xem video
            videoService.incrementViews(videoId);

            Video video = videoService.findById(videoId);
            List<Video> relatedVideos = videoService.findTop10Latest();

            req.setAttribute("video", video);
            req.setAttribute("relatedVideos", relatedVideos);
            req.getRequestDispatcher("/views/web/video-detail.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
