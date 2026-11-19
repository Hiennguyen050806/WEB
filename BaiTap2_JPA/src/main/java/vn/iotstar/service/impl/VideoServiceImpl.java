package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.dao.impl.VideoDaoImpl;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;

public class VideoServiceImpl implements IVideoService {
    private IVideoDao videoDao = new VideoDaoImpl();

    @Override
    public void insert(Video video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video video) {
        videoDao.update(video);
    }

    @Override
    public void delete(String videoId) throws Exception {
        videoDao.delete(videoId);
    }

    @Override
    public Video findById(String videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video> findTop10Latest() {
        return videoDao.findTop10Latest();
    }

    @Override
    public List<Video> findAll(int page, int pageSize) {
        if (page < 1) {
            page = 1;
        }
        return videoDao.findAll(page, pageSize);
    }

    @Override
    public List<Video> findByUserId(int userId, int page, int pageSize) {
        if (page < 1) {
            page = 1;
        }
        return videoDao.findByUserId(userId, page, pageSize);
    }

    @Override
    public int count() {
        return videoDao.count();
    }

    @Override
    public int countByUserId(int userId) {
        return videoDao.countByUserId(userId);
    }

    @Override
    public int getTotalPages(int pageSize) {
        int total = videoDao.count();
        int pages = total / pageSize;
        if (total % pageSize != 0) {
            pages++;
        }
        return pages == 0 ? 1 : pages;
    }

    @Override
    public int getTotalPagesByUserId(int userId, int pageSize) {
        int total = videoDao.countByUserId(userId);
        int pages = total / pageSize;
        if (total % pageSize != 0) {
            pages++;
        }
        return pages == 0 ? 1 : pages;
    }

    @Override
    public List<Video> searchByTitle(String keyword) {
        return videoDao.searchByTitle(keyword);
    }

    @Override
    public void incrementViews(String videoId) {
        videoDao.incrementViews(videoId);
    }
}
