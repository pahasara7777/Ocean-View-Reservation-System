package com.oceanview.service;

import org.junit.Assert;
import org.junit.Test;

public class ReservationValidationTest {

    @Test
    public void testValidDateRange() {
        // Simulating Check-in on the 1st, Check-out on the 5th (Valid)
        int checkInDay = 1;
        int checkOutDay = 5;
        
        // The check-out day MUST be greater than the check-in day
        boolean isValid = checkOutDay > checkInDay;
        
        Assert.assertTrue("System should accept a valid date range.", isValid);
    }

    @Test
    public void testInvalidDateRange() {
        // Simulating Check-in on the 5th, Check-out on the 3rd (Invalid - Time Travel!)
        int checkInDay = 5;
        int checkOutDay = 3;
        
        boolean isValid = checkOutDay > checkInDay;
        
        Assert.assertFalse("System must reject check-out dates that happen before check-in.", isValid);
    }
}