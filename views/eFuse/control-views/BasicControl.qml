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
import QtQuick.Controls 2.7
import "../sgwidgets"
import tech.strata.sgwidgets 1.0 as Sgwidget10
import tech.strata.fonts 1.0
import "qrc:/js/help_layout_manager.js" as Help

Item {
    id: root
    property real ratioCalc: root.width / 1200
    property real initialAspectRatio: 1200/820
    property bool holder: false
    property int bitData: 0
    property string binaryConversion: ""
    width: parent.width / parent.height > initialAspectRatio ? parent.height * initialAspectRatio : parent.width
    height: parent.width / parent.height < initialAspectRatio ? parent.width / initialAspectRatio : parent.height


    property var temp1_noti: platformInterface.periodic_status.temperature1
    onTemp1_notiChanged: {
        temp1.value = temp1_noti.toFixed(2)
    }
    property var temp2_noti: platformInterface.periodic_status.temperature2
    onTemp2_notiChanged: {
        temp2.value = temp2_noti.toFixed(2)
    }
    property var vin_noti: platformInterface.periodic_status.vin
    onVin_notiChanged: {
        inputVoltage.info = vin_noti.toFixed(2)
    }
    property var vout_noti: platformInterface.periodic_status.vout
    onVout_notiChanged: {
        ouputVoltage.info = vout_noti.toFixed(2)
    }
    property var iin_noti: platformInterface.periodic_status.iin
    onIin_notiChanged: {
        inputCurrent.info = iin_noti.toFixed(2)
    }
    property var iout_noti: platformInterface.periodic_status.iout
    onIout_notiChanged: {
        ouputCurrent.info = iout_noti.toFixed(2)
    }

    property var vin_status_noti: platformInterface.periodic_status.vin_led
    onVin_status_notiChanged: {
        if(vin_status_noti === "good"){
            vinLed.status = Sgwidget10.SGStatusLight.Green
            eFuse1.enabled = true
            eFuse2.enabled = true
            eFuse1.opacity = 1.0
            eFuse2.opacity =  1.0
        }
        else {
            eFuse1.enabled = false
            eFuse2.enabled = false
            eFuse1.opacity = 0.5
            eFuse2.opacity =  0.5
            vinLed.status = Sgwidget10.SGStatusLight.Red
            platformInterface.enable_1 = false
            platformInterface.enable_2 = false
        }
    }

    property var periodic_status_en1: platformInterface.enable_status.en1
    onPeriodic_status_en1Changed: {
        if(periodic_status_en1 === "on"){
            platformInterface.enable_1 = true
        }
        else  platformInterface.enable_1 = false
    }

    property var periodic_status_en2: platformInterface.enable_status.en2
    onPeriodic_status_en2Changed: {
        if(periodic_status_en2 === "on")
            platformInterface.enable_2 = true
        else platformInterface.enable_2 = false
    }

    Component.onCompleted: {
        Help.registerTarget(topSetting, "These gauges monitor the board temperature around each eFuse in degrees Celsius.", 1, "basicHelp")
        Help.registerTarget(controlsContainer,"These switches enable the eFuses individually. They will remain grayed out if the input voltage is not above the minimum threshold (9.2V).", 2, "basicHelp")
        Help.registerTarget(inputContainer,"The LED is green when input voltage is good (above 9.2V) and the input voltage and current are displayed.", 3 , "basicHelp")
        Help.registerTarget(outputContainer,"Output voltage and current are displayed here.", 4 , "basicHelp")
    }

    Rectangle{
        id: graphContainer
        width: parent.width
        height: parent.height
        color: "transparent"

        Text {
            id: partNumber
            text: efuseClassID.partNumber
            font.bold: true
            color: "black"
            anchors{
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            font.pixelSize: (parent.height + parent.width)/80
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: topSetting
            width: parent.width/1.5
            height: parent.height/3.4

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: partNumber.bottom
                topMargin: 10
            }
            color:"transparent"

            RowLayout {
                anchors.fill: parent
                SGCircularGauge {
                    id: temp1
                    minimumValue: -55
                    maximumValue: 125
                    tickmarkStepSize: 20
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    gaugeRearColor: "#ddd"                // Default: "#ddd"(background color that gets filled in by gauge)
                    centerColor: "black"
                    outerColor: "#999"
                    gaugeFrontColor1: Qt.rgba(0,.75,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    unitLabel: "˚C"
                    gaugeTitle: "Board Temperature \n Sensor 1"
                    Layout.alignment: Qt.AlignCenter
                    unitSize: ratioCalc * 20

                }


                SGCircularGauge {
                    id: temp2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    minimumValue: -55
                    maximumValue: 125
                    tickmarkStepSize: 20
                    gaugeRearColor: "#ddd"                // Default: "#ddd"(background color that gets filled in by gauge)
                    centerColor: "black"
                    outerColor: "#999"
                    gaugeFrontColor1: Qt.rgba(0,.75,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    unitLabel: "˚C"                        // Default: "RPM"
                    gaugeTitle: "Board Temperature \n Sensor 2"
                    Layout.alignment: Qt.AlignCenter
                    unitSize: ratioCalc * 20
                }
            }
        }

        Rectangle {
            id: controlsContainer
            width: parent.width/2
            height: parent.height/5
            color: "transparent"
            anchors {
                top: topSetting.bottom
                topMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
            border.color: "black"
            border.width: 5
            radius: 10
            Text {
                id: titleControl
                text: "Control"
                font.bold: true
                color: "black"
                anchors{
                    top: parent.top
                    topMargin: 15
                    horizontalCenter: parent.horizontalCenter
                }
                font.pixelSize: ratioCalc * 30
                horizontalAlignment: Text.AlignHCenter
            }
            Rectangle {
                id: lineUnderControlTitle
                height: 2
                width: parent.width - 15
                anchors {
                    top: titleControl.bottom
                    topMargin: 7
                    left: parent.left
                    leftMargin: 5
                }
                border.color: "darkgray"
                radius: 2
            }

            RowLayout {
                width: parent.width
                height: (parent.height - (titleControl.height - lineUnderControlTitle.height)) - 50

                anchors {
                    top: lineUnderControlTitle.bottom
                    topMargin: 5
                    horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "transparent"
                    SGSwitch {
                        id: eFuse1
                        anchors.centerIn: parent
                        label: "Enable 1"
                        fontSizeLabel: ratioCalc * 25
                        labelLeft: true              // Default: true (controls whether label appears at left side or on top of switch)
                        checkedLabel: "On"       // Default: "" (if not entered, label will not appear)
                        uncheckedLabel: "Off"    // Default: "" (if not entered, label will not appear)
                        labelsInside: true              // Default: true (controls whether checked labels appear inside the control or outside of it
                        switchWidth: 66                // Default: 52 (change for long custom checkedLabels when labelsInside)
                        switchHeight: 26                // Default: 26
                        textColor: "black"              // Default: "black"
                        handleColor: "#33b13b"            // Default: "white"
                        grooveColor: "black"             // Default: "#ccc"
                        grooveFillColor: "black"         // Default: "#0cf"
                        //Layout.alignment: Qt.AlignCenter
                        checked: platformInterface.enable_1
                        onToggled: {
                            if(checked)
                                platformInterface.set_enable_1.update("on")
                            else  platformInterface.set_enable_1.update("off")

                            platformInterface.enable_1 = checked

                        }
                    }
                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "transparent"

                    SGSwitch {
                        id: eFuse2
                        label: "Enable 2"
                        anchors.centerIn: parent
                        fontSizeLabel: ratioCalc * 25
                        labelLeft: true              // Default: true (controls whether label appears at left side or on top of switch)
                        checkedLabel: "On"       // Default: "" (if not entered, label will not appear)
                        uncheckedLabel: "Off"    // Default: "" (if not entered, label will not appear)
                        labelsInside: true              // Default: true (controls whether checked labels appear inside the control or outside of it
                        switchWidth: 66                // Default: 52 (change for long custom checkedLabels when labelsInside)
                        switchHeight: 26                // Default: 26
                        textColor: "black"             // Default: "black"
                        handleColor: "#33b13b"            // Default: "white"
                        grooveColor: "black"             // Default: "#ccc"
                        grooveFillColor: "black"         // Default: "#0cf"

                        checked: platformInterface.enable_2

                        onToggled: {
                            if(checked)
                                platformInterface.set_enable_2.update("on")
                            else platformInterface.set_enable_2.update("off")

                            platformInterface.enable_2 = checked
                        }
                    }
                }

            }

        }

        Rectangle {
            id: bottomSetting
            width: parent.width /1.5
            height: parent.height/2.6

            anchors {
                left: parent.left
                top: controlsContainer.bottom
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 10
            }
            color: "transparent"

            RowLayout {
                anchors.fill: parent

                Rectangle {
                    id: inputContainer
                    Layout.preferredWidth: parent.width/3
                    Layout.preferredHeight: parent.height - 20
                    Layout.alignment: Qt.AlignCenter
                    Layout.leftMargin: 10
                    color: "transparent"
                    border.color: "black"
                    border.width: 5
                    radius: 10

                    Text {
                        id: inputTitle
                        anchors{
                            top: parent.top
                            topMargin: 10
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: "Input"
                        font.bold: true
                        color: "black"
                        font.pixelSize: ratioCalc * 20


                    }
                    Rectangle {
                        id: lineUnderInputTitle
                        height: 2
                        anchors {
                            top: inputTitle.bottom
                            topMargin: 5
                            left: parent.left
                            leftMargin: 5
                        }
                        width: parent.width - 15
                        border.color: "darkgray"
                        radius: 2
                    }
                    ColumnLayout {

                        width: parent.width
                        height: (parent.height - (inputTitle.height - lineUnderInputTitle.height)) - 30

                        anchors {
                            top: lineUnderInputTitle.bottom
                            topMargin: 5
                            horizontalCenter: parent.horizontalCenter
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"

                            Sgwidget10.SGAlignedLabel {
                                id: vinLabel
                                target: vinLed
                                text: "Input Voltage  Good:"
                                alignment:   Sgwidget10.SGAlignedLabel.SideLeftCenter
                                anchors.centerIn: parent
                                fontSizeMultiplier: ratioCalc * 1.5
                                font.bold : true

                                Sgwidget10.SGStatusLight {
                                    id:vinLed


                                }
                            }
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"
                            SGLabelledInfoBox {
                                id: inputVoltage
                                anchors.centerIn: parent
                                infoBoxWidth: parent.width/3
                                infoBoxHeight: parent.height/1.4
                                label: "Input Voltage "
                                info: platformInterface.periodic_status.vin.toFixed(2)
                                unit: "V"
                                infoBoxColor: "black"
                                labelColor: "black"
                                unitSize: ratioCalc * 20
                                fontSize: ratioCalc * 20
                                fontPixelSize:  ratioCalc * 20
                                Layout.alignment: Qt.AlignCenter
                            }

                        }
                        Rectangle {
                            id:inputVoltageContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"
                            SGLabelledInfoBox {
                                id: inputCurrent
                                anchors.centerIn: parent
                                infoBoxWidth: parent.width/3
                                infoBoxHeight: parent.height/1.4
                                label: "Input Current "
                                info: platformInterface.periodic_status.iin.toFixed(2)
                                unit: "A"
                                infoBoxColor: "black"
                                labelColor: "black"
                                fontSize: ratioCalc * 20
                                unitSize: ratioCalc * 20
                                fontPixelSize:  ratioCalc * 20
                                Layout.alignment: Qt.AlignCenter
                            }
                        } 
                    }
                }
                Rectangle {
                    id: outputContainer
                    Layout.preferredWidth: parent.width/3
                    Layout.preferredHeight: parent.height - 20
                    Layout.alignment: Qt.AlignCenter
                    color: "transparent"
                    border.color: "black"
                    border.width: 5
                    radius: 10

                    Text {
                        id: ouputTitle
                        anchors{
                            top: parent.top
                            topMargin: 10
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: "Output"
                        font.bold: true
                        color: "black"
                        font.pixelSize: ratioCalc * 20
                    }
                    Rectangle {
                        id: lineUnderOuputTitle
                        height: 2
                        anchors {
                            top: ouputTitle.bottom
                            topMargin: 5
                            left: parent.left
                            leftMargin: 5
                        }
                        width: parent.width - 15
                        border.color: "darkgray"
                        radius: 2
                    }

                    ColumnLayout {
                        spacing: 10
                        width: parent.width
                        height: (parent.height - (ouputTitle.height - lineUnderOuputTitle.height)) - 60

                        anchors {
                            top: lineUnderOuputTitle.bottom
                            topMargin: 20
                            horizontalCenter: parent.horizontalCenter
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"
                            SGLabelledInfoBox {
                                id: ouputVoltage
                                anchors.centerIn: parent
                                infoBoxWidth: parent.width/3
                                infoBoxHeight: parent.height/1.6
                                label: "Output Voltage "
                                info: platformInterface.periodic_status.vout.toFixed(2)
                                unit: "V"
                                infoBoxColor: "black"
                                labelColor: "black"
                                fontPixelSize:  ratioCalc * 20
                                unitSize: ratioCalc * 20
                                fontSize: ratioCalc * 20
                                Layout.alignment: Qt.AlignCenter
                            }
                        }

                        Rectangle{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"
                            SGLabelledInfoBox {
                                id: ouputCurrent
                                anchors.centerIn: parent
                                infoBoxWidth: parent.width/3
                                infoBoxHeight: parent.height/1.6
                                label: "Output Current "
                                info: platformInterface.periodic_status.iin.toFixed(2)
                                unit: "A"
                                infoBoxColor: "black"
                                labelColor: "black"
                                fontPixelSize:  ratioCalc * 20
                                fontSize: ratioCalc * 20
                                unitSize: ratioCalc * 20
                                Layout.alignment: Qt.AlignCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
