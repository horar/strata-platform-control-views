/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Controls 2.2
import tech.strata.sgwidgets 0.9

Rectangle {
    id: root
    width: 200
    height:200
    color:"dimgray"
    opacity:1
    radius: 10

    property var wirelessStatus: platformInterface.wifi_status

    onWirelessStatusChanged: {
        if (platformInterface.wifi_status.value === "connected"){
            deviceName = platformInterface.wifi_status.ssid;
        }
        else
            deviceName = "not connected"
    }

    property var deviceName: "not connected"


    Image {
        id: bluetoothIcon
        height:7*parent.height/16
        fillMode: Image.PreserveAspectFit
        mipmap:true
        anchors.centerIn: parent
        source:"../images/icon-wireless.svg"
    }

    Text{
        id:networkName
        text:deviceName
        color:"white"
        font.pixelSize: 24
        anchors.top:bluetoothIcon.bottom
        anchors.topMargin:20
        anchors.horizontalCenter: parent.horizontalCenter
    }

}
