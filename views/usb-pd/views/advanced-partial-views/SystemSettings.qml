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
import "../../sgwidgets"

Item {
    id: root
    height: 275
    width: parent.width
    anchors {
        left: parent.left
    }

    Item {
        id: leftColumn
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width/3

        Item {
            id: margins1
            anchors {
                fill: parent
                margins: 15
            }



            Text {
                id: faultText
                text: "<b>Faults</b>"
                font {
                    pixelSize: 16
                }
                anchors {
                    top: margins1.top
                    topMargin: 30
                }
            }

            SGSegmentedButtonStrip {
                id: faultProtection
                anchors {
                    top: faultText.bottom
                    topMargin: 10
                    left: margins1.left
                    leftMargin: 95
                    right: margins1.right
                    rightMargin: 10
                }
                label: "Fault Protection:"
                labelFontSize: 12
                textColor: "#666"
                activeTextColor: "white"
                radius: 4
                buttonHeight: 25
                buttonImplicitWidth:0

                segmentedButtons: GridLayout {
                    columnSpacing: 2


                    SGSegmentedButton{
                        text: qsTr("Retry")
                        checked: platformInterface.usb_pd_protection_action.action === "retry"

                        onClicked: {
                            platformInterface.set_protection_action.update("retry");
                        }
                    }

                    SGSegmentedButton{
                        text: qsTr("None")
                        checked: platformInterface.usb_pd_protection_action.action === "nothing"

                        onClicked: {
                            platformInterface.set_protection_action.update("nothing");
                        }
                    }
                }
            }

            SGSlider {
                id: inputFault
                label: "Fault when input below:"
                anchors {
                    left: margins1.left
                    leftMargin: 45
                    top: faultProtection.bottom
                    topMargin: 15
                    right: inputFaultInput.left
                    rightMargin: 10
                }
                from: 0
                to: 20
                labelTopAligned: true
                startLabel: "0V"
                endLabel: "20V"
                value: platformInterface.input_under_voltage_notification.minimum_voltage
                onSliderMoved: {
                    platformInterface.set_minimum_input_voltage.update(value);
                }
            }

            SGSubmitInfoBox {
                id: inputFaultInput
                showButton: false
                anchors {
                    verticalCenter: inputFault.verticalCenter
                    verticalCenterOffset:-7
                    right: parent.right
                }
                infoBoxWidth: 40
                value: platformInterface.input_under_voltage_notification.minimum_voltage.toFixed(0)
                onApplied: platformInterface.set_minimum_input_voltage.update(inputFaultInput.intValue);
            }

            SGSlider {
                id: tempFault
                label: "Fault when temperature above:"
                anchors {
                    left: parent.left
                    top: inputFault.bottom
                    topMargin: 10
                    right: tempFaultInput.left
                    rightMargin: 15
                }
                from: -40
                to: 135
                labelTopAligned: true
                startLabel: "-40°C"
                endLabel: "135°C"
                value: platformInterface.set_maximum_temperature_notification.maximum_temperature
                onSliderMoved: {
                    platformInterface.set_maximum_temperature.update(value);
                }
            }

            SGSubmitInfoBox {
                id: tempFaultInput
                showButton: false
                anchors {
                    verticalCenter: tempFault.verticalCenter
                    verticalCenterOffset:-7
                    right: parent.right
                }
                infoBoxWidth: 40
                value: tempFault.value.toFixed(0)
                onApplied: platformInterface.set_maximum_temperature.update(intValue); // slider will be updated via notification
            }
        }

        SGLayoutDivider {
            position: "right"
        }
    }

    Item {
        id: middleColumn
        anchors {
            left: leftColumn.right
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width/3


        Item {
            id: margins2
            anchors {
                fill: parent
                margins: 15
            }

            Text {
                id: inputFoldback
                text: "<b>Input Foldback</b>"
                font {
                    pixelSize: 16
                }
            }

            SGSwitch {
                id: inputFoldbackSwitch
                anchors {
                    right: parent.right
                    verticalCenter: inputFoldback.verticalCenter
                }
                checkedLabel: "On"
                uncheckedLabel: "Off"
                switchHeight: 20
                switchWidth: 46
                checked: platformInterface.foldback_input_voltage_limiting_event.input_voltage_foldback_enabled
                onToggled: platformInterface.set_input_voltage_foldback.update(checked, platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage,
                                platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power)
            }

            SGSlider {
                id: foldbackLimit
                label: "Limit below:"
                value: platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage
                anchors {
                    left: parent.left
                    leftMargin: 61
                    top: inputFoldback.bottom
                    topMargin: 13
                    right: foldbackLimitInput.left
                    rightMargin: 10
                }
                from: 0
                to: 20
                labelTopAligned: true
                startLabel: "0V"
                endLabel: "20V"
                //copy the current values for other stuff, and add the new slider value for the limit.
                onSliderMoved: platformInterface.set_input_voltage_foldback.update(platformInterface.foldback_input_voltage_limiting_event.input_voltage_foldback_enabled,
                                 value,
                                platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power)
            }

            SGSubmitInfoBox {
                id: foldbackLimitInput
                showButton: false
                anchors {
                    verticalCenter: foldbackLimit.verticalCenter
                    verticalCenterOffset: -7
                    right: parent.right
                }
                infoBoxWidth: 40
                value: platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage.toFixed(0)
                onApplied: platformInterface.set_input_voltage_foldback.update(platformInterface.foldback_input_voltage_limiting_event.input_voltage_foldback_enabled,
                                                                               intValue,
                                                                              platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power)
            }

            SGComboBox {
                id: limitOutput
                label: "Limit output power to:"
                model: ["15","27", "36", "45","60","100"]
                anchors {
                    left: parent.left
                    top: foldbackLimit.bottom
                    topMargin: 15
                }
                comboBoxWidth: 75
                //when changing the value
                onActivated: {
                    console.log("setting input power foldback to ",limitOutput.comboBox.currentText);
                    platformInterface.set_input_voltage_foldback.update(platformInterface.foldback_input_voltage_limiting_event.input_voltage_foldback_enabled,
                                                                        platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage,
                                                                                 limitOutput.comboBox.currentText)
                }

                property var currentFoldbackOuput: platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power
                onCurrentFoldbackOuputChanged: {
                    console.log("got a new min power setting",platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power);
                    limitOutput.currentIndex = limitOutput.comboBox.find( parseInt (platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power))
                }
            }
            Text{
                id: foldbackTempUnits
                text: "W"
                anchors {
                    left: limitOutput.right
                    leftMargin: 5
                    verticalCenter: limitOutput.verticalCenter
                    verticalCenterOffset: 0
                }
            }

            SGDivider {
                id: div1
                anchors {
                    top: limitOutput.bottom
                    topMargin: 15
                }
            }

            Text {
                id: tempFoldback
                text: "<b>Temperature Foldback</b>"
                font {
                    pixelSize: 16
                }
                anchors {
                    top: div1.bottom
                    topMargin: 15
                }
            }

            SGSwitch {
                id: tempFoldbackSwitch
                anchors {
                    right: parent.right
                    verticalCenter: tempFoldback.verticalCenter
                }
                checkedLabel: "On"
                uncheckedLabel: "Off"
                switchHeight: 20
                switchWidth: 46
                checked: platformInterface.foldback_temperature_limiting_event.temperature_foldback_enabled
                onToggled:{
                    console.log("sending temp foldback update command from tempFoldbackSwitch");
                    platformInterface.set_temperature_foldback.update(tempFoldbackSwitch.checked,
                                                                                    platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature,
                                                                                    platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature_power);
                }
            }

            SGSlider {
                id: foldbackTemp
                label: "Limit above:"
                anchors {
                    left: parent.left
                    leftMargin: 60
                    top: tempFoldback.bottom
                    topMargin: 15
                    right: foldbackTempInput.left
                    rightMargin: 10
                }
                from: -40
                to: 100
                labelTopAligned: true
                startLabel: "-40°C"
                endLabel: "100°C"
                value: platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature
                onSliderMoved:{
                    console.log("sending temp foldback update command from foldbackTempSlider");
                    platformInterface.set_temperature_foldback.update(platformInterface.foldback_temperature_limiting_event.temperature_foldback_enabled,
                                                                                  foldbackTemp.value,
                                                                                  platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature_power)
                }

            }


            SGSubmitInfoBox {
                id: foldbackTempInput
                showButton: false
                minimumValue: -40
                maximumValue: 100
                anchors {
                    verticalCenter: foldbackTemp.verticalCenter
                    verticalCenterOffset: -7
                    right: parent.right
                }
                infoBoxWidth: 40
                value: platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature.toFixed(0)
                onApplied: platformInterface.set_temperature_foldback.update(platformInterface.foldback_temperature_limiting_event.temperature_foldback_enabled,
                                                                             intValue,
                                                                             platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature_power)
            }


            SGComboBox {
                id: limitOutput2
                label: "Limit output power to:"
                model: ["15","27", "36", "45","60","100"]
                anchors {
                    left: parent.left
                    top: foldbackTemp.bottom
                    topMargin: 10
                }
                comboBoxWidth: 75
                //when the value is changed by the user
                onActivated: {
                    console.log("sending temp foldback update command from limitOutputComboBox");
                    platformInterface.set_temperature_foldback.update(platformInterface.foldback_temperature_limiting_event.temperature_foldback_enabled,
                                                                                 platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature,
                                                                                 limitOutput2.currentText)
                }

                property var currentFoldbackOuput: platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature_power

                onCurrentFoldbackOuputChanged: {
                    limitOutput2.currentIndex = limitOutput2.comboBox.find( parseInt (platformInterface.foldback_temperature_limiting_event.foldback_maximum_temperature_power))
                }
            }

            Text{
                id: foldbackTempUnits2
                text: "W"
                anchors {
                    left: limitOutput2.right
                    leftMargin: 5
                    verticalCenter: limitOutput2.verticalCenter
                }
            }
        }
}

    Item{
        id: rightColumn
        anchors {
            right: root.right
            top: root.top
            bottom: root.bottom
        }
        width: root.width/3

        SGStatusListBox {
            id: currentFaults
            height: rightColumn.height/2
            width: rightColumn.width
            title: "Active Faults:"
            model: faultListModel

            property var underVoltageEvent: platformInterface.input_under_voltage_notification
            property var overTempEvent: platformInterface.over_temperature_notification
            property string stateMessage:""

            onUnderVoltageEventChanged: {
                if (underVoltageEvent.state === "below"){   //add input voltage message to list
                    stateMessage = "Input is below ";
                    stateMessage += platformInterface.input_under_voltage_notification.minimum_voltage;
                    stateMessage += " V";
                    //if there's already an input voltage fault in the list, remove it (there can only be one at a time)
                    for(var i = 0; i < faultListModel.count; ++i){
                        var theItem = faultListModel.get(i);
                        if (theItem.type === "voltage"){
                            faultListModel.remove(i);
                        }
                    }
                    faultListModel.append({"type":"voltage", "portName":"0", "status":stateMessage});

                }
                else{                                       //remove input voltage message from list
                    for(var j = 0; j < faultListModel.count; ++j){
                        var theListItem = faultListModel.get(j);
                        if (theListItem.type === "voltage"){
                            faultListModel.remove(j);
                        }
                    }
                }
            }

            onOverTempEventChanged: {
                if (overTempEvent.state === "above"){   //add temp  message to list
                    stateMessage = platformInterface.over_temperature_notification.port
                    stateMessage += " temperature is above ";
                    stateMessage += platformInterface.over_temperature_notification.maximum_temperature;
                    stateMessage += " °C";
                    faultListModel.append({"type":"temperature", "portName":platformInterface.over_temperature_notification.port, "status":stateMessage});
                }
                else{                                       //remove temp message for the correct port from list
                    for(var i = 0; i < faultListModel.count; ++i){
                        var theItem = faultListModel.get(i);
                        if (theItem.type === "temperature" && theItem.portName === platformInterface.over_temperature_notification.port){
                            faultListModel.remove(i);
                        }
                    }
                }
            }

            ListModel{
                id:faultListModel
            }
        }



        SGOutputLogBox {
            id: faultHistory
            height: rightColumn.height/2
            anchors {
                top: currentFaults.bottom
            }
            width: rightColumn.width
            title: "Fault History:"

            property var underVoltageEvent: platformInterface.input_under_voltage_notification
            property var overTempEvent: platformInterface.over_temperature_notification
            property string stateMessage:""

            onUnderVoltageEventChanged: {
                if (underVoltageEvent.state === "below"){   //add input voltage message to list
                    stateMessage = "Input is below ";
                    stateMessage += platformInterface.input_under_voltage_notification.minimum_voltage;
                    stateMessage += " V";
                    console.log("adding message to fault history",stateMessage);
                    faultHistory.input = stateMessage;

                }
                else{
//                    stateMessage = "Input voltage fault ended at ";
//                    stateMessage += platformInterface.input_under_voltage_notification.minimum_voltage;
//                    stateMessage += " V";
//                    faultHistory.input = stateMessage;
                }
            }

            onOverTempEventChanged: {
                if (overTempEvent.state === "above"){   //add temp  message to list
                    stateMessage = platformInterface.over_temperature_notification.port
                    stateMessage += " temperature is above ";
                    stateMessage += platformInterface.over_temperature_notification.maximum_temperature;
                    stateMessage += " °C";
                    faultHistory.input = stateMessage;
                }
                else{
//                    stateMessage = platformInterface.over_temperature_notification.port
//                    stateMessage += " temperature went below ";
//                    stateMessage += platformInterface.over_temperature_notification.maximum_temperature;
//                    stateMessage += " °C";
//                    faultHistory.input = stateMessage;
                }


            }
        }
    }
}
