/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
//import "../../sgwidgets"
import tech.strata.sgwidgets 1.0
import tech.strata.sgwidgets 0.9 as SGWidgets09

Item {
    id: root

    property bool portConnected: false
    property color portColor: "#30a2db"

    property alias advertisedVoltage: advertisedVoltageBox.value
    property alias pdContract: pdContractBox.value
    property alias inputPower: inputPowerBox.value
    property alias outputPower: outputPowerBox.value
    property alias outputVoltage: outputVoltageBox.value
    property alias portTemperature: portTemperatureBox.value
    //property alias efficency: efficencyBox.value

    property var deviceConnected: platformInterface.usb_pd_port_connect.connection_state
    property string portName: "USB_C_port_" + portNumber

    onDeviceConnectedChanged: {

        if (platformInterface.usb_pd_port_connect.port == portNumber){
            if (platformInterface.usb_pd_port_connect.connection_state === "connected"){
                root.portConnected = true;
            }
            else if (platformInterface.usb_pd_port_connect.connection_state === "disconnected"){
                root.portConnected = false;
            }

        }
    }

    width: 400

    Item {
        id: margins
        anchors {
            fill: parent
            topMargin: 15
            leftMargin: 15
            rightMargin: 15
            bottomMargin: 15
        }

        Item {
            id: statsContainer
            anchors {
                top: margins.top
                bottom: margins.bottom
                right: margins.right
                left: margins.left
            }

            Text {
                id: portTitle
                text: "<b>Port " + portNumber + "</b>"
                font {
                    pixelSize: 25
                }
                anchors {
                    verticalCenter: statsContainer.verticalCenter
                }
                color: root.portConnected ? "black" : "#bbb"
            }

            Rectangle {
                color: portColor
                visible: portConnected
                anchors {
                    top: portTitle.bottom
                }
                height: 10
                width: portTitle.width
            }

            Rectangle {
                id: divider
                width: 1
                height: statsContainer.height
                color: "#ddd"
                anchors {
                    left: portTitle.right
                    leftMargin: 10
                }
            }

            Item {
                id: stats
                anchors {
                    top: statsContainer.top
                    left: divider.right
                    leftMargin: 10
                    right: statsContainer.right
                    bottom: statsContainer.bottom
                }

                Item {
                    id: connectionContainer
                    visible: !root.portConnected

                    anchors {
                        centerIn: parent
                    }

                    Image {
                        id: connectionIcon
                        source: "../images/icon-usb-disconnected.svg"
                        height: stats.height * 0.666
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
                        font {
                            pixelSize: 14
                        }
                    }
                }

                Column {
                    id: column1
                    //visible: root.portConnected
                    visible: false
                    anchors {
                        verticalCenter: stats.verticalCenter
                    }
                    width: stats.width/2-1
                    spacing: 3

                    PortStatBox {
                        id:advertisedVoltageBox
                        label: "PROFILE"
                        value: ""
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "V"
                    }

                    PortStatBox {
                        id: pdContractBox
                        label: "PD CONTRACT"
                        value: ""
                        icon: "../images/icon-max.svg"
                        portColor: root.portColor
                        unit: "W"
                    }

                    PortStatBox {
                        id:inputPowerBox
                        label: "POWER IN"
                        value: ""
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "W"
                    }



                }

                Column {
                    id: column2
                    visible: root.portConnected
                    anchors {
                        left: column1.right
                        leftMargin: column1.spacing
                        verticalCenter: column1.verticalCenter
                    }
                    spacing: column1.spacing
                    width: stats.width/2 - 2

                    PortStatBox {
                        id:outputVoltageBox
                        label: "BUS VOLTAGE"
                        value: ""
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "V"
                    }

                    PortStatBox {
                        id:portTemperatureBox
                        label: "TEMPERATURE"
                        value: ""
                        icon: "../images/icon-temp.svg"
                        portColor: root.portColor
                        unit: "°C"
                    }

                    PortStatBox {
                        id: outputPowerBox
                        label: "POWER OUT"
                        value: ""
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "W"
                    }

                }
            }
        }
    }
}
