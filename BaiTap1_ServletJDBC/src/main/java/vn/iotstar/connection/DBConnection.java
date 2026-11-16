package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC";
    private final String portNumber = "1433";
    private final String instance = ""; // MSSQLSERVER LEAVE THIS ONE EMPTY IF YOUR SQL IS A SINGLE INSTANCE
    private final String userID = "sa";
    private final String password = "1234567@a$"; // hoặc mật khẩu sql của bạn

    public Connection getConnection() throws Exception {
        String url;
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                    + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        } else {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance
                    + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, userID, password);
        } catch (Exception e) {
            // Dự phòng kết nối MySQL nếu bạn dùng MySQL
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String mysqlUrl = "jdbc:mysql://localhost:3306/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
                return DriverManager.getConnection(mysqlUrl, "root", "1234567@a$");
            } catch (Exception ex) {
                throw e; // Ném lỗi gốc của SQL Server
            }
        }
    }

    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("Kết nối cơ sở dữ liệu thành công!");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        }
    }
}
