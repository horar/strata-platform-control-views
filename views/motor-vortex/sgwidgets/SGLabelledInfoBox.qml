/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Layouts 1.3

Rectangle {
    id: root

    property string label: ""
    property bool labelLeft: true
    property string info: ""
    property real infoBoxWidth: 50
    property color infoBoxColor: "#eeeeee"
    property color infoBoxBorderColor: "#cccccc"
    property real infoBoxBorderWidth: 1


    implicitHeight: labelLeft ? infoContainer.height : labelText.height + infoContainer.height + infoContainer.anchors.topMargin
    implicitWidth: labelLeft ? infoBoxWidth + labelText.width + infoContainer.anchors.leftMargin : Math.max(infoBoxWidth, labelText.width)

    Text {
        id: labelText
        text: label
        width: contentWidth
        height: root.labelLeft ? infoContainer.height : contentHeight
        topPadding: root.label === "" ? 0 : root.labelLeft ? (infoContainer.height-contentHeight)/2 : 0
        bottomPadding: topPadding
    }

    Rectangle {
        id: infoContainer
        height: 30
        width: root.infoBoxWidth
        color: root.infoBoxColor
        border {
            color: root.infoBoxBorderColor
            width: root.infoBoxBorderWidth
        }
        anchors {
            left: root.labelLeft ? labelText.right : labelText.left
            top: root.labelLeft ? labelText.top : labelText.bottom
            leftMargin: root.label === "" ? 0 : root.labelLeft ? 10 : 0
            topMargin: root.label === "" ? 0 : root.labelLeft ? 0 : 5
        }
        clip: true

        TextInput {
            id: infoText
            padding: 10
            anchors {
                right: infoContainer.right
                verticalCenter: infoContainer.verticalCenter
            }
            text: info
            selectByMouse: true
            readOnly: true
            font {
                pixelSize: 12
                family: "Courier" // Monospaced font for better text width uniformity
            }
        }
    }
}
