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
        Help.registerTarget(pwm1SwitchLabel, "Toggle the state of a single IO output pin on the microcontroller. The IO Input control will reflect the state of the IO Output when the next Periodic Notification" + " \"" + "my_cmd_simple_periodic" + "\" "  + "is sent from the firmware to Strata.", 1, "BasicControlHelp")
        Help.registerTarget(pwm1SliderLabel, "Sets the Digital to Analog Converter (DAC) pin of the microcontroller between 0 and full scale.", 2, "BasicControlHelp")
   }

    MouseArea {
        id: containMouseArea
        anchors.fill: root
        z: 0

        onClicked: {
            forceActiveFocus()
        }
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

//    property var my_cmd_simple_obj: {
//        "cmd": "my_cmd_simple",
//        "payload": {
//            "io": io.checked,
//            "dac": parseFloat(dac.value.toFixed(2))
//        }
//    }

    ColumnLayout {
        width: parent.width/2
        height: parent.height/1.1
        //anchors.centerIn: parent
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.topMargin: 250
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20

        Rectangle{
            width: parent.width
            height: parent.height
            //color: "red"
        }

    }

    ColumnLayout {
        width: parent.width/2
        height: parent.height/1.1
        //anchors.centerIn: parent
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.topMargin: 250
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20

        Rectangle{
            width: parent.width
            height: parent.height
            //color: "blue"
        }

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
                                    from: 0.6
                                    to: 4.5
                                    stepSize: 0.1
                                    value: 0.6
                                    inputBox.validator: DoubleValidator { top: 4.5; bottom: 0.6 }
                                    inputBox.text:  parseFloat(pwm1Slider.value.toFixed(2))
                                    contextMenuEnabled: true
                                    onUserSet: {
                                        inputBox.text = parseFloat(value.toFixed(2))
                                        platformInterface.commands.set_pwm1.update(parseFloat(value.toFixed(2)),pwm1Switch.checked)
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
                                    from: 4.5
                                    to: 9.5
                                    stepSize: 0.0196
                                    value: 4.5
                                    inputBox.validator: DoubleValidator { top: 9.50; bottom: 4.50 }
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
                                text: "Time (ms)"
                                font.bold: true
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGSlider {
                                    id: pwm3Slider
                                    width: 250
                                    from: 0.5
                                    to: 5
                                    stepSize: 0.1
                                    value: 0.5
                                    inputBox.validator: DoubleValidator { top: 5.00; bottom: 0.5 }
                                    inputBox.text: parseFloat(value.toFixed(2))
                                    contextMenuEnabled: true
                                    onUserSet: {
                                        inputBox.text = parseFloat(value.toFixed(2))
                                        platformInterface.commands.set_pwm3.update(parseFloat(value.toFixed(2)), pwm3Switch.checked)
//                                        delegateText1.text = JSON.stringify(my_cmd_simple_obj,null,4)
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






