package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

public class UserDaoImpl implements UserDao {
    private DBConnection db = new DBConnection();

    @Override
    public User get(String username) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        // Chú ý: nếu trên MySQL bảng là User (không có ngoặc vuông), ta có thể fallback
        try (Connection conn = db.getConnection()) {
            PreparedStatement ps;
            try {
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
            } catch (Exception ex) {
                // Fallback nếu chạy MySQL (User không dùng ngoặc vuông hoặc dùng backticks)
                ps = conn.prepareStatement("SELECT * FROM `User` WHERE username = ?");
                ps.setString(1, username);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setUserName(rs.getString("username"));
                    user.setFullName(rs.getString("fullname"));
                    user.setPassWord(rs.getString("password"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setRoleid(rs.getInt("roleid"));
                    user.setPhone(rs.getString("phone"));
                    user.setCreatedDate(rs.getDate("createddate"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(User user) {
        String sql = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createddate) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = db.getConnection()) {
            PreparedStatement ps;
            try {
                ps = conn.prepareStatement(sql);
            } catch (Exception ex) {
                ps = conn.prepareStatement("INSERT INTO `User`(email, username, fullname, password, avatar, roleid, phone, createddate) VALUES (?,?,?,?,?,?,?,?)");
            }
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        String query = "SELECT * FROM [User] WHERE email = ?";
        try (Connection conn = db.getConnection()) {
            PreparedStatement ps;
            try {
                ps = conn.prepareStatement(query);
            } catch (Exception ex) {
                ps = conn.prepareStatement("SELECT * FROM `User` WHERE email = ?");
            }
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        String query = "SELECT * FROM [User] WHERE username = ?";
        try (Connection conn = db.getConnection()) {
            PreparedStatement ps;
            try {
                ps = conn.prepareStatement(query);
            } catch (Exception ex) {
                ps = conn.prepareStatement("SELECT * FROM `User` WHERE username = ?");
            }
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        String query = "SELECT * FROM [User] WHERE phone = ?";
        try (Connection conn = db.getConnection()) {
            PreparedStatement ps;
            try {
                ps = conn.prepareStatement(query);
            } catch (Exception ex) {
                ps = conn.prepareStatement("SELECT * FROM `User` WHERE phone = ?");
            }
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
