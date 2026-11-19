package vn.iotstar.filter;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

/**
 * Filter mô phỏng và thực thi cơ chế SiteMesh 3 Decorator chuẩn trong Jakarta EE 10 (Servlet 6.0)
 * Áp dụng Decorator Bootstrap 5 cho toàn bộ ứng dụng:
 * - /admin/* -> /decorators/admin.jsp
 * - Các trang còn lại -> /decorators/web.jsp
 */
@WebFilter(filterName = "SiteMeshFilter", urlPatterns = "/*")
public class SiteMeshFilter implements Filter {

    private static final Pattern TITLE_PATTERN = Pattern.compile("<title>(.*?)</title>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
    private static final Pattern BODY_PATTERN = Pattern.compile("<body[^>]*>(.*?)</body>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Loại trừ các đường dẫn tài nguyên tĩnh, binary, image, upload
        if (isExcluded(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Bọc response để ghi nhận nội dung HTML
        CharResponseWrapper responseWrapper = new CharResponseWrapper(resp);
        chain.doFilter(request, responseWrapper);

        String contentType = responseWrapper.getContentType();
        int status = responseWrapper.getStatus();

        // Chỉ decorate khi response thành công (200) và là text/html
        if (status == HttpServletResponse.SC_OK && (contentType == null || contentType.contains("text/html"))) {
            String originalContent = responseWrapper.toString();

            if (originalContent != null && !originalContent.trim().isEmpty()) {
                String title = extractTitle(originalContent);
                String body = extractBody(originalContent);

                req.setAttribute("pageTitle", title);
                req.setAttribute("body", body);

                String decoratorPage = path.startsWith("/admin") ? "/decorators/admin.jsp" : "/decorators/web.jsp";

                // Bọc tiếp decorator để thay thế tag <sitemesh:write property='body'/> nếu có
                CharResponseWrapper decoratorWrapper = new CharResponseWrapper(resp);
                req.getRequestDispatcher(decoratorPage).include(req, decoratorWrapper);

                String decoratedHtml = decoratorWrapper.toString();
                if (decoratedHtml != null) {
                    decoratedHtml = decoratedHtml.replace("<sitemesh:write property='body'/>", body);
                    decoratedHtml = decoratedHtml.replace("<sitemesh:write property='title'/>", title);
                }

                resp.setContentType("text/html;charset=UTF-8");
                resp.getWriter().write(decoratedHtml != null ? decoratedHtml : originalContent);
                return;
            }
        }

        // Ghi lại nội dung thông thường nếu không decorate
        resp.getWriter().write(responseWrapper.toString());
    }

    private boolean isExcluded(String path) {
        if (path == null) return true;
        return path.startsWith("/image")
                || path.startsWith("/uploads")
                || path.startsWith("/decorators")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".mp4")
                || path.endsWith(".ico");
    }

    private String extractTitle(String html) {
        Matcher matcher = TITLE_PATTERN.matcher(html);
        if (matcher.find()) {
            return matcher.group(1).trim();
        }
        return "Video Portal &amp; Category Manager";
    }

    private String extractBody(String html) {
        Matcher matcher = BODY_PATTERN.matcher(html);
        if (matcher.find()) {
            return matcher.group(1).trim();
        }
        return html;
    }

    @Override
    public void destroy() {
    }

    /**
     * Response Wrapper ghi nhận output buffer dạng ký tự
     */
    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private CharArrayWriter charArrayWriter = new CharArrayWriter();
        private PrintWriter printWriter = new PrintWriter(charArrayWriter);

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
        }

        @Override
        public PrintWriter getWriter() throws IOException {
            return printWriter;
        }

        @Override
        public String toString() {
            printWriter.flush();
            return charArrayWriter.toString();
        }
    }
}
