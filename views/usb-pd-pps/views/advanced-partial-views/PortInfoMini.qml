/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import tech.strata.sgwidgets 1.0
import tech.strata.sgwidgets 0.9 as SGWidgets09

Item {
    id: root

    property bool portConnected: false
    property int portNum: 1
    property color portColor: "#2eb457"

    property alias negotiatedVoltage : theNegotiatedVoltage.value
    property alias maxPower: theMaxWattage.value
    property alias inputPower: theInputPower.value
    property alias outputVoltage: theOutputVoltage.value
    property alias portTemperature: thePortTemperature.value
    property alias outputPower: theOutputPower.value
    property alias portEfficency: thePortEfficency.value

    implicitWidth: 175

    Rectangle {
        id: portNumberContainer
        width: parent.width
        height: portNumber.height + 10
        color: "#f4f4f4"

        Text {
            id: portNumber
            text: "<b>PORT " + root.portNum + ":</b>"
            font {
                pixelSize: 15
            }
            color: portConnected ? "#555" : "#aaa"
            anchors {
                top: portNumberContainer.top
                topMargin: 5
                left: portNumberContainer.left
                leftMargin: 5
            }
        }

        SGDivider {
            width: parent.width
            color: "#999"
            anchors {
                bottom: portNumberContainer.bottom
            }
            z:0
        }

        Canvas {
            anchors {
                fill: parent
            }
            visible: portConnected
            contextType: "2d"

            onPaint: {
                context.reset();
                context.lineWidth = 1
                context.fillStyle = portColor;

                context.beginPath();
                context.moveTo(width * 0.75, 0);
                context.lineTo(width, 0);
                context.lineTo(width, height);
                context.lineTo(width * 0.75 - height, height);
                context.closePath();
                context.fill();
            }
        }
    }

    Item {
        id: connectionContainer
        visible: !root.portConnected

        anchors {
            top: portNumberContainer.bottom
            topMargin: 8
            bottom: root.bottom
            right: root.right
            left: root.left
        }

        Image {
            id: connectionIcon
            source: "../images/icon-usb-disconnected.svg"
            height: root.height * 0.5
            width: height * 0.6925
            anchors {
                centerIn: parent
                verticalCenterOffset: -connectionText.font.pixelSize / 2

            }
        }

        Text {
            id: connectionText
            color: "#ccc"
            text: "<b>Port Disconnected</b>"
            anchors {
                top: connectionIcon.bottom
                topMargin: 5
                horizontalCenter: connectionIcon.horizontalCenter
            }
        }
    }

    Column {
        id: column1
        visible: root.portConnected
        width: root.width / 2 - 2
        spacing: 2
        anchors {
            top: portNumberContainer.bottom
            topMargin: 8
        }

        property real sbHeight: 50
        property real sbValueSize: 20
        property real sbLabelSize: 9
        property real bottomMargin: 4

        PortStatBoxMini {
            id: theNegotiatedVoltage
            label: "PROFILE"
            value: ""
            icon: "../images/icon-voltage.svg"
            height: column1.sbHeight
            valueSize: column1.sbValueSize
            labelSize: column1.sbLabelSize
            portColor: root.portColor
            unit: "V"
            bottomMargin: column1.bottomMargin

        }

        PortStatBoxMini {
            id: theMaxWattage
            label: "PD CONTRACT"
            value: ""
            icon: "../images/icon-max.svg"
            height: column1.sbHeight
            valueSize: column1.sbValueSize
            labelSize: column1.sbLabelSize
            portColor: root.portColor
            unit: "W"
            bottomMargin: column1.bottomMargin
        }

        PortStatBoxMini {
            id:theInputPower
            label: "POWER IN"
            value: ""
            icon: "../images/icon-voltage.svg"
            height: column1.sbHeight
            valueSize: column1.sbValueSize
            labelSize: column1.sbLabelSize
            portColor: root.portColor
            unit: "W"
            bottomMargin: column1.bottomMargin
        }
    }

    Column {
        id: column2
        visible: root.portConnected
        width: root.width / 2 - 2
        spacing: 2
        anchors {
            left: column1.right
            leftMargin: 2
            top: column1.top
        }

        PortStatBoxMini {
            id:theOutputVoltage
            label: "VOLTAGE OUT"
            value: ""
            icon: "../images/icon-voltage.svg"
            height: column1.sbHeight
            valueSize: column1.sbValueSize
            labelSize: column1.sbLabelSize
            portColor: root.portColor
            unit: "V"
            bottomMargin: column1.bottomMargin
        }

        PortStatBoxMini {
            id:thePortTemperature
            label: "TEMPERATURE"
            value: ""
            icon: "../images/icon-temp.svg"
            height: column1.sbHeight
            valueSize: column1.sbValueSize
            labelSize: column1.sbLabelSize
            portColor: root.portColor
            unit: "°C"
            bottomMargin: column1.bottomMargin
        }

        PortStatBoxMini {
            id:theOutputPower
            label: "POWER OUT"
            value: ""
            icon: "../images/icon-voltage.svg"
            height: column1.sbHeight
            valueSize: column1.sbValueSize
            labelSize: column1.sbLabelSize
            portColor: root.portColor
            unit: "W"
            bottomMargin: column1.bottomMargin
        }
    }

    PortStatBoxMini {
        id:thePortEfficency
        label: "EFFICIENCY"
        visible: root.portConnected
        value: ""
        icon: "../images/icon-efficiency.svg"
        height: column1.sbHeight
        width: column1.width
        valueSize: column1.sbValueSize
        labelSize: column1.sbLabelSize
        portColor: root.portColor
        unit: "%"
        bottomMargin: column1.bottomMargin
        anchors {
            top: column1.bottom
            topMargin: 2
            horizontalCenter: column1.right
        }
    }
}
