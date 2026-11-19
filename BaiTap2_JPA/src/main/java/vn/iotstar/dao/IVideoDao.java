package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Video;

public interface IVideoDao {
    void insert(Video video);

    void update(Video video);

    void delete(String videoId) throws Exception;

    Video findById(String videoId);

    List<Video> findAll();

    List<Video> findTop10Latest();

    List<Video> findAll(int page, int pageSize);

    List<Video> findByUserId(int userId, int page, int pageSize);

    int count();

    int countByUserId(int userId);

    List<Video> searchByTitle(String keyword);

    void incrementViews(String videoId);
}
