/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item{

    property string class_id

    property string eeprom_ID: "cce0f32e-ee1e-44aa-81a3-0801a71048ce"
    property string partNumber: "<b> NCP6922C </b>"
    property string title: "<b> 4 channels PMIC Converter </b>"
    property string warningHVVinLable: "5.5V"
    property string warningLVVinLable: "2.5V"
    property string opn: "STR-PWRNCP6922C-R0-GEVK"
    property real minVin: 2.5
    property real nominalVin: 5
    property real vinScale: 10
    property real iinScale: 2.5
    property real voutScale: 5
    property real ioutScale: 2.5
    property real poutScale: 5000
    property real pdissScale: 5500
    property bool showDecimal: true
    property real poutStep: 500
    property real pdissStep: 500
    property bool rst: false
    property bool dio14: true
    property bool jumperDIO14: false
    property bool dio13: true
    property bool jumperDIO13: false
    property bool dio12: false
    property bool jumperDIO12: true
    property bool dio04: false
    property bool jumperDIO04: true
    property bool lowpowerDCDC: true
    property string pdiss: "mW"
    property string current: "mA"
    property real minVout1: 1.08
    property real minVout2: 1.08
    property real minVout3: 2.25
    property real minVout4: 2.25

    function check_class_id ()
    {
        if(class_id === "15411d3f-829f-4b65-b607-13e8dec840aa") {
            eeprom_ID = "15411d3f-829f-4b65-b607-13e8dec840aa"
            title =  "<b> Automotive Buck Boost Controller </b>"
            partNumber = " <b> NCV81599 </b>"
            warningHVVinLable = "32V"
            warningLVVinLable = "4.5V"
            opn = "STR-PWRNCV81599-R0-GEVK"
            minVin = 4.5
            nominalVin = 10
            vinScale = 20
            iinScale = 10
            voutScale = 10
            ioutScale = 10
            poutScale = 50000
            pdissScale = 10000
            showDecimal = true
            poutStep = 5000
            pdissStep = 1000
            rst = false
            dio14 = true
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = false
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = true
            pdiss = "mW"
            current = "A"
            minVout1 = 4.2
            minVout2 = 4.2
            minVout3 = 4.2
            minVout4 = 4.2
        }
        else if(class_id === "1ae9e1e7-a268-4302-8c3a-280f0aa095a5") {
            eeprom_ID = "1ae9e1e7-a268-4302-8c3a-280f0aa095a5"
            partNumber =  "<b> NCV330 </b>"
            title =  "<b> Automotive Low Noise and High PSSR Linear Regul. </b> "
            warningHVVinLable = "5.5V"
            warningLVVinLable = "1.8V"
            opn = "STR-PWRNCV330-R0-GEVK"
            minVin = 1.8
            nominalVin = 5
            vinScale = 10
            iinScale = 5
            voutScale = 10
            ioutScale = 5
            poutScale = 15000
            pdissScale = 15000
            showDecimal = true
            poutStep = 1000
            pdissStep = 1000
            rst = false
            dio14 = false
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = false
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = false
            pdiss = "mW"
            current = "A"
        }
        else if(class_id === "3ef8bbc6-92ff-4c98-b9ae-ca7e7c47d180") {
                  eeprom_ID = "3ef8bbc6-92ff-4c98-b9ae-ca7e7c47d180"
                  partNumber = "<b> NCV6357 </b>"
                  title = "<b> Automotive AOT Buck Converter </b>"
                  warningHVVinLable = "5.5V"
                  warningLVVinLable = "2.5V"
                  opn = "STR-PWRNCV6357-R0-GEVK"
                  minVin = 2.5
                  nominalVin = 5
                  vinScale = 10
                  iinScale = 10
                  voutScale = 10
                  ioutScale = 10
                  poutScale = 20000
                  pdissScale = 5000
                  showDecimal = true
                  poutStep = 2000
                  pdissStep = 500
                  rst = false
                  dio14 = false
                  jumperDIO14 = false
                  dio13 = false
                  jumperDIO13 = false
                  dio12 = true
                  jumperDIO12 = false
                  dio04 = true
                  jumperDIO04 = false
                  lowpowerDCDC = false
                  pdiss = "mW"
                  current = "A"
        }
        else if(class_id === "3ea08e05-0bcd-4a4a-86ec-79a1ca9750cd") {
            eeprom_ID = "3ea08e05-0bcd-4a4a-86ec-79a1ca9750cd"
            partNumber = "<b> NCV91300 </b>"
            title = "<b> Automotive PWM Buck Converter </b>"
            warningHVVinLable = "5.5V"
            warningLVVinLable = "1.9V"
            opn = "STR-PWRNCV91300-R0-GEVK"
            minVin = 1.9
            nominalVin = 5
            vinScale = 10
            iinScale = 5
            voutScale = 5
            ioutScale = 5
            poutScale = 10000
            pdissScale = 10000
            showDecimal = true
            poutStep = 500
            pdissStep = 500
            rst = false
            dio14 = true
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = true
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = false
            pdiss = "mW"
            current = "A"
            minVout1 = 1.023
            minVout2 = 1.023
            minVout3 = 1.023
            minVout4 = 1.023
        }
        else if(class_id === "abd65a0b-3229-44a4-a97c-38ea3c24f990") {
            eeprom_ID = "abd65a0b-3229-44a4-a97c-38ea3c24f990"
            partNumber = " <b> NCV890430 </b>"
            title = "<b> Automotive Buck Regulator </b>"
            warningHVVinLable = "37V"
            warningLVVinLable = "3.5V"
            opn = "STR-PWRNCV890430-R0-GEVK"
            minVin = 3.5
            nominalVin = 18
            vinScale = 20
            iinScale = 1.5
            voutScale = 10
            ioutScale = 1.5
            poutScale = 10000
            pdissScale = 5000
            showDecimal = true
            poutStep = 1000
            pdissStep = 500
            rst = false
            dio14 = true
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = true
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = true
            pdiss = "mW"
            current = "mA"
            minVout1 = 3.069
            minVout2 = 3.069
            minVout3 = 3.069
            minVout4 = 3.069
        }
        else if(class_id === "266f22e5-dc05-4819-b565-e5fb8035984e") {
            eeprom_ID = "266f22e5-dc05-4819-b565-e5fb8035984e"
            partNumber = "<b> NCV48920 </b>"
            title = "<b> Automotive Charge Pump Buck Boost Converter </b>"
            warningHVVinLable = "40V"
            warningLVVinLable = "3V"
            opn = "STR-PWRNCV48920-R0-GEVK"
            minVin = 3
            nominalVin = 18
            vinScale = 20
            iinScale = 1.5
            voutScale = 10
            ioutScale = 1.5
            poutScale = 10000
            pdissScale = 10000
            showDecimal = true
            poutStep = 1000
            pdissStep = 1000
            rst = false
            dio14 = true
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = false
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = true
            pdiss = "mW"
            current = "mA"
            minVout1 = 4.625
            minVout2 = 4.625
            minVout3 = 4.625
            minVout4 = 4.625
        }
        else if(class_id === "b519cdcb-5068-4483-b88e-155813fae915") {
            eeprom_ID = "b519cdcb-5068-4483-b88e-155813fae915"
            partNumber = "<b> NCV8163 </b>"
            title = "<b> Automotive Linear Regulator </b>"
            warningHVVinLable = "5.5V"
            warningLVVinLable = "1.9V"
            opn = "STR-PWRNCV8163-R0-GEVK"
            minVin = 1.9
            nominalVin = 5
            vinScale = 10
            iinScale = 0.5
            voutScale = 10
            ioutScale = 0.5
            poutScale = 5000
            pdissScale = 2000
            showDecimal = true
            poutStep = 500
            pdissStep = 250
            rst = false
            dio14 = false
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = false
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = true
            pdiss = "mW"
            current = "mA"
        }
        else if(class_id === "26ebc2ba-9bab-4bdd-97b6-09b5b8cbdf9e") {
            eeprom_ID = "26ebc2ba-9bab-4bdd-97b6-09b5b8cbdf9e"
            partNumber = "<b> NCV6323 </b>"
            title = "<b> Automotive Buck Converter </b>"
            warningHVVinLable = "5.5V"
            warningLVVinLable = "2.5V"
            opn = "STR-PWRNCV6323-R0-GEVK"
            minVin = 2.5
            nominalVin = 5
            vinScale = 10
            iinScale = 2
            voutScale = 10
            ioutScale = 2
            poutScale = 5000
            pdissScale = 1000
            showDecimal = true
            poutStep = 500
            pdissStep = 100
            rst = false
            dio14 = false
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = false
            dio12 = true
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = false
            lowpowerDCDC = false
            pdiss = "mW"
            current = "A"
        }
        else if(class_id === "cce0f32e-ee1e-44aa-81a3-0801a71048ce") {
            eeprom_ID = "cce0f32e-ee1e-44aa-81a3-0801a71048ce"
            partNumber = "<b> NCP6922C </b>"
            title = "<b> 4 channels PMIC Converter </b>"
            warningHVVinLable = "5.5V"
            warningLVVinLable = "2.5V"
            opn = "STR-PWRNCP6922C-R0-GEVK"
            minVin = 2.5
            nominalVin = 5
            vinScale = 10
            iinScale = 2.5
            voutScale = 5
            ioutScale = 2.5
            poutScale = 5000
            pdissScale = 5500
            showDecimal = true
            poutStep = 500
            pdissStep = 500
            rst = false
            dio14 = true
            jumperDIO14 = false
            dio13 = true
            jumperDIO13 = false
            dio12 = false
            jumperDIO12 = true
            dio04 = false
            jumperDIO04 = true
            lowpowerDCDC = true
            pdiss = "mW"
            current = "mA"
            minVout1 = 1.08
            minVout2 = 1.08
            minVout3 = 2.25
            minVout4 = 2.25
        }
        else if(class_id === "2286e1e0-4035-46b9-b197-4d729653c101") {
            eeprom_ID = "2286e1e0-4035-46b9-b197-4d729653c101"
            partNumber = "<b> NCV896530 </b>"
            title = "<b> Automotive Dual Output Buck Converter </b>"
            warningHVVinLable = "5.5V"
            warningLVVinLable = "2.7V"
            opn = "STR-PWRNCV896530-R0-GEVK"
            minVin = 2.7
            nominalVin = 5
            vinScale = 10
            iinScale = 2
            voutScale = 5
            ioutScale = 2
            poutScale = 10000
            pdissScale = 1000
            showDecimal = true
            poutStep = 1000
            pdissStep = 100
            rst = false
            dio14 = true
            jumperDIO14 = false
            dio13 = false
            jumperDIO13 = true
            dio12 = false
            jumperDIO12 = false
            dio04 = false
            jumperDIO04 = true
            lowpowerDCDC = true
            pdiss = "mW"
            current = "mA"
            minVout1 = 3.069
            minVout2 = 3.069
            minVout3 = 3.069
            minVout4 = 3.069
        }

        else  {
            console.log("unknown")
        }
    }
}
