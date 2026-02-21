package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object implementation for the Reservation entity.
 */
public class ReservationDAOImpl implements BaseDAO<Reservation, Integer> {

    private static final String INSERT_RESERVATION_SQL = 
        "INSERT INTO reservations (guest_id, room_id, check_in_date, check_out_date, total_cost, status) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_RESERVATION_BY_ID = 
        "SELECT * FROM reservations WHERE reservation_id = ?";
    private static final String SELECT_ALL_RESERVATIONS = 
        "SELECT * FROM reservations";

    @Override
    public boolean save(Reservation entity) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RESERVATION_SQL)) {
                preparedStatement.setInt(1, entity.getGuestId());
                preparedStatement.setInt(2, entity.getRoomId());
                preparedStatement.setDate(3, entity.getCheckInDate());
                preparedStatement.setDate(4, entity.getCheckOutDate());
                preparedStatement.setDouble(5, entity.getTotalCost());
                preparedStatement.setString(6, entity.getStatus());
                
                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error saving reservation: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Optional<Reservation> findById(Integer id) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESERVATION_BY_ID)) {
                preparedStatement.setInt(1, id);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    if (rs.next()) {
                        return Optional.of(new Reservation(
                            rs.getInt("reservation_id"),
                            rs.getInt("guest_id"),
                            rs.getInt("room_id"),
                            rs.getDate("check_in_date"),
                            rs.getDate("check_out_date"),
                            rs.getDouble("total_cost"),
                            rs.getString("status")
                        ));
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving reservation: " + e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<Reservation> findAll() {
        List<Reservation> reservations = new ArrayList<>();
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_RESERVATIONS);
                 ResultSet rs = preparedStatement.executeQuery()) {
                
                while (rs.next()) {
                    reservations.add(new Reservation(
                        rs.getInt("reservation_id"),
                        rs.getInt("guest_id"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in_date"),
                        rs.getDate("check_out_date"),
                        rs.getDouble("total_cost"),
                        rs.getString("status")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving all reservations: " + e.getMessage());
            e.printStackTrace();
        }
        return reservations;
    }

    @Override
    public boolean update(Reservation entity) { return false; }

    @Override
    public boolean delete(Integer id) { return false; }
}