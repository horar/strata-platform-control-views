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
import "../../sgwidgets"

Rectangle {
    id: root

    property int portWidth: 150
    property bool portConnected: false
    property bool isUSBAPort: false     //used to hide information not available for USB-A ports
    property color portColor: "#30a2db"
    property int portNumber: 0
    property alias portName: portTitle.text
    property alias portSubtitle: portSubtitle.text
    property alias isDisplayportCapable: advancedControls.isDisplayportCapable

    property alias outputVoltage: outputVoltageBox.value
    property alias maxPower: maxPowerBox.value
    property alias inputPower: powerInBox.value
    property alias outputPower: powerOutBox.value
    property alias portTemperature: temperatureBox.value
    property alias efficency: efficencyBox.value

    onPortConnectedChanged:{
        if (portConnected)
            hideStats.start()
         else
            showStats.start()
    }

    OpacityAnimator {
        id: hideStats
        target: connectionContainer
        from: 1
        to: 0
        duration: 1000
    }

    OpacityAnimator {
        id: showStats
        target: connectionContainer
        from: 0
        to: 1
        duration: 1000
    }

    function prepareToTransitionToAdvancedView(){
        //keep the telemetry boxes from expanding as the port view is expanding
        //console.log("port preparing to transition to advanced")
        powerOutBox.anchors.right = undefined
        temperatureBox.anchors.right = powerOutBox.right
        efficencyBox.anchors.right = powerOutBox.right
    }

    function transitionToAdvancedView(){

        //break the anchors needed to move port stats
        //unhook the box around the power telemetry. Attach the
        //temperature and efficiency boxes to the power box so they can move together
        //powerOutBox.anchors.top = undefined
        powerOutBox.anchors.left = undefined
        powerOutBox.anchors.right = undefined
        temperatureBox.anchors.left = powerOutBox.left
        temperatureBox.anchors.right = powerOutBox.right
        efficencyBox.anchors.left = powerOutBox.left
        efficencyBox.anchors.right = powerOutBox.right
        portToAdvanced.start()
        outputVoltageBox.transitionToAdvancedView()
        maxPowerBox.transitionToAdvancedView()
        powerInBox.transitionToAdvancedView()
        powerOutBox.transitionToAdvancedView()
        temperatureBox.transitionToAdvancedView()
        efficencyBox.transitionToAdvancedView()

    }

    SequentialAnimation{
        id: portToAdvanced

        ParallelAnimation{
            id: adjustStatsBoxSizes //and move bottom stats boxes right
            running: false

            PropertyAnimation {
                target: outputVoltageBox
                property: "width"
                to: (root.width)/2 -10
                duration: basicToAdvancedTelemetryAnimationTime
            }

            PropertyAnimation {
                target: maxPowerBox
                property: "width"
                to: (root.width)/2-10
                duration: basicToAdvancedTelemetryAnimationTime
            }

            PropertyAnimation {
                target: powerInBox
                property: "width"
                to: (root.width)/2-10
                duration: basicToAdvancedTelemetryAnimationTime
            }

            PropertyAnimation {
                target: powerOutBox
                property: "width"
                to: (root.width)/2-10
                duration: basicToAdvancedTelemetryAnimationTime
            }

            PropertyAnimation {
                target: powerOutBox
                property: "x"
                to: (root.width)/2
                duration: basicToAdvancedTelemetryAnimationTime
            }
        }
        ParallelAnimation{
            id:moveBottomStatsBoxesUp
            running:false


            PropertyAnimation {
                target: powerOutBox
                property: "y"
                to: titleBackground.y + titleBackground.height + 8
                duration: basicToAdvancedTelemetryAnimationTime
            }
        }

        onStarted: {
            //break the top anchor for the top box of the bottom three so we can move it up
            powerOutBox.anchors.top = undefined
        }

        onStopped: {
            advancedControls.transitionToAdvancedView();
        }

    }


 //-----------------------------------------------------------------------------------------------------------
 //         Transition to Basic
 //-----------------------------------------------------------------------------------------------------------
    function prepareToTransitionToBasicView(){
        //console.log("port preparing to transition to basic")
        portToBasic.start()
    }

    function transitionToBasicView(){

        //break the anchors needed to move port stats
        //these should have been changed on the transition to advanced view,
        //but we'll do it again just in case.
        powerOutBox.anchors.top = undefined
        powerOutBox.anchors.left = undefined
        powerOutBox.anchors.right = undefined
        temperatureBox.anchors.left = powerOutBox.left
        temperatureBox.anchors.right = powerOutBox.right
        efficencyBox.anchors.left = powerOutBox.left
        efficencyBox.anchors.right = powerOutBox.right
    }


    SequentialAnimation{
        id: portToBasic

        PropertyAnimation {
            id:fadeOutAdvancedControls
            running:false
            target: advancedControls
            property: "opacity"
            to: 0
            duration: root.portConnected ? advancedToBasicAdvancedControlsAnimationTime: 1
        }

        PropertyAnimation {
            id:moveRightTelemetryBoxesDown
            target: powerOutBox
            property: "y"
            to: powerInBox.y + powerInBox.height
            duration: root.portConnected ? advancedToBasicTelemetryAnimationTime: 1




        }

        PropertyAnimation {

            target: powerOutBox
            property: "x"
            to: 10
            duration: root.portConnected ? advancedToBasicTelemetryAnimationTime : 1
        }

        ParallelAnimation{


            PropertyAnimation {
                target: outputVoltageBox
                property: "width"
                to: portWidth -10
                duration: root.portConnected ? basicToAdvancedTelemetryAnimationTime: 1
            }

            PropertyAnimation {
                target: maxPowerBox
                property: "width"
                to: portWidth -10
                duration: root.portConnected ? basicToAdvancedTelemetryAnimationTime: 1
            }

            PropertyAnimation {
                target: powerInBox
                property: "width"
                to: portWidth -10
                duration: root.portConnected ? basicToAdvancedTelemetryAnimationTime: 1
            }

            PropertyAnimation {
                target: powerOutBox
                property: "width"
                to: portWidth -10
                duration: root.portConnected ? basicToAdvancedTelemetryAnimationTime: 1
            }
        }

        onStopped:{
            powerOutBox.anchors.top = powerInBox.bottom
            powerOutBox.anchors.left = outputVoltageBox.left
            powerOutBox.anchors.right = outputVoltageBox.right
            //enlarge the icons
            outputVoltageBox.transitionToBasicView()
            maxPowerBox.transitionToBasicView()
            powerInBox.transitionToBasicView()
            powerOutBox.transitionToBasicView()
            temperatureBox.transitionToBasicView()
            efficencyBox.transitionToBasicView()
        }

}


    signal showGraph()

    color: "lightgoldenrodyellow"
    radius: 5
    border.color: "black"
    width: portWidth

    Rectangle{
        id:titleBackground
        color:"lightgrey"
        anchors.top: root.top
        anchors.topMargin: 1
        anchors.left:root.left
        anchors.leftMargin: 1
        anchors.right: root.right
        anchors.rightMargin: 1
        height: 50//(2*root.height)/16
        radius:5

        Rectangle{
            id:squareBottomBackground
            color:"lightgrey"
            anchors.top:titleBackground.top
            anchors.topMargin:(titleBackground.height)/2
            anchors.left:titleBackground.left
            anchors.right: titleBackground.right
            height: (titleBackground.height)/2
        }

        Text {
            id: portTitle
            text: "foo"
            anchors.horizontalCenter: titleBackground.horizontalCenter
            anchors.verticalCenter: titleBackground.verticalCenter
            font {
                pixelSize: 28
            }

            color: root.portConnected ? "black" : "#bbb"
        }
        Text {
            id: portSubtitle
            text: ""
            anchors.horizontalCenter: titleBackground.horizontalCenter
            anchors.top: portTitle.bottom
            anchors.topMargin: -5
            font {
                pixelSize: 12
            }

            color: "darkGrey"
        }
    }

    PortStatBox{
        id:outputVoltageBox
        anchors.left:root.left
        anchors.leftMargin: 10
        anchors.top: titleBackground.bottom
        anchors.topMargin: 8
        width:portWidth-10
        height:root.height/9
        label: "VOLTAGE OUT"
        color:"transparent"
    }

    PortStatBox{
        id:maxPowerBox
        anchors.left:outputVoltageBox.left
        anchors.top: outputVoltageBox.bottom
        anchors.topMargin: 8
        //anchors.right: outputVoltageBox.right
        width:portWidth-10
        height:root.height/9
        label: "MAXIMUM POWER"
        unit: "W"
        color:"transparent"
        icon: "../images/icon-max.svg"
    }

    PortStatBox{
        id:powerInBox
        anchors.left:outputVoltageBox.left
        anchors.top: maxPowerBox.bottom
        anchors.topMargin: 8
        //anchors.right: outputVoltageBox.right
        width:portWidth-10
        height:root.height/9
        label: "POWER IN"
        unit:"W"
        color:"transparent"
        icon: "../images/icon-voltage.svg"
        visible: !isUSBAPort

    }

    PortStatBox{
        id:powerOutBox
        anchors.left:outputVoltageBox.left
        anchors.top: powerInBox.bottom
        anchors.topMargin: 8
        //anchors.right: outputVoltageBox.right
        width:portWidth-10
        height:root.height/9
        label: "POWER OUT"
        unit:"W"
        color:"transparent"
        icon: "../images/icon-voltage.svg"
    }

    PortStatBox{
        id:temperatureBox
        anchors.left:outputVoltageBox.left
        anchors.top: powerOutBox.bottom
        anchors.topMargin: 8
        //anchors.right: outputVoltageBox.right
        width:portWidth-10
        height:root.height/9
        label: "TEMPERATURE"
        unit:"°C"
        color:"transparent"
        icon: "../images/icon-temp.svg"
    }

    PortStatBox{
        id:efficencyBox
        anchors.left:outputVoltageBox.left
        anchors.top: temperatureBox.bottom
        anchors.topMargin: 8
        //anchors.right: outputVoltageBox.right
        width:portWidth-10
        height:root.height/9
        label: "EFFICENCY"
        unit:"%"
        color:"transparent"
        icon: "../images/icon-efficiency.svg"
        visible: !isUSBAPort
    }

    AdvancedPortControls{
        id:advancedControls
        anchors.top: powerInBox.bottom
        anchors.left: root.left
        anchors.leftMargin: 1
        anchors.right: root.right
        anchors.rightMargin: 1
        anchors.bottom: root.bottom
        opacity: 0
    }

    Rectangle {
        id: connectionContainer
        opacity: 1

        anchors {
            top:titleBackground.bottom
            left:root.left
            leftMargin: 2
            right:root.right
            rightMargin: 2
            bottom:root.bottom
            bottomMargin: 2
        }

        Image {
            id: connectionIcon
            source: "../images/icon-usb-disconnected.svg"
            height: connectionContainer.height/4
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
}
    /*
    Item {
        id: margins
        anchors {
            fill: parent
            topMargin: 15
            leftMargin: 15
            rightMargin: 0
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

            Button {
                id: showGraphs
                text: "Graphs"
                anchors {
                    bottom: statsContainer.bottom
                    horizontalCenter: portTitle.horizontalCenter
                }
                height: 20
                width: 60
                onClicked: root.showGraph()
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
                    visible: root.portConnected
                    anchors {
                        verticalCenter: stats.verticalCenter
                    }
                    width: stats.width/2-1
                    spacing: 3

                    PortStatBox {
                        id:advertisedVoltageBox
                        label: "PROFILE"
                        //value: "20"
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "V"
                        height: (root.height - 10)/4
                    }

                    PortStatBox {
                        id:maxPowerBox
                        label: "MAX CAPACITY"
                        //value: "100"
                        icon: "../images/icon-max.svg"
                        portColor: root.portColor
                        unit: "W"
                        height: (root.height - 10)/4
                    }

                    PortStatBox {
                        id:inputPowerBox
                        label: "POWER IN"
                        //value: "9"
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "W"
                        height: (root.height - 10)/4
                    }

                    PortStatBox {
                        id:outputPowerBox
                        label: "POWER OUT"
                        //value: "7.8"
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "W"
                        height: (root.height - 10)/4
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
                        label: "VOLTAGE OUT"
                        //value: "20.4"
                        icon: "../images/icon-voltage.svg"
                        portColor: root.portColor
                        unit: "V"
                        height: (root.height - 10)/4
                    }

                    PortStatBox {
                        id:portTemperatureBox
                        label: "TEMPERATURE"
                        //value: "36"
                        icon: "../images/icon-temp.svg"
                        portColor: root.portColor
                        unit: "°C"
                        height: (root.height - 10)/4
                    }

                    PortStatBox {
                        id:efficencyBox
                        label: "EFFICIENCY"
                        //value: "92"
                        icon: "../images/icon-efficiency.svg"
                        portColor: root.portColor
                        unit: "%"
                        height: (root.height - 10)/4
                    }
                }
            }
        }
    }
}
*/
