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
    id: back
    width: 200
    height:200
    color:"dimgrey"
    opacity:1
    radius: 10

    signal deviceSelected();

    Component.onCompleted:{
        platformInterface.get_bluetooth_devices.update();
       }


    Text{
        id:deviceName
        text:"available devices:"
        color:"white"
        font.pixelSize: 24
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    SGComboBox{
        id: deviceCombo
        anchors.top: deviceName.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        model:  platformInterface.bluetooth_devices.devices
        boxColor: "silver"

        onActivated:{
            //set the name of the selected device on the other side
            //actually, that will come from a notification
            platformInterface.set_bluetooth_pairing.update(currentText)
            deviceSelected();
        }

    }


}
