/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.12

import tech.strata.sgwidgets 1.0

import "qrc:/js/help_layout_manager.js" as Help

/********************************************************************************************************
This is UI for STR-DMS-CONTROL-GEV
*********************************************************************************************************/
Item {


    id: root
    property real ratioCalc: root.width / 1200

    MouseArea {
        id: containMouseArea
        anchors.fill: root
        z: 0

        onClicked: {
            forceActiveFocus()
        }
    }


    Timer {
        id: pwm1delayTimer

        repeat: false
        interval: 10
        onTriggered: platformInterface.commands.set_pwm1.update(parseFloat(pwm1Slider.value.toFixed(2)),pwm1Switch.checked)

    }

    Timer {
        id: pwm3delayTimer

        repeat: false
        interval: 10
        onTriggered: platformInterface.commands.set_pwm3.update(parseFloat(pwm3Slider.value.toFixed(1)),pwm3Switch.checked)

    }

    function formating_random_increment(max,value){
        let dataArray = []
        for(let y = 0; y < max; y++) {
            var idxName = `index_${y}`
            var yValue = value[idxName]
            dataArray.push(yValue)
        }
        return dataArray
    }

    ColumnLayout {
        width: parent.width
        height: parent.height/2
        //anchors.centerIn: parent
        anchors.top:parent.top
        //anchors.bottom:headingCommandHandler.top
        anchors.bottom: controls.bottom
        anchors.bottomMargin: 300
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20

        Rectangle{
            width: parent.width
            height: parent.height
            //color: "red"
            Image {
                id: backgroung
                source: "images/background.png"
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit
            }
        }

    }

    ColumnLayout {
        width: parent.width
        height: parent.height/2
        //anchors.centerIn: parent
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.topMargin: 300
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20
        id:controls

        Item {
            Layout.preferredHeight: parent.height/3
            Layout.fillWidth: true
        }

        Item {
            Layout.preferredHeight: parent.height/3
            Layout.fillWidth: true

            Rectangle{
                id: headingCommandHandler
                width: parent.width
                height: parent.height/5
                border.color: "lightgray"
                color: "lightgray"

                Text {
                    id: simpleControlHeading
                    text: "Simple Command Handler"
                    font.bold: true
                    font.pixelSize: ratioCalc * 20
                    color: "#696969"
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 10
                    }
                }
            }

            RowLayout {
                anchors.top: headingCommandHandler.bottom
                anchors.topMargin: 5
                width: parent.width
                height: parent.height - headingCommandHandler.height


                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width/3

                    ColumnLayout {
                        anchors.fill: parent

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.column: 1

                            SGAlignedLabel {
                                id: pwm1SwitchLabel
                                target: pwm1Switch
                                text: "I_LED (LED driver NCV7694)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSwitch {
                                    id: pwm1Switch
                                    width: 50
                                    checked: false
                                    onToggled:  {
                                        platformInterface.commands.set_pwm1.update(pwm1Slider.value,pwm1Switch.checked)
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm1SliderLabel
                                target: pwm1Slider
                                text: "Current (A)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSlider {
                                    id: pwm1Slider
                                    width: 250
                                    from: 0.7
                                    to: 5.0
                                    stepSize: 0.1
                                    value: 0.7
                                    inputBox.validator: DoubleValidator { top: 5.0; bottom: 0.7 }
                                    inputBox.text:  parseFloat(pwm1Slider.value.toFixed(2))
                                    contextMenuEnabled: true

                                    onPressedChanged: {
                                        inputBox.text = parseFloat(value.toFixed(2))

                                        if(pressed == false){
                                            platformInterface.commands.set_pwm1.update(parseFloat(value.toFixed(2)),pwm1Switch.checked)

                                            var maxONTime = 40/(10*pwm1Slider.value)
                                            if (pwm3Slider.value > maxONTime) {
                                                pwm3Slider.value = maxONTime
                                                pwm3Slider.inputBox.text = parseFloat(pwm3Slider.value.toFixed(1))
                                                pwm3delayTimer.start()
                                            }
                                        }
                                    }

                                    inputBox.onEditingFinished : {
                                        platformInterface.commands.set_pwm1.update(parseFloat(value.toFixed(2)),pwm1Switch.checked)

                                        var maxONTime = 40/(10*pwm1Slider.value)
                                        if (pwm3Slider.value > maxONTime) {
                                            pwm3Slider.value = maxONTime
                                            pwm3Slider.inputBox.text = parseFloat(pwm3Slider.value.toFixed(1))
                                            pwm3delayTimer.start()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width/3

                    ColumnLayout {
                        anchors.fill: parent

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm2SwitchLabel
                                target: pwm2Switch
                                text: "VOUT (DCDC converter NCV890204)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSwitch {
                                    id: pwm2Switch
                                    width: 50
                                    checked: false
                                    enabled: false
                                    onToggled:  {
                                        platformInterface.commands.set_pwm2.update(pwm2Slider.value,pwm2Switch.checked)
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm2SliderLabel
                                target: pwm2Slider
                                text: "Voltage (V)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter                               

                                SGSlider {
                                    id: pwm2Slider
                                    width: 250
                                    from: 4.8
                                    to: 10
                                    stepSize: 0.1
                                    value: 10
                                    inputBox.validator: DoubleValidator { top: 10; bottom: 4.80 }
                                    inputBox.text: parseFloat(value.toFixed(2))
                                    contextMenuEnabled: true
                                    enabled: false

                                    onPressedChanged: {
                                        inputBox.text = parseFloat(value.toFixed(2))
                                        if(pressed == false){
                                            platformInterface.commands.set_pwm2.update(parseFloat(value.toFixed(2)) ,pwm2Switch.checked)
                                        }
                                    }

                                    inputBox.onEditingFinished : {
                                        platformInterface.commands.set_pwm2.update(parseFloat(value.toFixed(2)) ,pwm2Switch.checked)
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width/3

                    ColumnLayout {
                        anchors.fill: parent

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm3SwitchLabel
                                target: pwm3Switch
                                text: "Flash PWM (62Hz)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSwitch {
                                    id: pwm3Switch
                                    width: 50
                                    checked: false

                                    onToggled:  {
                                        platformInterface.commands.set_pwm3.update(pwm3Slider.value,pwm3Switch.checked)
                                        pwm2Switch.enabled = (pwm3Switch.checked)
                                        pwm2Slider.enabled = (pwm3Switch.checked)
                                    }

                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm3SliderLabel
                                target: pwm3Slider
                                text: "T_ON time (ms)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSlider {
                                    id: pwm3Slider
                                    width: 250
                                    from: 0.0
                                    to: 5
                                    stepSize: 0.1
                                    value: 0.0
                                    inputBox.validator: DoubleValidator { top: 5.00; bottom: 0.0 }
                                    inputBox.text: parseFloat(value.toFixed(1))
                                    contextMenuEnabled: true

                                    onPressedChanged: {
                                        inputBox.text = parseFloat(value.toFixed(1))

                                        if(pressed == false){
                                            var maxCurrent = 40/(10*pwm3Slider.value)
                                            if (pwm1Slider.value > maxCurrent)
                                            {
                                                pwm1Slider.value = maxCurrent
                                                pwm1Slider.inputBox.text = parseFloat(pwm1Slider.value.toFixed(2))
                                                platformInterface.commands.set_pwm1.update(parseFloat(pwm1Slider.value.toFixed(2)),pwm1Switch.checked)
                                                pwm3delayTimer.start()
                                            }else{
                                                platformInterface.commands.set_pwm3.update(parseFloat(value.toFixed(1)), pwm3Switch.checked)
                                            }
                                        }
                                    }

                                    inputBox.onEditingFinished : {
                                        var maxCurrent = 40/(10*pwm3Slider.value)
                                        if (pwm1Slider.value > maxCurrent)
                                        {
                                            pwm1Slider.value = maxCurrent
                                            pwm1Slider.inputBox.text = parseFloat(pwm1Slider.value.toFixed(2))
                                            platformInterface.commands.set_pwm1.update(parseFloat(pwm1Slider.value.toFixed(2)),pwm1Switch.checked)
                                            pwm3delayTimer.start()
                                        }else{
                                            platformInterface.commands.set_pwm3.update(parseFloat(value.toFixed(1)), pwm3Switch.checked)
                                        }
                                    }
                                }
                            }

                            Item {
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                SGAlignedLabel {
                                    id: pwm3SliderLabel3
                                    target: labelDuty
                                    text: "T_ON duty cycle: " + (((pwm3Slider.value/(1/62))/10).toFixed(0)) + "%"
                                    font.bold: true
                                    anchors.centerIn: parent
                                    alignment: SGAlignedLabel.SideTopCenter

                                    SGAlignedLabel{
                                        id:labelDuty
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}






