/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.OrderDetail;
import Models.OrderList;
import Models.Product;
import Utils.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Phat
 */
public class OrderDAO extends DBContext {

    public int insert(int userId) {

        String sql = "INSERT INTO Orders(userId, orderDate) VALUES\n"
                + "(?, GETDATE())";

        try {
            PreparedStatement st1 = conn.prepareStatement(sql);

            st1.setInt(1, userId);

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

    public int getMaxID() {
        String sql = "SELECT Max(orderId) AS maxId FROM Orders";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("maxId");
            }
        } catch (SQLException e) {
            System.out.println("Get by id fail: " + e.getMessage());
        }
        return 0;
    }

    public List<OrderList> getOrderByUserId(int id) {
        List<OrderList> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders\n"
                + "JOIN OrderDetails ON OrderDetails.orderId = Orders.orderId\n"
                + "JOIN Products ON OrderDetails.productId = Products.proId\n"
                + "WHERE userId = ? AND status = 'pending'";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            Map<Integer, OrderList> OrderMap = new HashMap<>();
            while (rs.next()) {
                int orderId = rs.getInt("orderId");
                OrderList order = OrderMap.get(orderId);
                if (order == null) {
                    order = new OrderList(orderId, id, rs.getDate("orderDate"), rs.getString("status"));
                    OrderMap.put(orderId, order);
                }
                Product pro = new Product(rs.getInt("proId"), rs.getString("proName"), rs.getString("proDescription"), 0, 0, rs.getString("proImage"), null);
                OrderDetail orderDetail = new OrderDetail(rs.getInt("id"), null, pro, rs.getInt("quantity"), rs.getLong("unitPrice"), rs.getLong("totalPrice"));
                order.addOrderDetail(orderDetail);
            }
            orders.addAll(OrderMap.values());
            return orders;
        } catch (SQLException e) {
            System.out.println("Get by id fail: " + e.getMessage());
        }
        return null;
    }

    public List<OrderList> getAll() {
        List<OrderList> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders\n"
                + "JOIN OrderDetails ON OrderDetails.orderId = Orders.orderId\n"
                + "JOIN Products ON OrderDetails.productId = Products.proId\n"
                + "ORDER BY orderDate DESC";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            Map<Integer, OrderList> OrderMap = new HashMap<>();
            while (rs.next()) {
                int orderId = rs.getInt("orderId");
                OrderList order = OrderMap.get(orderId);
                if (order == null) {
                    order = new OrderList(orderId, rs.getInt("userId"), rs.getDate("orderDate"), rs.getString("status"));
                    OrderMap.put(orderId, order);
                }
                Product pro = new Product(rs.getInt("proId"), rs.getString("proName"), rs.getString("proDescription"), 0, 0, rs.getString("proImage"), null);
                OrderDetail orderDetail = new OrderDetail(rs.getInt("id"), null, pro, rs.getInt("quantity"), rs.getLong("unitPrice"), rs.getLong("totalPrice"));
                order.addOrderDetail(orderDetail);
            }
            orders.addAll(OrderMap.values());
            return orders;
        } catch (SQLException e) {
            System.out.println("Get by id fail: " + e.getMessage());
        }
        return null;
    }

    public List<OrderList> getAll(String status) {
        List<OrderList> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders\n"
                + "JOIN OrderDetails ON OrderDetails.orderId = Orders.orderId\n"
                + "JOIN Products ON OrderDetails.productId = Products.proId\n"
                + "WHERE status = ? "
                + "ORDER BY orderDate DESC";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, status);
            ResultSet rs = st.executeQuery();
            Map<Integer, OrderList> OrderMap = new HashMap<>();
            while (rs.next()) {
                int orderId = rs.getInt("orderId");
                OrderList order = OrderMap.get(orderId);
                if (order == null) {
                    order = new OrderList(orderId, rs.getInt("userId"), rs.getDate("orderDate"), rs.getString("status"));
                    OrderMap.put(orderId, order);
                }
                Product pro = new Product(rs.getInt("proId"), rs.getString("proName"), rs.getString("proDescription"), 0, 0, rs.getString("proImage"), null);
                OrderDetail orderDetail = new OrderDetail(rs.getInt("id"), null, pro, rs.getInt("quantity"), rs.getLong("unitPrice"), rs.getLong("totalPrice"));
                order.addOrderDetail(orderDetail);
            }
            orders.addAll(OrderMap.values());
            return orders;
        } catch (SQLException e) {
            System.out.println("Get by id fail: " + e.getMessage());
        }
        return null;
    }

    public int updateOrderStatus(int id, String status) {

        String sql = "UPDATE Orders\n"
                + "SET status = ?\n"
                + "WHERE orderId = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);

            st.setString(1, status);
            st.setInt(2, id);

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

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        System.out.println(dao.getMaxID());
//        System.out.println(dao.insert(2));
        //Test Get all
//        List<OrderList> p = dao.getOrderByUserId(2);
//        System.out.println("Get All: ");
//        for (OrderList product : p) {
//            System.out.println(product.getId());
//        }
    }
}
