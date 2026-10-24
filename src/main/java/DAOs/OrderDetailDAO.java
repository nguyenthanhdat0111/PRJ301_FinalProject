/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Utils.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Phat
 */
public class OrderDetailDAO extends DBContext {

    public int insert(int orderId, int proId, int quantity, long price) {

        String sql = "INSERT INTO OrderDetails(orderId, productId, quantity, unitPrice, totalPrice) VALUES\n"
                + "(?, ?, ?, ?, ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sql);

            st1.setInt(1, orderId);
            st1.setInt(2, proId);
            st1.setInt(3, quantity);
            st1.setLong(4, price);
            st1.setLong(5, quantity*price);

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
}
