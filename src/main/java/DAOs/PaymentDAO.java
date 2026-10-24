/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Payment;
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
public class PaymentDAO extends DBContext {

    public int insert(int orderId, long price) {

        String sql = "INSERT INTO Payments(orderId, paymentDate, amount) VALUES\n"
                + "(?, GETDATE(), ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sql);

            st1.setInt(1, orderId);
            st1.setLong(2, price);

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

    public List<Payment> getAll(int userIdCheck) {
        List<Payment> payments = new ArrayList<>();

        String sql = "SELECT * FROM Payments\n"
                + "JOIN Orders ON Payments.orderId = Orders.orderId\n"
                + "WHERE userId = ?\n"
                + "ORDER BY paymentDate DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userIdCheck);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment(rs.getInt("id"), null, rs.getDate("paymentDate"), rs.getLong("amount"));

                payments.add(payment);
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return payments;
    }

    public List<Payment> getAll() {
        List<Payment> payments = new ArrayList<>();

        String sql = "SELECT * FROM Payments\n"
                + "JOIN Orders ON Payments.orderId = Orders.orderId\n"
                + "ORDER BY paymentDate DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment(rs.getInt("id"), null, rs.getDate("paymentDate"), rs.getLong("amount"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return payments;
    }

    public static void main(String[] args) {
        PaymentDAO ao = new PaymentDAO();

        System.out.println(ao.getAll());
    }
}
