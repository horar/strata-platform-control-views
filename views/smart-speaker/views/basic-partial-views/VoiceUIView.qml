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
import tech.strata.sgwidgets 1.0

Rectangle {
    id: front
    color:backgroundColor
    opacity:1
    radius: 10

    property color backgroundColor: "#D1DFFB"

    SGStatusLight{
        id:wakeRecognizedLight
        anchors.left:parent.left
        anchors.leftMargin: 10
        anchors.top:parent.top
        anchors.topMargin: 10
        height:25
        flatStyle: true

    }

    Text{
        id:amplifierText
        font.pixelSize: 24
        anchors.left:wakeRecognizedLight.right
        anchors.leftMargin: -20
        anchors.verticalCenter: wakeRecognizedLight.verticalCenter
        text:"Alexa"
        color: "black"
    }


    Text{
        id:lastCommandLabel
        font.pixelSize: 24
        anchors.left:amplifierText.left
        anchors.leftMargin: 0
        anchors.top: wakeRecognizedLight.bottom
        text:"Last voice command:"
        color: "black"
    }

    Text{
        id:lastCommandText
        font.pixelSize: 24
        anchors.left:lastCommandLabel.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lastCommandLabel.verticalCenter
        text:"Volume up"
        color: "black"
    }
}
