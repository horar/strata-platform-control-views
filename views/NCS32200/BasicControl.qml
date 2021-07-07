import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "qrc:/js/help_layout_manager.js" as Help

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Item {
    id: root
    property real ratioCalc: root.width / 1200
    property real initialAspectRatio: 1225/700

    SGText {
        id: boardTitle
        anchors.horizontalCenter: parent.horizontalCenter
        text: "NCS32200 Evaluation System"
        font.bold: true
        font.pixelSize: ratioCalc * 30
        topPadding: 5
    }

    Component.onCompleted : {
           platformInterface.commands.get_data.update()
    }

    RowLayout {
        anchors {
            top: boardTitle.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin : 10
        }
        width: parent.width
        height: root.height - boardTitle.contentHeight

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors {
                    fill:parent
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/15
                    color: "transparent"
                    Text {
                        id: telemetryHeading
                        text: "Telemetry"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 5
                        }
                    }

                    Rectangle {
                        id: line1
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "lightgray"
                        radius: 1.5
                        anchors {
                            top: telemetryHeading.bottom
                            topMargin: 5
                        }
                    }
                }

                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: currPositionLabel
                        target: currPosition
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                        text: "Current \n Position"

                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: currPosition
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                            unit: "mm "
                            unitOverrideWidth:  50 * ratioCalc
                            text: platformInterface.notifications.get_NCS32200_data.pos

                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: currVeloLabel
                        target: currVelo
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                        text: "Current \n Velocity"

                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: currVelo
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                            unit: "mm/s"
                            unitOverrideWidth: 50 * ratioCalc
                            text: platformInterface.notifications.get_NCS32200_data.vel
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: currAccelLabel
                        target: currAccel
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                        text: "Current \n Acceleration"

                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: currAccel
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                            unit: "mm/s^2"
                            unitOverrideWidth: 50 * ratioCalc
                            text: platformInterface.notifications.get_NCS32200_data.accel
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: supplyVoltageLabel
                        target: supplyVoltage
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                        text: "Supply \n Voltage (VCC)"
                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: supplyVoltage
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                            unit: "V "
                            unitOverrideWidth: 50 * ratioCalc
                            text: platformInterface.notifications.status_telemetry.vcc
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: batteryVoltageLabel
                        target: batteryVoltage
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                        text: "Battery \n Voltage (VBAT)"
                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: batteryVoltage
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                            unit: "V"
                            unitOverrideWidth: 50 * ratioCalc
                            text: platformInterface.notifications.status_telemetry.vbat
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: batteryCurrentLabel
                        target: batteryCurrent
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                        text: "Battery \n Current (IBAT)"
                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: batteryCurrent
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                            unit: "mA"
                            unitOverrideWidth: 50 * ratioCalc
                            text: platformInterface.notifications.status_telemetry.ibat
                        }
                    }
                }
                Item {
                    Layout.preferredHeight: parent.height/2.5
                    Layout.fillWidth: true

                    RowLayout {
                        anchors {
                            fill: parent
                        }
                        spacing: 10
                        Item{
                            id: tempGaugeContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id: tempGaugeLabel
                                target: tempGauge
                                text: "Temperature \n (˚c)"
                                anchors {
                                    top:parent.top
                                    horizontalCenter: parent.horizontalCenter
                                }
                                alignment: SGAlignedLabel.SideBottomCenter
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                horizontalAlignment: Text.AlignHCenter

                                SGCircularGauge {
                                    id: tempGauge
                                    height: tempGaugeContainer.height - tempGaugeLabel.contentHeight - 50
                                    width:  tempGaugeContainer.width
                                    tickmarkStepSize: 10
                                    minimumValue: 0
                                    maximumValue: 100
                                    gaugeFillColor1: "blue"
                                    gaugeFillColor2: "red"
                                    unitTextFontSizeMultiplier: ratioCalc * 1.5
                                    valueDecimalPlaces: 1
                                    value: platformInterface.notifications.get_NCS32200_temperature.temperature

                                }
                            }
                        }
                        Item{
                            id: batteryPowerContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id: batteryPowerLabel
                                target: batteryPower
                                text: "Battery Power \n (mW)"
                                anchors {
                                    top:parent.top
                                    horizontalCenter: parent.horizontalCenter
                                }

                                alignment: SGAlignedLabel.SideBottomCenter
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                horizontalAlignment: Text.AlignHCenter

                                SGCircularGauge {
                                    id: batteryPower
                                    height: batteryPowerContainer.height - batteryPowerLabel.contentHeight - 50
                                    tickmarkStepSize: 0.5
                                    width:  tempGaugeContainer.width
                                    minimumValue: 0
                                    maximumValue: 5
                                    gaugeFillColor1: "blue"
                                    gaugeFillColor2: "red"
                                    unitTextFontSizeMultiplier: ratioCalc * 1.5
                                    valueDecimalPlaces: 1

                                }
                            }
                        }
                    }
                }
            }
        }


        Item  {
            Layout.preferredWidth: parent.width/2.3
            Layout.fillHeight: true
            ColumnLayout{
                anchors.fill:parent
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/1.5
                    SGGraph {
                        id: timedGraphPoints
                        anchors {
                            bottom: parent.bottom
                        }
                        width: parent.width
                        height:  parent.height/1.5
                        title: "Time Vs.Current Position"
                        xMin: 5
                        xMax: 0
                        yMin: 0
                        yMax: 10
                        yRightMin: 0
                        yRightMax: 10
                        xTitle: "Current Position(mm)"
                        yTitle: "Time (s)"
                        xGrid: true
                        yGrid: true
                        gridColor: "black"
                        foregroundColor: "black"
                        panXEnabled: false
                        panYEnabled: false
                        zoomXEnabled: false
                        zoomYEnabled: false
                        autoUpdate: false
                        backgroundColor: "white"
                    }


                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    SGRotateImage {
                        id: rotatingImage
                        width: parent.width
                        height:  parent.height/2
                        z: -1
                    }

                    SGButton{
                        text: "Position Export"
                        width : 100
                        height: 50
                        anchors {
                            top:parent.top
                            right:parent.right
                            rightMargin: 20
                        }
                    }
                }

            }

        }
        Rectangle {
            Layout.fillWidth:  true
            Layout.fillHeight: true

            ColumnLayout {
                anchors {
                    fill:parent
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/15
                    color: "transparent"
                    Text {
                        id: configHeading
                        text: "Configuration"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 5
                        }
                    }

                    Rectangle {
                        id: line3
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "lightgray"
                        radius: 1.5
                        anchors {
                            top: configHeading.bottom
                            topMargin: 5
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    ColumnLayout {
                        anchors {
                            fill:parent
                        }
                        Item{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            RowLayout {
                                anchors {
                                    fill:parent
                                }
                                Item{
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id:  vbatLabel
                                        target: vbat
                                        text: "VBAT EN"
                                        fontSizeMultiplier: ratioCalc
                                        font.bold : true
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        horizontalAlignment: Text.AlignHCenter
                                        SGSwitch {
                                            id: vbat
                                            checkedLabel: "On"
                                            uncheckedLabel: "Off"
                                            // fontSizeMultiplier: ratioCalc

                                        }
                                    }
                                }
                                Item{
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: vbatSetLabel
                                        target: vbatSet
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                        font.bold : true
                                        text: "VBAT Set"

                                        SGSubmitInfoBox {
                                            id: vbatSet
                                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                            height:  35 * ratioCalc
                                            width: 50 * ratioCalc
                                            unit: "V"
                                            onAccepted: {
                                                platformInterface.commands.set_low_batt.update(text)
                                            }
                                        }
                                    }
                                }
                                Item{
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: batteryThresholdLabel
                                        target: batteryThreshold
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                        font.bold : true
                                        text: "Battery voltage \nThreshold"

                                        SGSubmitInfoBox {
                                            id: batteryThreshold
                                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                            height:  35 * ratioCalc
                                            width: 50 * ratioCalc
                                            unit: "V"
                                            onAccepted: {
                                                platformInterface.commands.set_battv.update(text)
                                            }
                                        }
                                    }
                                }

                            }
                        }

                        Item{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id:  vccDisconnectLabel
                                target: vccDisconnect
                                text: "VCC\nDisconnect"
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                alignment: SGAlignedLabel.SideLeftCenter
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                SGSwitch {
                                    id: vccDisconnect
                                    checkedLabel: "On"
                                    uncheckedLabel: "Off"
                                    onToggled: {
                                        if(checked)
                                            platformInterface.commands.vcc_en.update("on")
                                        else
                                            platformInterface.commands.vcc_en.update("off")
                                    }

                                }
                            }
                        }
                        Item{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id:  positionExtrapolationLabel
                                target: positionExtrapolation
                                text: "Position\nExtrapolation"
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                alignment: SGAlignedLabel.SideLeftCenter
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                SGSwitch {
                                    id: positionExtrapolation
                                    checkedLabel: "On"
                                    uncheckedLabel: "Off"
                                    onToggled: {
                                        if(checked)
                                            platformInterface.commands.bat_en.update("on")
                                        else
                                            platformInterface.commands.bat_en.update("off")
                                    }

                                }
                            }
                        }

                    }
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/15
                    color: "transparent"
                    Text {
                        id: diagnosticsHeading
                        text: "Diagnostics"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 5
                        }
                    }

                    Rectangle {
                        id: line4
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "lightgray"
                        radius: 1.5
                        anchors {
                            top: diagnosticsHeading.bottom
                            topMargin: 5
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    ColumnLayout {
                        anchors {
                            fill:parent
                        }

                        Item {
                            Layout.preferredHeight: parent.height/8
                            Layout.fillWidth: true
                            RowLayout {
                                anchors {
                                    fill: parent
                                }
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: vbatLowLabel
                                        target: vbatLow
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                        font.bold: true
                                        text: "VBAT Low"

                                        SGStatusLight {
                                            id: vbatLow
                                            width : 40
                                            status: platformInterface.notifications.get_NCS32200_errors.low_bat ? SGStatusLight.Red : SGStatusLight.Off

                                        }
                                    }
                                }
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: noPowerLabel
                                        target: noPower
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                        font.bold: true
                                        text: "No Power"

                                        SGStatusLight {
                                            id: noPower
                                            width : 40
                                            status: platformInterface.notifications.get_NCS32200_errors.no_power ? SGStatusLight.Red : SGStatusLight.Off

                                        }
                                    }
                                }
                            }
                        }
                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGStatusLogBox {
                                id: logBox
                                title: "Error Status "
                                width : parent.width/1.5
                                height:parent.height/1.5
                                anchors.centerIn: parent

                            }
                        }
                    }

                }
            }
        }
    }
}
