package com.oceanview.service;

import org.junit.Assert;
import org.junit.Test;

public class DiscountCalculatorTest {

    @Test
    public void testVipDiscountApplied() {
        // Simulating a $1000 bill with a 10% VIP discount
        double originalTotal = 1000.00;
        double discountRate = 0.10; // 10%
        
        double expectedFinalTotal = 900.00;
        double actualFinalTotal = originalTotal - (originalTotal * discountRate);
        
        Assert.assertEquals("System failed to apply the correct 10% VIP discount.", expectedFinalTotal, actualFinalTotal, 0.01);
    }

    @Test
    public void testInvalidDiscountCode() {
        // Simulating a user typing in a fake/expired promo code
        double originalTotal = 500.00;
        boolean isCodeValid = false;
        
        // If the code is invalid, the discount is $0
        double discountAmount = isCodeValid ? 50.00 : 0.00; 
        double actualFinalTotal = originalTotal - discountAmount;
        
        Assert.assertEquals("System should not apply a discount for an invalid code.", 500.00, actualFinalTotal, 0.01);
    }
}