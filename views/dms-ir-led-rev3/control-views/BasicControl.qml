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
        onTriggered: platformInterface.set_i_led.update(parseFloat(pwm1Slider.value.toFixed(2)))

    }

    Timer {
        id: pwm3delayTimer

        repeat: false
        interval: 10
        onTriggered: platformInterface.set_flash_pwm.update(parseFloat(pwm3Slider.value.toFixed(2)),pwm3Switch.checked)

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
        anchors.top:parent.top
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
            Image {
                id: backgroung
                source: "images/background.png"
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit
            }
        }

        Component.onCompleted: {
            platformInterface.request_initial_values_command.send()
        }

    }

    ColumnLayout {
        width: parent.width
        height: parent.height/2
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
            Layout.preferredHeight: parent.height/2
            Layout.fillWidth: true

            Rectangle{
                id: headingCommandHandler
                width: parent.width
                height: parent.height/5
                border.color: "lightgray"
                color: "lightgray"

                Text {
                    id: simpleControlHeading
                    text: "Control panel"
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
                    Layout.preferredWidth: parent.width/4

                    ColumnLayout {
                        anchors.fill: parent

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm1SliderLabel
                                target: pwm1Slider
                                text: "I_LED (LED driver NCV7694) \n Current (A)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSlider {
                                    id: pwm1Slider
                                    width: 250
                                    from: 0.7
                                    to: 5.0
                                    stepSize: 0.1
                                    value: platformInterface.current.toFixed(1)
                                    inputBox.validator: DoubleValidator { top: 5.0; bottom: 0.7 }
                                    inputBox.text:  parseFloat(pwm1Slider.value.toFixed(2))
                                    contextMenuEnabled: true

                                    onPressedChanged: {
                                        inputBox.text = parseFloat(value.toFixed(2))

                                        if(pressed == false){
                                            platformInterface.set_i_led.update(parseFloat(value.toFixed(2)))

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
                }

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width/4

                    ColumnLayout {
                        anchors.fill: parent

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: pwm2SliderLabel
                                target: pwm2Slider
                                text: "V_OUT (DCDC converter NCV890204) \n Voltage (V)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter                               

                                SGSlider {
                                    id: pwm2Slider
                                    width: 250
                                    from: 4.8
                                    to: 10
                                    stepSize: 0.1
                                    value: platformInterface.voltage.toFixed(1)
                                    inputBox.validator: DoubleValidator { top: 10; bottom: 4.80 }
                                    inputBox.text: parseFloat(value.toFixed(2))
                                    contextMenuEnabled: true
                                    enabled: false

                                    onPressedChanged: {
                                        inputBox.text = parseFloat(value.toFixed(2))
                                        if(pressed == false){
                                            platformInterface.set_v_out.update(parseFloat(value.toFixed(2)))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width/4

                    ColumnLayout {
                        anchors.fill: parent

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.column: 1

                            Button {
                                id: btn_i_led_save
                                anchors.centerIn: parent
                                Layout.alignment: SGAlignedLabel.Left

                                text: qsTr("Save values I_LED and V_OUT to EEPROM")
                                contentItem: Text {
                                    id: btn_i_led_save_text
                                    text: btn_i_led_save.text
                                    color: "black"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked:
                                {
                                    var pwm1SliderValue = pwm1Slider.value
                                    var pwm2SliderValue = pwm2Slider.value

                                    platformInterface.save_values.update(pwm2SliderValue, pwm1SliderValue)
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width/4

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
                                        platformInterface.set_flash_pwm.update(pwm3Slider.value,pwm3Switch.checked)
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
                                text: "T_ON time (ms) \n T_ON duty cycle: " + (((pwm3Slider.value/(1/62))/10).toFixed(0)) + "%"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSlider {
                                    id: pwm3Slider
                                    width: 250
                                    from: 0.0
                                    to: 5
                                    stepSize: 0.125
                                    value: 0.0
                                    inputBox.validator: DoubleValidator { top: 5.00; bottom: 0.0 }
                                    inputBox.text: parseFloat(value.toFixed(2))
                                    contextMenuEnabled: true

                                    onPressedChanged: {
                                        inputBox.text = parseFloat(value.toFixed(2))

                                        if(pressed == false){
                                            var maxCurrent = 40/(10*pwm3Slider.value)
                                            if (pwm1Slider.value > maxCurrent)
                                            {
                                                pwm1Slider.value = maxCurrent
                                                pwm1Slider.inputBox.text = parseFloat(pwm1Slider.value.toFixed(2))
                                                platformInterface.set_i_led.update(parseFloat(pwm1Slider.value.toFixed(2)))
                                                pwm3delayTimer.start()
                                            }else{
                                                platformInterface.set_flash_pwm.update(parseFloat(value.toFixed(2)), pwm3Switch.checked)
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
    }
}






