/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Product;
import Models.ProductType;
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
public class ProductDAO extends DBContext {

    public Product getById(int id) {

        String sql = "SELECT * FROM Products\n"
                + "JOIN ProductTypes ON Products.proTypeId = ProductTypes.id\n"
                + "Where proId = ? AND Products.isDeleted = 0";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, type);

                return product;
            }
        } catch (SQLException e) {
            System.out.println("Get by id fail: " + e.getMessage());
        }
        return null;
    }

    public Product getByName(String name) {

        String sql = "SELECT * FROM Products\n"
                + "JOIN ProductTypes ON Products.proTypeId = ProductTypes.id\n"
                + "Where proName = ? AND Products.isDeleted = 0";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, type);

                return product;
            }
        } catch (SQLException e) {
            System.out.println("Get by name fail: " + e.getMessage());
        }
        return null;
    }

    public List<Product> getAll() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Products\n"
                + "JOIN ProductTypes ON Products.proTypeId = ProductTypes.id\n"
                + "Where Products.isDeleted = 0";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, type);

                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return products;
    }

    public List<Product> getAvailableProduct() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Products\n"
                + "JOIN ProductTypes ON Products.proTypeId = ProductTypes.id\n"
                + "Where Products.isDeleted = 0 AND proQuantity > 0";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, type);

                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return products;
    }

    public List<Product> getAvailableByTypeId(int id) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Products\n"
                + "JOIN ProductTypes ON Products.proTypeId = ProductTypes.id\n"
                + "Where Products.isDeleted = 0 AND ProductTypes.id = ? AND proQuantity > 0";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, type);

                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Get all by type Id fail: " + e.getMessage());
        }
        return products;
    }

    public List<Product> getAvailableByKey(String key) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Products\n"
                + "JOIN ProductTypes ON Products.proTypeId = ProductTypes.id\n"
                + "Where Products.isDeleted = 0 AND proQuantity > 0 AND proName LIKE ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + key + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int proId = rs.getInt("proId");
                String proName = rs.getString("proName");
                String proDescription = rs.getString("proDescription");
                long proPrice = rs.getLong("proPrice");
                int proQuantity = rs.getInt("proQuantity");
                String proImage = rs.getString("proImage");

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                Product product = new Product(proId, proName, proDescription, proPrice, proQuantity, proImage, type);

                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Get all by type Id fail: " + e.getMessage());
        }
        return products;
    }

    public int insert(String name, String description, long price, int quantity, String image, int typeId) {

        String sql = "INSERT INTO Products(proName, proDescription, proPrice, proQuantity, proImage, proTypeId) VALUES\n"
                + "(?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sql);

            st1.setString(1, name);
            st1.setString(2, description);
            st1.setLong(3, price);
            st1.setInt(4, quantity);
            st1.setString(5, image);
            st1.setInt(6, typeId);

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

    public int update(int id, String name, String description, long price, int quantity, String image, int typeId) {

        String sql = "UPDATE [Products]\n"
                + "SET proName = ?, proDescription = ?, proPrice = ?, proQuantity = ?, proImage = ?, proTypeId  = ?\n"
                + "WHERE proId = ?;";

        try {
            PreparedStatement st = conn.prepareStatement(sql);

            st.setString(1, name);
            st.setString(2, description);
            st.setLong(3, price);
            st.setInt(4, quantity);
            st.setString(5, image);
            st.setInt(6, typeId);
            st.setInt(7, id);

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

    public int update(int id, int quantity) {

        String sql = "UPDATE Products\n"
                + "SET proQuantity = (SELECT proQuantity FROM Products WHERE proId = ?) + ?\n"
                + "WHERE proId = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);

            st.setInt(1, id);
            st.setInt(2, quantity);
            st.setInt(3, id);

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

        String sql = "Update Products\n"
                + "SET isDeleted = 1\n"
                + "WHERE proId = ?";

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
        ProductDAO c = new ProductDAO();
//        //Test Get by id
//        System.out.println("Get by id: " + c.getById(1).getName());
//        //Test Get by name
//        System.out.println("Get by name: " + c.getByName("Nguyen Xuan Shampoo").getName());
//        //Test Get all
//        List<Product> p = c.getAll();
//        System.out.println("Get All: ");
//        for (Product product : p) {
//            System.out.println(product.getName());
//        }
//        //Test Get by Id all
//        List<Product> p = c.getAvailableByTypeId(11);
//        System.out.println("Get All: ");
//        for (Product product : p) {
//            System.out.println(product.getName());
//        }
//        //Test insert
//        System.out.println("Insert: " + c.insert("Test", "test new", 3000, 40, "New", 2));
//        //Test update
//        System.out.println("Update: " + c.update(2, "ChangeName", "change", 4000, 30, "Change", 3));
//        //Test delete
//        System.out.println("Delete: " + c.delete(2));
    }
}
