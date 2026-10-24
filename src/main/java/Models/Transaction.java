package Models;

import java.sql.Timestamp;

public class Transaction {

    private int id;
    private int userId;
    private double amount;
    private String status;
    private Timestamp requestDate; // Thêm dòng này

    public Transaction() {
    }

    public Transaction(int id, int userId, double amount, String status, Timestamp requestDate) {
        this.id = id;
        this.userId = userId;
        this.amount = amount;
        this.status = status;
        this.requestDate = requestDate;
    }

    // --- Getter & Setter ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRequestDate() {  // Thêm getter
        return requestDate;
    }

    public void setRequestDate(Timestamp requestDate) {  // Thêm setter
        this.requestDate = requestDate;
    }
}
