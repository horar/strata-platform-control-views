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

RadioButton {
    id: root
    property color textColor: masterTextColor
    property color radioColor: masterRadioColor
    text: "Radio Button"
    implicitWidth: buttonText.implicitWidth + buttonText.anchors.leftMargin + indicator.width
    implicitHeight: 26
    contentItem: buttonText

    Text {
        id: buttonText
        anchors {
            left: root.indicator.right
            leftMargin: 10
        }
        text: root.text
        font.bold: true
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    indicator: Rectangle {
        implicitWidth: 26
        implicitHeight: 26
        y: root.height / 2 - height / 2
        radius: 13
        color: "transparent"
        opacity: enabled ? 1.0 : 0.3
        border.color: root.down ? radioColor : radioColor

        Rectangle {
            implicitWidth: 14
            implicitHeight: 14
            x: 6
            y: 6
            radius: 7
            opacity: enabled ? 1.0 : 0.3
            color: root.down ? radioColor : radioColor
            visible: root.checked
        }
    }
}

