package com.oceanview.model;

public class Room {
    private int roomId;
    private String roomType;
    private double ratePerNight;

    public Room() {}

    public Room(int roomId, String roomType, double ratePerNight) {
        this.roomId = roomId;
        this.roomType = roomType;
        this.ratePerNight = ratePerNight;
    }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getRatePerNight() { return ratePerNight; }
    public void setRatePerNight(double ratePerNight) { this.ratePerNight = ratePerNight; }
}