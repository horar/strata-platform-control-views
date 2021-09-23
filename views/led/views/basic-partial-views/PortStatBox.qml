/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9

Rectangle {
    id: root
    height: 49
    width: parent.width
    clip: true
    color: "#f4f4f4"

    property string label: "VOLTAGE"
    property string value: "20"
    property string unit: "V"
    property string icon: "../images/icon-voltage.svg"
    property real labelSize: 9
    property real valueSize: 22
    property real unitSize: 12
    property real bottomMargin: 0
    property color textColor: "#555"
    property color portColor: "#2eb457"



    Rectangle{
        color:"#555"
        anchors.left:iconImage.left
        anchors.leftMargin: 1
        anchors.top:iconImage.top
        anchors.topMargin: 1
        anchors.right:iconImage.right
        anchors.rightMargin:1
        anchors.bottom:iconImage.bottom
        anchors.bottomMargin: 1
        radius:height/2
    }

    Image {
        id: iconImage
        source: root.icon
        opacity: .5
        height: root.height * 0.9
        width: height
        anchors {
            verticalCenter: root.verticalCenter
            right: root.right
            rightMargin: root.height * 0.05
        }
        mipmap: true
    }

    Item {
        id: labelBar
        width: parent.width
        height: labelText.height + 4

        Text {
            id: labelText
            color: "#777"
            text: "<b>" + root.label + "</b>"
            anchors {
                top: labelBar.top
                topMargin: 2
                left: labelBar.left
                leftMargin: 3
            }
            font {
                pixelSize: root.labelSize
            }
        }

        Rectangle {
            id: underline
            color: "#ccc"
            height: 1
            width: labelText.width + 6
            anchors {
                bottom: labelBar.bottom
            }
        }
    }

    Text {
        id: valueText
        color: textColor
        text: "<b>" + root.value + "</b>"
        anchors {
            bottom: root.bottom
            bottomMargin: root.bottomMargin
            left: root.left
            leftMargin: 5
        }
        font {
            pixelSize: root.valueSize
        }
    }

    Text {
        id: unitText
        color: "#aaa"
        text: root.unit
        anchors {
            bottom: valueText.bottom
            bottomMargin: 2
            left: valueText.right
            leftMargin: 5
        }
        font {
            pixelSize: root.unitSize
        }
    }
}
