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

import "qrc:/js/help_layout_manager.js" as Help
import "sgwidgets/"

import tech.strata.sgwidgets 1.0

Rectangle {
    id: sideBar
    color: "#454545"
    implicitWidth: 70
    implicitHeight: parent.height
    Layout.fillHeight: true

    property var status_word_b3: platformInterface.status_word.b3
    property var status_word_b5: platformInterface.status_word.b5
    property var status_word_b6: platformInterface.status_word.b6
    property var status_word_b7: platformInterface.status_word.b7
    property var status_vout_b3: platformInterface.status_vout.b3
    property var status_vout_b4: platformInterface.status_vout.b4
    property var status_vout_b7: platformInterface.status_vout.b7
    property var status_iout_b5: platformInterface.status_iout.b5
    property var status_iout_b7: platformInterface.status_iout.b7
    property var status_input_b3: platformInterface.status_input.b3
    property var status_input_b4: platformInterface.status_input.b4
    property var status_input_b5: platformInterface.status_input.b5
    property var status_temperature_b6: platformInterface.status_temperature.b6
    property var status_temperature_b7: platformInterface.status_temperature.b7
    property var status_cml_b5: platformInterface.status_cml.b5
    property var status_cml_b6: platformInterface.status_cml.b6
    property var status_cml_b7: platformInterface.status_cml.b7

    Component.onCompleted: {
    }

    ColumnLayout {
        id: sideBarColumn
        anchors {
            fill: parent
            margins: 15
        }
        spacing: 5

        SGText {
            text: "Quick View"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            fontSizeMultiplier: 1
            color: "lightgreen"
        }

        SGText {
            text: "LOAD"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            fontSizeMultiplier: 1
            color: "white"
        }

        IconButton {
            id: frequencyButton
            toolTipText: "The slider will set the PWM Transient Frequency signal going to the Load. PWM Frequency function 0 -> 0 kHz, 1 -> 2.5 kHz, 2 -> 4 kHz, 3 -> 5 kHz, 4 -> 8 kHz, 5 -> 10 kHz"
            value:if(frequencyPop.value == 0 ){0}
                  else if(frequencyPop.value == 1 ){2.5}
                  else if(frequencyPop.value == 2 ){4}
                  else if(frequencyPop.value == 3 ){5}
                  else if(frequencyPop.value == 4 ){8}
                  else if(frequencyPop.value == 5 ){10}
            unit: "Khz"
            source: "qrc:/images/tach.svg"
            iconOpacity: frequencyPop.visible ? .5 : 1

            onClicked:  {
                frequencyPop.visible = !frequencyPop.visible
                platformInterface.frequency  = frequencyPop.value
            }

            SliderPopup {
                id: frequencyPop
                x: parent.width + sideBarColumn.anchors.margins
                title: "PWM Frequency"
                unit: "Value"
                from: 0
                to: 5
                value: 0
            }
        }

        IconButton {
            id: dutyButton
            toolTipText: "The slider will set the PWM Positive Duty Cycle % signal going to the Load."
            value: dutyPop.value
            unit: "%"
            source: "qrc:/images/tach.svg"
            iconOpacity: dutyPop.visible ? .5 : 1

            onClicked:  {
                dutyPop.visible = !dutyPop.visible
                platformInterface.duty  = dutyPop.value
            }

            SliderPopup {
                id: dutyPop
                x: parent.width + sideBarColumn.anchors.margins
                title: "PWM Positive Duty Cycle"
                unit: "%"
                from: 0
                to: 80
                value: 0
            }
        }

        FaultLight {
            text: "POWER GOOD#"
            toolTipText: "STATUS_WORD: Bit <3> POWER_GOOD# [Power Good signal is de−asserted]"
            status: {
                if(status_word_b3 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "INPUT"
            toolTipText: "STATUS_WORD: Bit <5> INPUT [Input Voltage/Current/Power fault or warning has occurred]"
            status: {
                if(status_word_b5 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "IOUT/POUT"
            toolTipText: "STATUS_WORD: Bit <6> IOUT/POUT [Output current/power fault or warning has occurred]"
            status: {
                if(status_word_b6 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VOUT"
            toolTipText: "STATUS_WORD: Bit <7> VOUT [Output voltage fault or warning has occurred]"
            status: {
                if(status_word_b7 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VOUT MAX"
            toolTipText: "STATUS_VOUT: Bit <3> VOUT_MAX Warning [Unit commanded to set VOUT value greater than allowed by VOUT_MAX command]"
            status: {
                if(status_vout_b3 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VOUT UV FAULT"
            toolTipText: "STATUS_VOUT: Bit <4> VOUT_UV_FAULT [Output UnderVoltage Fault]"
            status: {
                if(status_vout_b4 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VOUT OV FAULT"
            toolTipText: "STATUS_VOUT: Bit <7> VOUT_OV_FAULT [Output OverVoltage Fault]"
            status: {
                if(status_vout_b7 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "IOUT OC WARNING"
            toolTipText: "STATUS_IOUT: Bit <5> IOUT_OC_WARNING [Output OverCurrent Warning]"
            status: {
                if(status_iout_b5 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "IOUT OC FAULT"
            toolTipText: "STATUS_IOUT: Bit <7> IOUT_OC_FAULT [Output OverCurrent Fault]"
            status: {
                if(status_iout_b7 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "UNIT OFF LV"
            toolTipText: "STATUS_INPUT: Bit <3> Unit OFF for Insufficient Input Voltage"
            status: {
                if(status_input_b3 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }


        FaultLight {
            text: "VIN UV FAULT"
            toolTipText: "STATUS_INPUT: Bit <4> VIN_UV_FAULT [Input UnderVoltage Fault]"
            status: {
                if(status_input_b4 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VIN UV WARNING"
            toolTipText: "STATUS_INPUT: Bit <5> VIN_UV_WARNING [58h sets VIN_UV_WARN_LIMIT]"
            status: {
                if(status_input_b5 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "OT WARNING"
            toolTipText: "STATUS_TEMPERATURE: Bit <6> OT_WARNING [OverTemperature Warning]"
            status: {
                if(status_temperature_b6 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "OT FAULT"
            toolTipText: "STATUS_TEMPERATURE: Bit <7> OT_FAULT [OverTemperature Fault]"
            status: {
                if(status_temperature_b7 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "CML MEMORY"
            toolTipText: "STATUS_CML: Bit <5> Packet Error Check Failed Bit<4> Memory Fault Detected"
            status: {
                if(status_cml_b5 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "CML DATA"
            toolTipText: "STATUS_CML: Bit <6> Invalid or Unsupported Data Received"
            status: {
                if(status_cml_b6 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "CML COMMAND"
            toolTipText: "STATUS_CML: Bit <7> Invalid or Unsupported Command Received"
            status: {
                if(status_cml_b7 === 1){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }
    }
}

