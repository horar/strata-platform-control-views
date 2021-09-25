/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.10
import QtQuick.Controls 2.2
import tech.strata.sgwidgets 0.9

Rectangle {
    id: front

    color:backgroundColor
    opacity:1
    radius: 10

    property string pairedDevice
    property var bluetoothPairing: platformInterface.bluetooth_pairing
    property color backgroundColor: "#D1DFFB"

    onBluetoothPairingChanged: {
        console.log("bluetooth pairing changed. New value:", platformInterface.bluetooth_pairing.id);
        if (platformInterface.bluetooth_pairing.value === "paired"){
            pairedDevice = platformInterface.bluetooth_pairing.id
            }
          else
            pairedDevice = "not connected"
    }



    Image {
        id: bluetoothIcon
        height:3*parent.height/4
        fillMode: Image.PreserveAspectFit
        //width:parent.height/4
        mipmap:true
        anchors.top:parent.top
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        source:"../images/icon-bluetooth.svg"

    }

    Text{
        id:connectedDeviceText
        text: front.pairedDevice
        color:"black"
        font.pixelSize: 24
        anchors.left:bluetoothIcon.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        onTextChanged: {
            console.log("bluetooth text changed to",text)
        }
    }
}

