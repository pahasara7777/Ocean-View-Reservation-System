package com.oceanview.service;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Date;
import java.time.LocalDate;

/**
 * JUnit Test Case to verify the ethical and accurate calculation of guest bills.
 */
public class BillingServiceTest {

    private BillingService billingService;

    // The @BeforeEach annotation tells JUnit to run this before every single test
    @BeforeEach
    public void setUp() {
        billingService = new BillingService();
    }

    // The @Test annotation tells Eclipse that this is a test to execute
    @Test
    public void testStandardStayCalculation() {
        // 1. Arrange: Set up fake dates (A 3-night stay)
        Date checkIn = Date.valueOf("2026-03-01");
        Date checkOut = Date.valueOf("2026-03-04");
        double ratePerNight = 5000.00; // Standard Single room

        // 2. Act: Ask your billing service to calculate the total
        double actualTotal = billingService.calculateTotalCost(checkIn, checkOut, ratePerNight);

        // 3. Assert: Verify the result is exactly 15000.00 (3 nights * 5000)
        Assertions.assertEquals(15000.00, actualTotal, "The total cost for 3 nights should be 15,000 LKR");
    }

   
    @Test
    public void testInvalidDatesThrowsException() {
        // 1. Arrange: Check-out date is BEFORE the check-in date (A time traveler!)
        Date checkIn = Date.valueOf("2026-03-05");
        Date checkOut = Date.valueOf("2026-03-01");
        double ratePerNight = 5000.00;

        // 2 & 3. Act and Assert: Expect the system to ethically reject this by throwing an error
        Assertions.assertThrows(IllegalArgumentException.class, () -> {
            billingService.calculateTotalCost(checkIn, checkOut, ratePerNight);
        }, "System should throw an error if check-out is before check-in");
    }
}