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
import QtQuick.Controls 2.2

Rectangle {
    id: root

    property alias outputVoltage: outputVoltageBox.value
    property alias inputVoltage: inputVoltageBox.value
    property alias inputCurrent: inputCurrentBox.value
    property alias outputCurrent: outputCurrentBox.value
    property alias temperature: temperatureBox.value
    property alias efficiency: efficiencyBox.value

    property int boxHeight: 40

    color: "lightgoldenrodyellow"
    radius: 5
    border.color: "white"
    width: 400

    Column {
        id: column1

        width: root.width/2-1
        spacing: 3

        PortStatBox{
            id:inputVoltageBox
            anchors.left:column1.left
            anchors.topMargin: 8
            anchors.right: column1.right
            height:boxHeight
            label: "VOLTAGE IN"
            color:"transparent"
            icon: "../images/icon-voltage.svg"
            valueSize:36
            unitSize:15
            textColor: "#BBB"
        }

        PortStatBox{
            id:inputCurrentBox
            anchors.left:column1.left
            anchors.topMargin: 8
            anchors.right: column1.right
            height:boxHeight
            label: "CURRENT IN"
            unit: "mA"
            color:"transparent"
            icon: "../images/icon-voltage.svg"
            valueSize:36
            unitSize:15
            textColor: "#BBB"
        }

        PortStatBox{
            id:efficiencyBox
            anchors.left:column1.left
            anchors.topMargin: 8
            anchors.right: column1.right
            height:boxHeight
            label: "EFFICIENCY"
            unit:"%"
            color:"transparent"
            icon: "../images/icon-efficiency.svg"
            valueSize:36
            unitSize:15
            textColor: "#BBB"
        }

    }

    Column {
        id: column2
        anchors {
            left: column1.right
            leftMargin: column1.spacing
            verticalCenter: column1.verticalCenter
        }
        spacing: column1.spacing
        width: root.width/2 - 2

        PortStatBox{
            id:outputVoltageBox
            anchors.left:column2.left
            anchors.topMargin: 8
            anchors.right: column2.right
            height:boxHeight
            label: "LED VOLTAGE"
            unit: "V"
            color:"transparent"
            icon: "../images/icon-voltage.svg"
            valueSize:36
            unitSize:15
            textColor: "#BBB"
        }

        PortStatBox{
            id:outputCurrentBox
            anchors.left:column2.left
            anchors.topMargin: 8
            anchors.right: column2.right
            height:boxHeight
            label: "CURRENT OUT"
            unit:"mA"
            color:"transparent"
            icon: "../images/icon-voltage.svg"
            valueSize:36
            unitSize:15
            textColor: "#BBB"
        }

        PortStatBox{
            id:temperatureBox
            anchors.left:column2.left
            anchors.topMargin: 8
            anchors.right: column2.right
            height:boxHeight
            label: "TEMPERATURE"
            unit:"°C"
            color:"transparent"
            icon: "../images/icon-temp.svg"
            valueSize:36
            unitSize:15
            textColor: "#BBB"
        }


    }
}



