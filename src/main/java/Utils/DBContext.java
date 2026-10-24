package Utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection conn = null;

    public DBContext() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            String dbURL = "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=businessProject;"
                    + "user=sa;"
                    + "password=123456;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true;"
                    + "loginTimeout=5;";

            conn = DriverManager.getConnection(dbURL);

            DatabaseMetaData dm = conn.getMetaData();
            System.out.println("CONNECTED DATABASE SUCCESSFULLY");
            System.out.println("Driver name: " + dm.getDriverName());
            System.out.println("Product name: " + dm.getDatabaseProductName());

        } catch (ClassNotFoundException e) {
            throw new RuntimeException("SQL Server JDBC Driver not found", e);
        } catch (SQLException e) {
            throw new RuntimeException("Cannot connect database: " + e.getMessage(), e);
        }
    }

    public Connection getConnection() {
        return conn;
    }
}