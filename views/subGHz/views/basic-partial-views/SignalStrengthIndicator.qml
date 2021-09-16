/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: root
    width: root.height
    color:"transparent"

    property string sensorNumber:"0x001"
    property int signalStrength:platformInterface.receive_notification.rssi
    property int numberOfBars
    property var barWidth: root.width/5

    onSignalStrengthChanged:{
        //console.log("new rssi value,",signalStrength,"sensor",sensorNumber);
        if (platformInterface.receive_notification.sensor_id === sensorNumber){
            //console.log("new rssi value,",signalStrength,"for channel",sensorNumber);
            if (signalStrength >= -80)
                numberOfBars = 4;
            else if (signalStrength > -100)
                numberOfBars = 3;
            else if (signalStrength > -110)
                numberOfBars = 2;
            else
                numberOfBars = 1;
        }
        else{
            //console.log("sensor_id",platformInterface.receive_notification.sensor_id,"does not match",sensorNumber);
        }
    }

    Rectangle {
        id: bar1
        height: root.height/4
        width: barWidth

        anchors {
            left: root.left
            bottom: root.bottom
        }

        color: (numberOfBars >=1) ? "yellow" : "black"
    }

    Rectangle {
        id: bar2
        height: root.height/2
        width: barWidth

        anchors {
            left: bar1.right
            leftMargin: 5
            bottom: root.bottom
        }

        color: (numberOfBars >=2) ? "yellow" : "black"
    }

    Rectangle {
        id: bar3
        height: .75*root.height
        width: barWidth

        anchors {
            left: bar2.right
            leftMargin: 5
            bottom: root.bottom
        }

        color: (numberOfBars >=3) ? "yellow" : "black"
    }
    Rectangle {
        id: bar4
        height: root.height
        width: barWidth

        anchors {
            left: bar3.right
            leftMargin: 5
            bottom: root.bottom
        }

        color: (numberOfBars >=4) ? "yellow" : "black"
    }
}
