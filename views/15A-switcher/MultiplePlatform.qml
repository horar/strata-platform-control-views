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

Item {

    property string class_id
    /*
      properties that changes for different platform using same UI
    */
    property bool modeVisible: false
    property bool holder3231: false
    property var listOfOutputValue;
    property string warningVinLable: "2.5V"
    property string partNumber:  "NCP3235"
    property string title: "<b>High Current Sync Buck Converter</b>"
    property real maxValue: 5
    property real stepValue: 0.5
    property bool classid3235: false


    function check_class_id ()
    {
        if(class_id === "207") {
            modeVisible = true
            holder3231 = false
            partNumber = " <b> NCP3235 </b>"
            listOfOutputValue = [">20A", "17.5A", "10A"]
            title = "<b>High Current Sync Buck Converter</b>"
            maxValue = 60
            stepValue = 6
            classid3235 = true
        }
        if(class_id === "219") {
            modeVisible = false
            holder3231 = false
            partNumber = " <b> NCP3232 </b>"
            listOfOutputValue = [">20A", "17.5A", "10A"]
            title = "<b>High Current Sync Buck Converter</b>"
            maxValue = 60
            stepValue = 6
            classid3235 = true
        }

        if(class_id === "220") {
            modeVisible = false
            holder3231 = false
            partNumber = " <b> NCP3231 </b>"
            listOfOutputValue = [">30A", "27A", "10A"]
            title = "<b>High Current Sync Buck Converter</b>"
            maxValue = 100
            stepValue = 10
            classid3235 = true

        }
    }

}
