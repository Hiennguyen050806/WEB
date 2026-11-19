package vn.iotstar.config;

import java.util.Date;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.util.PasswordUtil;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        // 1. Tạo User mẫu
        User user = new User();
        user.setUsername("admin");
        user.setPassword(PasswordUtil.hashPassword("123")); // Mã hóa SHA-256
        user.setEmail("admin@iotstar.vn");
        user.setFullname("Nguyễn Hữu Trung (Admin)");
        user.setPhone("0908617108");
        user.setRoleid(1); // Admin
        user.setStatus(1); // Đã kích hoạt
        user.setCreatedDate(new Date());

        // 2. Tạo Category mẫu
        Category cate = new Category();
        cate.setCategoryname("Công Nghệ & Lập Trình");
        cate.setImages("congnghe.jpg");
        cate.setStatus(1);

        // 3. Tạo Video mẫu thuộc về User và Category trên (Mối quan hệ 1-n)
        Video video = new Video();
        video.setVideoId("v01");
        video.setTitle("Hướng dẫn Lập trình Web Servlet & JPA 3.0");
        video.setDescription("Video bài giảng hướng dẫn chi tiết CRUD Category và Video với JPA 3.0 và Jakarta 6.0");
        video.setPoster("poster01.jpg");
        video.setActive(1);
        video.setViews(120);
        video.setCategory(cate);
        video.setUser(user); // Gán mối quan hệ 1-n với User

        try {
            trans.begin();
            enma.persist(user);
            enma.persist(cate);
            enma.persist(video);
            trans.commit();
            System.out.println("Thêm dữ liệu User, Category và Video (quan hệ 1-n) qua JPA thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
            JpaConfig.closeFactory();
        }
    }
}
