/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.0

Item{

    property string class_id
    property string eeprom_ID: "d4937f24-219a-4648-a711-2f6e902b6f1c"
    property string partNumber:"<b> FD6000/A </b>"
    property string title: "<b> DCX-LLC demoboard </b>"
    property string warningHVVinLable: "70V"
    property string warningLVVinLable: "30V"
    property string opn: "STR-PWRFD6000-R0-GEVK"
    property var minVin: 30
    property var nominalVin: 60
    property var vinScale: 100
    property var iinScale: 20
    property var voutScale: 20
    property var ioutScale: 100
    property var poutScale: 1000
    property var pdissScale: 500
    property var ctempScale: 150

    property bool showDecimal: true
    property var poutStep: 100
    property var pdissStep: 50
    property bool dio12: true
    property bool lowpowerDCDC: true
    property string pdiss: "W"
    property string current: "A"

    function check_class_id ()
    {

        if(class_id === "d4937f24-219a-4648-a711-2f6e902b6f1c") {
            eeprom_ID = "d4937f24-219a-4648-a711-2f6e902b6f1c"
            partNumber = "<b> FD6000/A </b>"
            title = "<b> DCX-LLC demoboard </b>"
            warningHVVinLable = "70V"
            warningLVVinLable = "30V"
            opn = "STR-PWRFD6000-R0-GEVK"
            minVin = 30
            nominalVin = 60
            vinScale = 100
            iinScale = 20
            voutScale = 20
            ioutScale = 100
            poutScale = 1500
            pdissScale = 500
            ctempScale = 150
            showDecimal = true
            poutStep = 100
            pdissStep = 50
            dio12 = true
            lowpowerDCDC = true
            pdiss = "W"
            current = "A"
        }

        else if(class_id === "057ec75e-e48f-42db-bea9-3d191ed8a736") {
            eeprom_ID = "d4937f24-219a-4648-a711-2f6e902b6f1c"
            partNumber = "<b> FD350X </b>"
            title = "<b> 48V/12V Full-Bridge demoboard </b>"
            warningHVVinLable = "70V"
            warningLVVinLable = "30V"
            opn = "STR-PWRFD350X-R0-GEVK"
            minVin = 30
            nominalVin = 60
            vinScale = 100
            iinScale = 20
            voutScale = 20
            ioutScale = 100
            poutScale = 1500
            pdissScale = 500
            showDecimal = true
            poutStep = 100
            pdissStep = 50
            dio12 = true
            lowpowerDCDC = true
            pdiss = "W"
            current = "A"
        }

        else  {
            console.log("unknown")
        }
    }
}
