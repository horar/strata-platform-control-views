/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtGraphicalEffects 1.0


Item {
    id: root
    property string status: "off"
    property string label: ""
    property bool labelLeft: true
    property real lightSize : 25
    property color textColor : "black"
    property real fontSize: 10
    implicitHeight: labelLeft ? Math.max(labelText.height, lightSize) : labelText.height + lightSize + statusLight.anchors.topMargin
    implicitWidth: labelLeft ? labelText.width + lightSize + statusLight.anchors.leftMargin : Math.max(labelText.width, lightSize)
    Text {
        id: labelText
        text: root.label
        width: contentWidth
        color: root.textColor
        font.pixelSize: fontSize
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
    }

    Image {
        id: statusLight

        anchors {
            left: root.labelLeft ? labelText.right : labelText.width > root.lightSize ? undefined : labelText.left
            leftMargin: root.label === "" ? 0 : root.labelLeft ? 8 : 0
            verticalCenter: labelText.verticalCenter
        }
        width: root.lightSize
        height: root.lightSize
        source: {
            switch(root.status) {
            case "green":
                "./images/greenStatusLight.svg"
                break;
            case "red":
                "./images/redStatusLight.svg"
                break;
            case "yellow":
                "./images/yellowStatusLight.svg"
                break;
            case "orange":
                "./images/orangeStatusLight.svg"
                break;
            case "off":
                "./images/offStatusLight.svg"
                break;
            default:
                "./images/offStatusLight.svg"
            }
        }
        mipmap: true
    }
}
