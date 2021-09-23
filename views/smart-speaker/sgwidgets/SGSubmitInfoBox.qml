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

Rectangle {
    id: root

    signal applied(string value)

    property alias label: labelText.text
    property bool labelLeft: true
    property alias value: infoText.text
    property alias infoBoxWidth: infoContainer.width
    property alias infoBoxHeight: infoContainer.height
    property color textColor: "#000"
    property color infoBoxColor: infoText.readOnly ? "#eee" : "transparent"
    property color infoBoxBorderColor: "#cccccc"
    property real infoBoxBorderWidth: 1
    property bool realNumberValidation: false
    property alias showButton: applyButton.visible
    property alias buttonText: applyButton.text
    property alias overrideLabelWidth: labelText.width
    property alias readOnly: infoText.readOnly
    property alias unit: unit.text
    property alias textInput: infoText
    property real floatValue: { return parseFloat(infoText.text) }
    property int intValue: { return parseInt(infoText.text) }
    property alias placeholderText: placeholder.text
    property bool leftJustify: false

    implicitHeight: labelLeft ? inputButtonContainer.height : labelText.height + inputButtonContainer.height + inputButtonContainer.anchors.topMargin
    implicitWidth: labelLeft ? labelText.width + inputButtonContainer.width + inputButtonContainer.anchors.leftMargin :
                               Math.max(inputButtonContainer.width, labelText.width)
    color: "transparent"

    Text {
        id: labelText
        text: ""
        width: contentWidth
        height: root.label === "" ? 0 : root.labelLeft ? infoContainer.height : contentHeight
        topPadding: root.label === "" ? 0 : root.labelLeft ? (Math.max(infoContainer.height, applyButton.height) - contentHeight) / 2 : 0
        bottomPadding: topPadding
        color: root.textColor
        opacity: root.enabled ? 1 : 0.5
        horizontalAlignment: Text.AlignRight
        visible: text !== ""
    }

    Rectangle {
        id: inputButtonContainer
        width: root.showButton ? infoContainer.width + applyButton.width + applyButton.anchors.leftMargin : infoContainer.width
        height: root.showButton ? Math.max(infoContainer.height, applyButton.height) : infoContainer.height
        color: "transparent"
        anchors {
            left: root.labelLeft ? labelText.right : labelText.left
            top: root.labelLeft ? labelText.top : labelText.bottom
            leftMargin: root.label === "" ? 0 : root.labelLeft ? 10 : 0
            topMargin: root.label === "" ? 0 : root.labelLeft ? 0 : 5
        }

        Rectangle {
            id: infoContainer
            height: 25
            width: 60
            color: infoBoxColor
            radius: 2
            border {
                color: infoBoxBorderColor
                width: infoBoxBorderWidth
            }
            anchors {
                left: inputButtonContainer.left
                verticalCenter: inputButtonContainer.verticalCenter
            }
            clip: true

            TextInput {
                id: infoText
                padding: 5
                anchors {
                    right: infoContainer.right
                    verticalCenter: infoContainer.verticalCenter
                    left: infoContainer.left
                }
                text: ""
                selectByMouse: true
                readOnly: false
                font {
                  family: "Courier" // Monospaced font for better text width uniformity
                  pixelSize: (Qt.platform.os === "osx") ? 12 : 10
                }
                horizontalAlignment: leftJustify ? TextInput.AlignLeft : TextInput.AlignRight
                validator: realNumberValidation ? realNumberValidator : null
                onAccepted: root.applied(infoText.text)
                enabled: root.enabled
                color: root.textColor
                opacity: root.enabled ? 1 : 0.5
                onEditingFinished: { if (!root.showButton) { root.applied(infoText.text) } }

                RegExpValidator {
                    id: realNumberValidator
                    regExp: /[-+]?([0-9]*\.[0-9]+|[0-9]+)/
                }

                MouseArea {
                    visible: !infoText.readOnly
                    anchors {
                        fill: infoText
                    }
                    cursorShape: Qt.IBeamCursor
                    acceptedButtons: Qt.NoButton
                }

                Text {
                    id: placeholder
                    text: ""
                    color: "#bbb"
                    visible: infoText.text === ""
                    anchors {
                        verticalCenter: infoText.verticalCenter
                        right: infoText.right
                        rightMargin: 5
                        left: infoText.left
                        leftMargin: 5
                    }
                    horizontalAlignment: leftJustify ? TextInput.AlignLeft : TextInput.AlignRight
                }
            }
        }

        Text {
            id: unit
            text: ""
            anchors {
                left: infoContainer.right
                leftMargin: text === "" ? 0 : 5
                verticalCenter: infoContainer.verticalCenter
            }
            visible: text !== ""
        }

        Button {
            id: applyButton
            visible: false
            text: "Submit"
            anchors {
                left: unit.right
                leftMargin: unit.text === "" ? 10 : 20
                verticalCenter: infoContainer.verticalCenter
            }
            onClicked: root.applied(infoText.text)
            enabled: root.enabled
            height: visible ? 40 : 0
        }
    }
}
