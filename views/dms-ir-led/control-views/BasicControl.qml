import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.12

import tech.strata.sgwidgets 1.0

import "qrc:/js/help_layout_manager.js" as Help

/********************************************************************************************************
    This is a Template UI that works directly with the Template FW found
    Under Embedded Strata Core (Refer: README):
                https://code.onsemi.com/projects/SECSWST/repos/embedded-strata-core/browse/template
*********************************************************************************************************/
Item {


    id: root
    property real ratioCalc: root.width / 1200

    Component.onCompleted: {
        Help.registerTarget(navTabs, "These tabs contain different user interface functionality of the Strata evaluation board. Take the idea of walking the user into evaluating the board by ensuring the board is instantly functional when powered on and then dive into more complex tabs and features. These tabs are not required but contains in the template for illustration.", 0, "BasicControlHelp")
//        Help.registerTarget(pwm1SwitchLabel, "pwm1")
//        Help.registerTarget(pwm1SliderLabel, "pwm1sl")
//        Help.registerTarget(pwm2SwitchLabel, "pwm2")
//        Help.registerTarget(pwm2SliderLabel, "pwm2sl")
//        Help.registerTarget(pwm3SwitchLabel, "pwm3")
//        Help.registerTarget(pwm3SliderLabel, "pwm3sl")
    }

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
        height: parent.height/1.5
        //anchors.centerIn: parent
        anchors.top:parent.top
        anchors.bottom:headingCommandHandler.top
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
        width: parent.width/2
        height: parent.height/2
        //anchors.centerIn: parent
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.topMargin: 200
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20
        id:controls

//        Rectangle{
//            width: parent.width
//            height: parent.height
//            color: "blue"
//        }

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
//                                        delegateText1.text =  JSON.stringify(my_cmd_simple_obj,null,4)
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
                                    onUserSet: {
                                        inputBox.text = parseFloat(value.toFixed(2))
                                        platformInterface.commands.set_pwm1.update(parseFloat(value.toFixed(2)),pwm1Switch.checked)
//                                        delegateText1.text = JSON.stringify(my_cmd_simple_obj,null,4)

                                        var maxONTime = 40/(10*pwm1Slider.value)
                                        if (pwm3Slider.value > maxONTime)
                                        {
                                            pwm3Slider.value = maxONTime
                                            pwm3Slider.inputBox.text = parseFloat(pwm3Slider.value.toFixed(1))
                                            pwm3delayTimer.start()
                                            //platformInterface.commands.set_pwm3.update(parseFloat(pwm3Slider.value.toFixed(1)),pwm3Switch.checked)
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
                                    onToggled:  {
                                        platformInterface.commands.set_pwm2.update(pwm2Slider.value,pwm2Switch.checked)
//                                        delegateText1.text =  JSON.stringify(my_cmd_simple_obj,null,4)
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
                                    value: 4.8
                                    inputBox.validator: DoubleValidator { top: 10; bottom: 4.80 }
                                    inputBox.text: parseFloat(value.toFixed(2))
                                    contextMenuEnabled: true
                                    onUserSet: {
                                        inputBox.text = parseFloat(value.toFixed(2))
                                        platformInterface.commands.set_pwm2.update(parseFloat(value.toFixed(2)) ,pwm2Switch.checked)
//                                        delegateText1.text = JSON.stringify(my_cmd_simple_obj,null,4)
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
//                                        delegateText1.text =  JSON.stringify(my_cmd_simple_obj,null,4)
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
                                    onUserSet: {
                                        inputBox.text = parseFloat(value.toFixed(1))
                                        platformInterface.commands.set_pwm3.update(parseFloat(value.toFixed(1)), pwm3Switch.checked)

                                        var maxCurrent = 40/(10*pwm3Slider.value)
                                        if (pwm1Slider.value > maxCurrent)
                                        {
                                            pwm1Slider.value = maxCurrent
                                            pwm1Slider.inputBox.text = parseFloat(pwm1Slider.value.toFixed(2))
                                            //pwm1delayTimer.start()
                                            platformInterface.commands.set_pwm1.update(parseFloat(pwm1Slider.value.toFixed(2)),pwm1Switch.checked)
                                        }
//                                        delegateText1.text = JSON.stringify(my_cmd_simple_obj,null,4)
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
            } //end of row
        }
    }
}






