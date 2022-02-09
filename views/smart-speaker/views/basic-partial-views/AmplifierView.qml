/*
 * Copyright (c) 2018-2022 onsemi.
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

    property color backgroundColor: "#D1DFFB"
    property color accentColor:"#86724C"

    Image {
        id: speakerIcon
        height:3*parent.height/4
        fillMode: Image.PreserveAspectFit
        //width:parent.height/4
        mipmap:true
        anchors.top:parent.top
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        source:"../images/speaker-icon.svg"

    }



    Text{
        id:amplifierText
        font.pixelSize: 15
        anchors.left:amplifierModelText.left
        anchors.bottom: amplifierModelText.top
        text:"amplifier:"
        color: accentColor
    }
    Text{
        id:amplifierModelText
        font.pixelSize: 24
        anchors.left:speakerIcon.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        text:"ABC123"
        color: "black"
    }
}
