/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Cart;
import Models.Product;
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
public class CartDAO extends DBContext {

    public int insert(int userId, int proId, long price, int quantity) {

        String sql = "INSERT INTO Carts(userId, productId, unitPrice, quantity) VALUES\n"
                + "(?, ?, ?, ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sql);

            st1.setInt(1, userId);
            st1.setInt(2, proId);
            st1.setLong(3, price);
            st1.setInt(4, quantity);

            int rowsAffected = st1.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            System.out.println("Insert fail: " + e.getMessage());
            return 0;
        }
    }

    public List<Cart> getAll(int userIdCheck) {
        List<Cart> carts = new ArrayList<>();

        String sql = "SELECT * FROM Carts\n"
                + "JOIN Products ON Carts.productId = Products.proId\n"
                + "WHERE userId = ? AND status = 'active'";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userIdCheck);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id");
                int userId = rs.getInt("userId");
                String status = rs.getString("status");
                long price = rs.getLong("unitPrice");
                int quantity = rs.getInt("quantity");

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, null);

                Cart cart = new Cart(id, userId, status, product, quantity, price);

                carts.add(cart);
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return carts;
    }

    public Cart getByProductId(int userIdCheck, int proIdCheck) {
        String sql = "SELECT * FROM Carts\n"
                + "JOIN Products ON Carts.productId = Products.proId\n"
                + "WHERE userId = ? AND status = 'active' AND productId = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userIdCheck);
            ps.setInt(2, proIdCheck);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                int id = rs.getInt("id");
                int userId = rs.getInt("userId");
                String status = rs.getString("status");
                long price = rs.getLong("unitPrice");
                int quantity = rs.getInt("quantity");

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, null);

                Cart cart = new Cart(id, userId, status, product, quantity, price);

                return cart;
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return null;
    }

    public int update(int userId, int proId, int quantity) {

        String sql = "UPDATE Carts\n"
                + "SET quantity = (SELECT quantity FROM Carts WHERE userId = ? AND productId = ?) + ?\n"
                + "WHERE userId = ? AND productId = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);

            st.setInt(1, userId);
            st.setInt(2, proId);
            st.setInt(3, quantity);
            st.setInt(4, userId);
            st.setInt(5, proId);

            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            System.out.println("update fail: " + e.getMessage());
            return 0;
        }
    }

    public int delete(int id) {

        String sql = "DELETE FROM Carts\n"
                + "Where id = ?";

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
            System.out.println("delete fail: " + e.getMessage());
            return 0;
        }
    }

    public static void main(String[] args) {
        CartDAO c = new CartDAO();
        List<Cart> p = c.getAll(2);
        System.out.println("Get All: ");
        for (Cart product : p) {
            System.out.println(product.getUnitPrice());
        }
//        System.out.println(c.getByProductId(2, 1));
//        System.out.println(c.update(2, 1, 3));
//        System.out.println(c.delete(5));
    }
}
