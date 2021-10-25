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

    /*
      properties that changes for different platform using same UI
    */
    property bool ecoVisible: false
    property string warningVinLable: "2.5V"
    property string partNumber: "<b> NCV8163/NCP163 </b>"
    property string title: "<b>Low Noise and High PSRR Linear Regulator</b>"
    property bool showDecimal;
    property real maxValue: 3000
    property real stepValue: 300

    function check_class_id ()
    {
        if(class_id === "214") {
            ecoVisible = true
            title =  "<b>Low Noise and High PSRR Linear Regulator</b> "
            partNumber = " <b> NCV8163/NCP163 </b>"
            warningVinLable = "2.25V"
            showDecimal = false
            maxValue = 1500
            stepValue = 150
        }
        else if(class_id === "206") {
            ecoVisible = false
            partNumber =  "<b> NCV8163/NCP163 </b>"
            title =  "<b>Low Noise and High PSRR Linear Regulator</b> "
            warningVinLable = "2.25V"
            showDecimal = false
            maxValue = 1500
            stepValue = 150
        }
        else if(class_id === "210") {
            partNumber = "<b> NCP110 </b>"
            title = "<b> Low Noise and High PSRR Linear Regulator </b>"
            ecoVisible = false
            warningVinLable = "1.1V"
            showDecimal = false
        }
        else if(class_id === "211") {
            ecoVisible = false
            partNumber = "<b> NCP115 </b>"
            title = "<b> High PSRR Linear Regulator </b>"
            warningVinLable = "1.7V"
            showDecimal = false
            maxValue = 1500
            stepValue = 150
        }
        else if(class_id === "212") {
            ecoVisible = false
            partNumber = " <b> NCV8170/NCP170 </b>"
            title = "<b> Low Iq CMOS Linear Regulator </b>"
            warningVinLable = "2.25V"
            showDecimal = false
            maxValue = 1000
            stepValue = 100

        }
        else if(class_id === "217") {
            ecoVisible = true
            partNumber = "<b> NCP171 </b>"
            title = "<b> Low Iq Dual Power Mode Linear Regulator </b>"
            warningVinLable = "1.7V"
            showDecimal = true
            maxValue = 300
            stepValue = 30
        }
        else  {
            console.log("unknown")
        }
    }
}
