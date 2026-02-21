package com.oceanview.service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Service class responsible for handling business logic related to billing and cost calculations.
 */
public class BillingService {

    /**
     * Computes the total stay cost based on the number of nights and the specific room rate.
     * * @param checkInDate  The date the guest checks in
     * @param checkOutDate The date the guest checks out
     * @param ratePerNight The nightly rate of the selected room
     * @return The total cost of the stay
     * @throws IllegalArgumentException if the check-out date is before or equal to the check-in date
     */
    public double calculateTotalCost(Date checkInDate, Date checkOutDate, double ratePerNight) {
        
        // Convert java.sql.Date to java.time.LocalDate for accurate date math
        LocalDate checkIn = checkInDate.toLocalDate();
        LocalDate checkOut = checkOutDate.toLocalDate();
        
        // Validate dates: Check-out must be strictly after check-in
        if (!checkOut.isAfter(checkIn)) {
            throw new IllegalArgumentException("Check-out date must be after the check-in date.");
        }
        
        // Calculate the number of nights stayed
        long numberOfNights = ChronoUnit.DAYS.between(checkIn, checkOut);
        
        // Compute and return the total cost
        return numberOfNights * ratePerNight;
    }
}