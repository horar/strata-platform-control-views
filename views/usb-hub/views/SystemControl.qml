/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import "../sgwidgets"

Item {
    id: systemControls

    property bool debugLayout: false
    property real ratioCalc: systemControls.width / 1200

    width: parent.width / parent.height > initialAspectRatio ? parent.height * initialAspectRatio : parent.width
    height: parent.width / parent.height < initialAspectRatio ? parent.width / initialAspectRatio : parent.height

    anchors {
        fill: parent
    }
    Rectangle{
        id:background
        color: "#145A74"
        anchors.fill:systemControls
    }

    Column{
        id:controlColumn
        anchors.top: systemControls.top
        anchors.topMargin: 50
        anchors.left: systemControls.left
        anchors.leftMargin: systemControls.width/4
        anchors.right: systemControls.right
        anchors.rightMargin: systemControls.width/4
        anchors.bottom: systemControls.bottom
        anchors.bottomMargin: 50

        spacing: 25

        Rectangle{
            id:powerGroup
            color:"lightYellow"
            height:130
            width: controlColumn.width
            radius:5

            Text {
                id: powerLabel
                text: "Power Management"
                font {
                    pixelSize: 24
                }
                anchors {
                    top: powerGroup.top
                    topMargin: 15
                    left: powerGroup.left
                    leftMargin: 10
                }
            }

            Text{
                id: powerNegotiationLabel
                text: "Negotiation Scheme:"
                anchors {
                    left: powerGroup.left
                    leftMargin: 112
                    top: powerLabel.bottom
                    topMargin: 10
                }
            }
            ColumnLayout{
                id:powerNegotiationColumn
                anchors.left: powerNegotiationLabel.right
                anchors.leftMargin: 10
                anchors.top: powerNegotiationLabel.top
                anchors.topMargin: -5
                spacing: -5

                property var negotiationTypeChanged: platformInterface.power_negotiation.negotiation_type

                onNegotiationTypeChangedChanged:{
                    if (platformInterface.power_negotiation.negotiation_type === "dynamic"){
                        dynamicNegotiationButton.checked = true;
                        //fcfsNegotiationButton.checked = false;
                        //priorityNegotiationButton.checked = false;
                    }
                    else if (platformInterface.power_negotiation.negotiation_type === "first_come_first_served"){
                        //dynamicNegotiationButton.checked = false;
                        fcfsNegotiationButton.checked = true;
                        //priorityNegotiationButton.checked = false;
                    }
                    else if (platformInterface.power_negotiation.negotiation_type === "priority"){
                        //dynamicNegotiationButton.checked = false;
                        //fcfsNegotiationButton.checked = false;
                        priorityNegotiationButton.checked = true;
                    }


                }

                RadioButton {
                    id: dynamicNegotiationButton
                    text: "Dynamic"
                    checked: true
                    indicator: Rectangle{
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        border.color: dynamicNegotiationButton.down ? "lightgrey" : "black"
                        color: dynamicNegotiationButton.checked ? "#145A74": "ivory"
                    }

                    onClicked: {
                        platformInterface.set_power_negotiation.update("dynamic");
                    }
                }
                RadioButton {
                    id: fcfsNegotiationButton
                    text: "First Come First Serve"
                    indicator: Rectangle{
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        border.color: fcfsNegotiationButton.down ? "#17a81a" : "black"
                        color: fcfsNegotiationButton.checked ? "#145A74": "ivory"
                    }
                    onClicked: {
                        platformInterface.set_power_negotiation.update("first_come_first_served");
                    }
                }

            }
        }






        Rectangle{
            id:faultGroup
            color:"lightYellow"
            height:200
            width: parent.width
            radius: 5

            Text {
                id: faultLabel
                text: "Faults"
                font {
                    pixelSize: 24
                }
                anchors {
                    top: faultGroup.top
                    topMargin: 15
                    left: faultGroup.left
                    leftMargin: 10
                }
            }

            Text{
                id: faultProtectionLabel
                text: "Protection:"
                anchors {
                    left: faultGroup.left
                    leftMargin: 170
                    top: faultLabel.bottom
                    topMargin: 10
                }
            }
            ColumnLayout{
                id:faultProtectionColumn
                anchors.left: faultProtectionLabel.right
                anchors.leftMargin: 10
                anchors.top: faultProtectionLabel.top
                anchors.topMargin: -5
                spacing: -5

                RadioButton {
                    id: shutdownProtectionButton
                    text: "Shutdown"
                    checked: platformInterface.usb_pd_protection_action.action === "shutdown"
                    indicator: Rectangle{
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        border.color: shutdownProtectionButton.down ? "lightgrey" : "black"
                        color: shutdownProtectionButton.checked ? "#145A74": "ivory"
                    }
                    onClicked: {
                        platformInterface.set_protection_action.update("shutdown");
                    }
                }
                RadioButton {
                    id: retryProtectinButton
                    text: "Retry"
                    checked: platformInterface.usb_pd_protection_action.action === "retry"
                    indicator: Rectangle{
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        border.color: retryProtectinButton.down ? "lightgrey" : "black"
                        color: retryProtectinButton.checked ? "#145A74": "ivory"
                    }

                    onClicked: {
                        platformInterface.set_protection_action.update("retry");
                    }
                }
                RadioButton {
                    id: noProtectionButton
                    text: "None"
                    checked: platformInterface.usb_pd_protection_action.action === "nothing"
                    indicator: Rectangle{
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        border.color: noProtectionButton.down ? "lightgrey" : "black"
                        color: noProtectionButton.checked ? "#145A74": "ivory"
                    }

                    onClicked: {
                        platformInterface.set_protection_action.update("nothing");
                    }
                }
            }


            SGSlider {
                id: tempFault
                label: "Fault when temperature is above:"
                labelTopAligned: true
                anchors {
                    left: faultGroup.left
                    leftMargin: 35
                    top: faultProtectionColumn.bottom
                    topMargin: 10
                    right:tempFaultInput.left
                    rightMargin: 10

                }
                from: -20
                to: 125
                startLabel: "-20°C"
                endLabel: "125°C"
                value: platformInterface.set_maximum_temperature_notification.maximum_temperature
                onMoved: {
                    platformInterface.set_maximum_temperature.update(value);
                }
            }

            SGSubmitInfoBox {
                id: tempFaultInput
                showButton: false
                anchors {
                    verticalCenter: tempFault.verticalCenter
                    verticalCenterOffset: -7
                    right:faultGroup.right
                    rightMargin: 35
                }
                value: tempFault.value.toFixed(0)
                onApplied: platformInterface.set_maximum_temperature.update(input); // slider will be updated via notification
            }
        }

        Rectangle{
            id:foldbackGroup
            color:"lightYellow"
            height:220
            width: parent.width
            radius:5

            Text {
                id: tempFoldbackLabel
                text: "Temperature Foldback"
                font {
                    pixelSize: 24
                }
                anchors {
                    top: foldbackGroup.top
                    topMargin: 15
                    left: foldbackGroup.left
                    leftMargin: 10
                }
            }

            Text{
                id: temperatureFoldbackActiveLabel
                text: "Active:"
                anchors {
                    left: foldbackGroup.left
                    leftMargin: 195
                    top: tempFoldbackLabel.bottom
                    topMargin: 10
                }
            }

            SGSwitch {
                id: tempFoldbackSwitch
                anchors {
                    left: temperatureFoldbackActiveLabel.right
                    leftMargin: 10
                    verticalCenter: temperatureFoldbackActiveLabel.verticalCenter
                }
                grooveFillColor: "#145A74"
                switchHeight: 20
                switchWidth: 46
                checked: platformInterface.temperature_foldback_notification.temperature_foldback_enabled
                onToggled:{
                    console.log("sending temp foldback update command from tempFoldbackSwitch");
                    platformInterface.set_temperature_foldback.update(tempFoldbackSwitch.checked,
                                                                      platformInterface.temperature_foldback_notification.foldback_maximum_temperature,
                                                                      platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage,
                                                                      platformInterface.temperature_foldback_notification.hysteresis);
                }
            }

            SGSlider {
                id: foldbackTemp
                label: "When any port temperature is above:"
                labelTopAligned: true
                anchors {
                    left: foldbackGroup.left
                    leftMargin: 10
                    top: temperatureFoldbackActiveLabel.bottom
                    topMargin: 10
                    right: foldbackTempInput.left
                    rightMargin: 10
                }
                from: 0
                to: 125
                startLabel: "0°C"
                endLabel: "125°C"
                value: platformInterface.temperature_foldback_notification.foldback_maximum_temperature
                onMoved:{
                    console.log("sending temp foldback update command from foldbackTempSlider");
                    platformInterface.set_temperature_foldback.update(platformInterface.temperature_foldback_notification.temperature_foldback_enabled,
                                                                      foldbackTemp.value,
                                                                      platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage,
                                                                      platformInterface.temperature_foldback_notification.hysteresis);
                }

            }


            SGSubmitInfoBox {
                id: foldbackTempInput
                showButton: false
                anchors {
                    verticalCenter: foldbackTemp.verticalCenter
                    verticalCenterOffset: -7
                    right:foldbackGroup.right
                    rightMargin: 35
                }
                value: platformInterface.temperature_foldback_notification.foldback_maximum_temperature.toFixed(0)
                onApplied:  platformInterface.set_temperature_foldback.update(platformInterface.temperature_foldback_notification.temperature_foldback_enabled,
                                                                  foldbackTempInput.currentText,
                                                                  platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage,
                                                                  platformInterface.temperature_foldback_notification.hysteresis)
            }

            SGSlider {
                id: foldbackTempLimit
                label: "Cut the port output power by:"
                labelTopAligned: true
                anchors {
                    left: foldbackGroup.left
                    leftMargin: 55
                    top: foldbackTemp.bottom
                    topMargin: 10
                    right:foldbackTempLimitInput.left
                    rightMargin:10
                }
                from: 1
                to: 100
                startLabel: "0%"
                endLabel: "99%"

                //N.B. Not the correct API call
                value: platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage
                onMoved:{
                    //console.log("sending temp foldback update command from foldbackTempSlider");
                    platformInterface.set_temperature_foldback.update(platformInterface.temperature_foldback_notification.temperature_foldback_enabled,
                                                                      platformInterface.temperature_foldback_notification.foldback_maximum_temperature,
                                                                      limitOutput2.currentText,
                                                                      platformInterface.temperature_foldback_notification.hysteresis);
                }

            }

            SGSubmitInfoBox {
                id: foldbackTempLimitInput
                showButton: false
                anchors {
                    verticalCenter: foldbackTempLimit.verticalCenter
                    verticalCenterOffset: -7
                    right: foldbackGroup.right
                    rightMargin:35
                }
                //N.B. Not the correct API call
                value: platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage.toFixed(0)
                onApplied: platformInterface.set_temperature_foldback.update(platformInterface.temperature_foldback_notification.temperature_foldback_enabled,
                                                                  platformInterface.temperature_foldback_notification.foldback_maximum_temperature,
                                                                  limitOutput2.currentText,
                                                                  platformInterface.temperature_foldback_notification.hysteresis);
            }



            SGSlider {
                id: tempFoldbackHysteresis
                label: "End limiting on a decrease of:"
                labelTopAligned: true
                anchors {
                    left: foldbackGroup.left
                    leftMargin: 55
                    top: foldbackTempLimit.bottom
                    topMargin: 10
                    right:tempFoldbackHysteresisInput.left
                    rightMargin:10
                }
                from: 25
                to: 200
                startLabel: "1°C"
                endLabel: "10°C"
                value: platformInterface.temperature_foldback_notification.temperature_hysteresis
                onMoved:{
                    //console.log("sending temp foldback update command from foldbackTempSlider");
                    platformInterface.set_temperature_foldback.update(platformInterface.temperature_foldback_notification.temperature_foldback_enabled,
                                                                      platformInterface.temperature_foldback_notification.foldback_maximum_temperature,
                                                                      platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage,
                                                                     tempFoldbackHysteresis.value)
                }

            }

            SGSubmitInfoBox {
                id: tempFoldbackHysteresisInput
                showButton: false
                anchors {
                    verticalCenter: tempFoldbackHysteresis.verticalCenter
                    verticalCenterOffset: -7
                    right:foldbackGroup.right
                    rightMargin:35
                }
                value: platformInterface.temperature_foldback_notification.temperature_hysteresis.toFixed(0)
                onApplied: platformInterface.set_temperature_foldback.update(platformInterface.temperature_foldback_notification.temperature_foldback_enabled,
                                                                             platformInterface.temperature_foldback_notification.foldback_maximum_temperature,
                                                                             platformInterface.temperature_foldback_notification.foldback_power_reduction_percentage,
                                                                             tempFoldbackHysteresisInput.currentText)
            }
    }



    }


}
