/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.0

Timer {
    //    id: demopattern

    function demo_timer(delaytime){
        timer = new Timer()
        timer.interval = delaytime
        timer.repeat = true
        timer.start()

    }
}

/*

    function demo_star1(led_state){

        if (led_state === 1){
            platformInterface.demo_led11_state = true

        } else if (led_state === 2) {
            platformInterface.demo_led12_state = true
            platformInterface.demo_led21_state = true

        } else if (led_state === 3) {
            platformInterface.demo_led13_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led31_state = true

        } else if (led_state === 4) {
            platformInterface.demo_led14_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led32_state = true

        } else if (led_state === 5) {
            platformInterface.demo_led15_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led33_state = true

        } else if (led_state === 6) {
            platformInterface.demo_led16_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led34_state = true

        } else if (led_state === 7) {
            platformInterface.demo_led17_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led35_state = true

        } else if (led_state === 8) {
            platformInterface.demo_led18_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led36_state = true

        } else if (led_state === 9) {
            platformInterface.demo_led19_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led37_state = true

        } else if (led_state === 10) {
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led38_state = true

        } else if (led_state === 11) {
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led39_state = true

        } else if (led_state === 12) {
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led3A_state = true

        } else if (led_state === 13) {
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led3B_state = true

        } else if (led_state === 14) {
            platformInterface.demo_led3C_state = true

        } else {
            led_all_off()
        }
    }

    function demo_star2(led_state){

        if (led_state === 1){
            platformInterface.demo_led11_state = true

        } else if (led_state === 2) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true

        } else if (led_state === 3) {
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led21_state = true

        } else if (led_state === 4) {
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true

        } else if (led_state === 5) {
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led31_state = true

        } else if (led_state === 6) {
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true

        } else if (led_state === 7) {
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true

        } else if (led_state === 8) {
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true

        } else if (led_state === 9) {
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true

        } else if (led_state === 10) {
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true

        } else if (led_state === 11) {
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true

        } else if (led_state === 12) {
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true

        } else if (led_state === 13) {
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true

        } else if (led_state === 14) {
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true

        } else if (led_state === 15) {
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true

        } else if (led_state === 16) {
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 17) {
            platformInterface.demo_led3C_state = true

        } else {
            led_all_off()
        }
    }

    function demo_star3(led_state){

        if (led_state === 1){
            platformInterface.demo_led11_state = true

        } else if (led_state === 2) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true

        } else if (led_state === 3) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true

        } else if (led_state === 4) {
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led21_state = true

        } else if (led_state === 5) {
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true

        } else if (led_state === 6) {
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true

        } else if (led_state === 7) {
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led31_state = true

        } else if (led_state === 8) {
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true

        } else if (led_state === 9) {
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true

        } else if (led_state === 10) {
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true

        } else if (led_state === 11) {
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true

        } else if (led_state === 12) {
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true

        } else if (led_state === 13) {
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true

        } else if (led_state === 14) {
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true

        } else if (led_state === 15) {
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true

        } else if (led_state === 16) {
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true

        } else if (led_state === 17) {
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true

        } else if (led_state === 18) {
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 19) {
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 20) {
            platformInterface.demo_led3C_state = true

        } else {
            led_all_off()
        }
    }

    function demo_star4(led_state){

        if (led_state === 1) {
            platformInterface.demo_led11_state = true

        } else if (led_state === 2) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true

        } else if (led_state === 3) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true

        } else if (led_state === 4) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true

        } else if (led_state === 5) {
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led21_state = true

        } else if (led_state === 6) {
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true

        } else if (led_state === 7) {
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true

        } else if (led_state === 8) {
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true

        } else if (led_state === 9) {
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led31_state = true

        } else if (led_state === 10) {
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true

        } else if (led_state === 11) {
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true

        } else if (led_state === 12) {
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true

        } else if (led_state === 13) {
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true

        } else if (led_state === 14) {
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true

        } else if (led_state === 15) {
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true

        } else if (led_state === 16) {
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true

        } else if (led_state === 17) {
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true

        } else if (led_state === 18) {
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true

        } else if (led_state === 19) {
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true

        } else if (led_state === 20) {
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 21) {
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 22) {
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 23) {
            platformInterface.demo_led3C_state = true

        } else {
            led_all_off()
        }
    }

    function demo_star5(led_state){

        if (led_state === 1) {
            platformInterface.demo_led11_state = true

        } else if (led_state === 2) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true

        } else if (led_state === 3) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true

        } else if (led_state === 4) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true

        } else if (led_state === 5) {
            platformInterface.demo_led11_state = true
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true

        } else if (led_state === 6) {
            platformInterface.demo_led12_state = true
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led21_state = true

        } else if (led_state === 7) {
            platformInterface.demo_led13_state = true
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true

        } else if (led_state === 8) {
            platformInterface.demo_led14_state = true
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true

        } else if (led_state === 9) {
            platformInterface.demo_led15_state = true
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true

        } else if (led_state === 10) {
            platformInterface.demo_led16_state = true
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led21_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true

        } else if (led_state === 11) {
            platformInterface.demo_led17_state = true
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led22_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led31_state = true

        } else if (led_state === 12) {
            platformInterface.demo_led18_state = true
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led23_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true

        } else if (led_state === 13) {
            platformInterface.demo_led19_state = true
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led24_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true

        } else if (led_state === 14) {
            platformInterface.demo_led1A_state = true
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led25_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true

        } else if (led_state === 15) {
            platformInterface.demo_led1B_state = true
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led26_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led31_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true

        } else if (led_state === 16) {
            platformInterface.demo_led1C_state = true
            platformInterface.demo_led27_state = true
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led32_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true

        } else if (led_state === 17) {
            platformInterface.demo_led28_state = true
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led33_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true

        } else if (led_state === 18) {
            platformInterface.demo_led29_state = true
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led34_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true

        } else if (led_state === 19) {
            platformInterface.demo_led2A_state = true
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led35_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true

        }else if (led_state === 20) {
            platformInterface.demo_led2B_state = true
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led36_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true

        } else if (led_state === 21) {
            platformInterface.demo_led2C_state = true
            platformInterface.demo_led37_state = true
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true

        } else if (led_state === 22) {
            platformInterface.demo_led38_state = true
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 23) {
            platformInterface.demo_led39_state = true
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 24) {
            platformInterface.demo_led3A_state = true
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 25) {
            platformInterface.demo_led3B_state = true
            platformInterface.demo_led3C_state = true

        } else if (led_state === 26) {
            platformInterface.demo_led3C_state = true

        } else {
            led_all_off()
        }
    }

    function led_all_off(){
        platformInterface.demo_led11_state = false
        platformInterface.demo_led12_state = false
        platformInterface.demo_led13_state = false
        platformInterface.demo_led14_state = false
        platformInterface.demo_led15_state = false
        platformInterface.demo_led16_state = false
        platformInterface.demo_led17_state = false
        platformInterface.demo_led18_state = false
        platformInterface.demo_led19_state = false
        platformInterface.demo_led1A_state = false
        platformInterface.demo_led1B_state = false
        platformInterface.demo_led1C_state = false
        platformInterface.demo_led21_state = false
        platformInterface.demo_led22_state = false
        platformInterface.demo_led23_state = false
        platformInterface.demo_led24_state = false
        platformInterface.demo_led25_state = false
        platformInterface.demo_led26_state = false
        platformInterface.demo_led27_state = false
        platformInterface.demo_led28_state = false
        platformInterface.demo_led29_state = false
        platformInterface.demo_led2A_state = false
        platformInterface.demo_led2B_state = false
        platformInterface.demo_led2C_state = false
        platformInterface.demo_led31_state = false
        platformInterface.demo_led32_state = false
        platformInterface.demo_led33_state = false
        platformInterface.demo_led34_state = false
        platformInterface.demo_led35_state = false
        platformInterface.demo_led36_state = false
        platformInterface.demo_led37_state = false
        platformInterface.demo_led38_state = false
        platformInterface.demo_led39_state = false
        platformInterface.demo_led3A_state = false
        platformInterface.demo_led3B_state = false
        platformInterface.demo_led3C_state = false
    }

    function led_all_on(){
        platformInterface.demo_led11_state = true
        platformInterface.demo_led12_state = true
        platformInterface.demo_led13_state = true
        platformInterface.demo_led14_state = true
        platformInterface.demo_led15_state = true
        platformInterface.demo_led16_state = true
        platformInterface.demo_led17_state = true
        platformInterface.demo_led18_state = true
        platformInterface.demo_led19_state = true
        platformInterface.demo_led1A_state = true
        platformInterface.demo_led1B_state = true
        platformInterface.demo_led1C_state = true
        platformInterface.demo_led21_state = true
        platformInterface.demo_led22_state = true
        platformInterface.demo_led23_state = true
        platformInterface.demo_led24_state = true
        platformInterface.demo_led25_state = true
        platformInterface.demo_led26_state = true
        platformInterface.demo_led27_state = true
        platformInterface.demo_led28_state = true
        platformInterface.demo_led29_state = true
        platformInterface.demo_led2A_state = true
        platformInterface.demo_led2B_state = true
        platformInterface.demo_led2C_state = true
        platformInterface.demo_led31_state = true
        platformInterface.demo_led32_state = true
        platformInterface.demo_led33_state = true
        platformInterface.demo_led34_state = true
        platformInterface.demo_led35_state = true
        platformInterface.demo_led36_state = true
        platformInterface.demo_led37_state = true
        platformInterface.demo_led38_state = true
        platformInterface.demo_led39_state = true
        platformInterface.demo_led3A_state = true
        platformInterface.demo_led3B_state = true
        platformInterface.demo_led3C_state = true
    }
}
*/
