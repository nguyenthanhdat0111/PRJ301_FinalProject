/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.User;
import Utils.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Phat
 */
public class UserDAO extends DBContext {

    public User getUserById(int id) {
        String sql = "select * from Users where id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String role = rs.getString("role");
                User user = new User(userId, username, password, fullname, gender, role);
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Get user by id fail: " + e.getMessage());
        }
        return null;
    }

    public List<User> getAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String role = rs.getString("role");
                User user = new User(userId, username, password, fullname, gender, role);

                users.add(user);
            }
            return users;
        } catch (SQLException e) {
            System.out.println("Get all user fail: " + e.getMessage());
        }
        return users;
    }

    public int insert(String username, String password, String fullname, String gender, String role) {

        String sql = "insert into Users(username, password, fullname, gender, role) values(?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, fullname);
            st.setString(4, gender);
            st.setString(5, role);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            }
        } catch (SQLException e) {
            System.out.println("Insert fail: " + e.getMessage());
            return 0;
        }
        return 0;
    }

    public int update(int id, String username, String password, String fullname, String gender, String role) {
        String sql = "update Users set id = ?, username = ?, password = ?, fullname = ?, gender = ?, role = ? where id =  ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.setString(2, username);
            st.setString(3, password);
            st.setString(4, fullname);
            st.setString(5, gender);
            st.setString(6, role);
            st.setInt(7, id);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            System.out.println("Update fail: " + e.getMessage());
            return 0;
        }
    }

    public int delete(int id) {
        String sql = "delete from Users where id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            System.out.println("Delete fail: " + e.getMessage());
            return 0;
        }
    }

    public User verify(String usernameCheck, String passwordCheck) {
        User user = new User();
        String sql = "SELECT * FROM users where username=? and password=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, usernameCheck);
            ps.setString(2, passwordCheck);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String role = rs.getString("role");

                user.setId(userId);
                user.setUsername(username);
                user.setPassword(password);
                user.setFullname(fullname);
                user.setGender(gender);
                user.setRole(role);
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Verify fail: " + e.getMessage());
        }
        return user;
    }

    public User getByName(String name) {

        String sql = "SELECT * FROM Users\n"
                + "WHERE username = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String role = rs.getString("role");
                User user = new User(userId, username, password, fullname, gender, role);
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Get by name fail: " + e.getMessage());
        }
        return null;
    }

    public long getUserBalance(int id) {

        String sql = "SELECT * FROM Users\n"
                + "WHERE id = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getLong("balance");
            }
        } catch (SQLException e) {
            System.out.println("Get by name fail: " + e.getMessage());
        }
        return -1;
    }

    public int updateBalance(int id, long change) {
        String sql = "UPDATE Users\n"
                + "SET balance = (SELECT balance FROM Users WHERE id = ?) + ?\n"
                + "WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.setLong(2, change);
            st.setInt(3, id);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            System.out.println("Update fail: " + e.getMessage());
            return 0;
        }
    }

    public int updatePassword(String username, String newPassword) {
        String sql = "UPDATE Users SET [password] = ? WHERE username = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, username);
            return st.executeUpdate() > 0 ? 1 : 0;
        } catch (SQLException e) {
            System.out.println("Update password fail: " + e.getMessage());
            return 0;
        }
    }

    public static void main(String[] args) {
        UserDAO c = new UserDAO();
//        //Test get user by id
//        System.out.println("Get user by id: " + c.getUserById(1).getUsername());
//        //Test verify
//        System.out.println("Verify: " + c.verify("admin", "123456").getUsername());
//        //Test get all
//        List<User> list = c.getAll();
//        System.out.println("Get All: ");
//        for (User user : list) {
//            System.out.println(user.getUsername());
//        }
//        //Test insert
//        System.out.println("Insert: " + c.insert("Test", "123456", "test user", "Male", "Customer"));
//        //Test update
//        System.out.println("Update: " + c.update(2, "TestUpdate", "123456", "test user", "Male", "Customer"));
//        //Test delete
//        System.out.println("Delete: " + c.delete(2));
//        //Test delete
//        System.out.println("Get by name: " + c.getByName("guest").getUsername());
//        System.out.println(c.getUserBalance(2));
//        System.out.println(c.updateBalance(2, -2000));
    }

    public void register(String username, String fullname, String password, String gender, String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean checkEmailExists(String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    void addBalance(int userId, int amount) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
