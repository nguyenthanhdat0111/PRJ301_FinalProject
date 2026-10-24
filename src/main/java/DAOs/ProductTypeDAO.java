/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

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
public class ProductTypeDAO extends DBContext {

    public List<ProductType> getAll() {
        List<ProductType> productTypes = new ArrayList<>();

        String sql = "SELECT * FROM ProductTypes\n"
                + "WHERE isDeleted = 0";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("typeImage");
                ProductType type = new ProductType(id, name, image);
                productTypes.add(type);
            }
        } catch (SQLException e) {
            System.out.println("Get all fail: " + e.getMessage());
        }
        return productTypes;
    }

    public ProductType getById(int id) {

        String sql = "SELECT * FROM ProductTypes\n"
                + "WHERE id = ? AND isDeleted = 0";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                return type;
            }
        } catch (SQLException e) {
            System.out.println("Get by id fail: " + e.getMessage());
        }
        return null;
    }

    public ProductType getByName(String name) {

        String sql = "SELECT * FROM ProductTypes\n"
                + "WHERE name = ? AND isDeleted = 0";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {

                int typeId = rs.getInt("id");
                String typeName = rs.getString("name");
                String typeImage = rs.getString("typeImage");

                ProductType type = new ProductType(typeId, typeName, typeImage);
                return type;
            }
        } catch (SQLException e) {
            System.out.println("Get by name fail: " + e.getMessage());
        }
        return null;
    }

    public int insert(String name, String image) {

        String sql = "INSERT INTO ProductTypes(name, typeImage) VALUES\n"
                + "(?, ?)";

        try {
            PreparedStatement st1 = conn.prepareStatement(sql);

            st1.setString(1, name);
            st1.setString(2, image);

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

    public int update(int id, String name, String image) {

        String sql = "UPDATE [ProductTypes]\n"
                + "SET name = ?, typeImage = ?\n"
                + "WHERE id = ?;";

        try {
            PreparedStatement st = conn.prepareStatement(sql);

            st.setString(1, name);
            st.setString(2, image);
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

        String sql = "Update ProductTypes\n"
                + "SET isDeleted = 1\n"
                + "WHERE id = ?";

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
        ProductTypeDAO c = new ProductTypeDAO();

//        //Test Get all
//        List<ProductType> a = c.getAll();
//        System.out.println("Get all: ");
//        for (ProductType category : a) {
//            System.out.println(category.getName());
//        }
//        //Test Get by id
//        System.out.println("Get by id: " + c.getById(1).getName());
//        //Test Get by name
//        System.out.println("Get by name: " + c.getByName("Canned good").getName());
//        //Test insert
//        System.out.println("Insert: " + c.insert("Test", "test new"));
//        //Test update
//        System.out.println("Update: " + c.update(1, "ChangeName", "change"));
//        //Test delete
//        System.out.println("Delete: " + c.delete(13));
    }
}
