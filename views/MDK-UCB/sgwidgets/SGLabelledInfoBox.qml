/*
 * Copyright (c) 2018-2021 onsemi.
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
    property real infoBoxHeight: 50
    property color infoBoxColor: "#eeeeee"
    property color infoBoxBorderColor: "#cccccc"
    property real infoBoxBorderWidth: 1
    property string unit: "RPM"
    property int fontSize: 10
    property int unitSize: 100
    implicitHeight: labelLeft ? infoContainer.height : labelText.height + infoContainer.height+ infoContainer.anchors.topMargin + 40
    implicitWidth: labelLeft ? infoBoxWidth + labelText.width + unitText.width : Math.max(infoBoxWidth, labelText.width )
    Text {
        id: labelText
        text: label
        width: contentWidth
        height: root.labelLeft ? infoContainer.height : contentHeight
        font.pixelSize: fontSize

        topPadding: root.label === "" ? 0 : root.labelLeft ? (infoContainer.height-contentHeight)/2 : 0
        bottomPadding: topPadding
        font.bold: true
    }
    FontLoader {
        id: digital
        source: "fonts/digitalseven.ttf"
    }

    Rectangle {
        id: infoContainer
        height: infoBoxHeight
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
            text: " " + info
            anchors {
                right: infoContainer.right
                verticalCenter: infoContainer.verticalCenter
            }

            selectByMouse: true
            readOnly: true
            font.pixelSize:infoContainer.height// Scale the gauge font based on what the largest or smallest number that might be displayed
            renderType: Text.NativeRendering
            font.family: digital.name

        }

    }
    Text {
        id: unitText
        text: "" + unit
        width: contentWidth + 20
        height: contentHeight
        font.pixelSize: fontSize

        anchors {
            left : infoContainer.right
            leftMargin: 6
        }
        font.bold: true
    }

}
