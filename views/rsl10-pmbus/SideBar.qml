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

    property bool output_off: platformInterface.off
    property bool pgood: platformInterface.pgood
    property int temp_status: platformInterface.temp_status
    property int vout_ov_status: platformInterface.vout_ov_status

    property int vout_uv_status: platformInterface.vout_uv_status
    property int iout_oc_status: platformInterface.iout_oc_status
    property int vin_uv_status: platformInterface.vin_uv_status
    property bool vin_low: platformInterface.vin_low

    property bool cml: platformInterface.cml
    property bool vout_sthr: platformInterface.vout_sthr
    property bool vinss_sthr: platformInterface.vinss_sthr
    property bool dcx_s: platformInterface.dcx_s

    property bool ana_oc: platformInterface.ana_oc
    property bool buck_duty: platformInterface.buck_duty
    property bool dig_ratio: platformInterface.dig_ratio
    property bool ana_ratio: platformInterface.ana_ratio
    
    property bool pwm_enabled_side: false

    onPwm_enabled_sideChanged:
    {
        if (pwm_enabled_side === true)
        {
            enableText.text = "PWM ON"
            enableText.color = "lightgreen"
        }
        else
        {
            enableText.text = "PWM OFF"
            enableText.color = "red"
        }

    }

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
            color: "white"
        }

        IconButton {
            id: enableButton
            toolTipText: "The button will enable or disable load."
            source: "qrc:/images/tach.svg"
            iconOpacity: platformInterface.pwm_enabled ? 1 : .5

            onClicked:
            {
                if (platformInterface.pwm_enabled === true)
                {
                    platformInterface.pwm_enabled  = false
                    enableText.text = "PWM OFF"
                    enableText.color = "red"
                }
                else
                {
                    platformInterface.pwm_enabled  = true
                    enableText.text = "PWM ON"
                    enableText.color = "lightgreen"
                }
            }
        }

                SGText {
                    id: enableText
                    text:
                    {
                        if (platformInterface.pwm_enabled === true)
                        {
                            enableText.text = "PWM ON"
                            enableText.color = "lightgreen"
                        }
                        else
                        {
                            enableText.text = "PWM OFF"
                            enableText.color = "red"
                        }
                    }
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMultiplier: 1
                }

        IconButton {
            id: frequencyButton
            toolTipText: "The slider will set the PWM Transient Frequency signal going to the Load."
            value: platformInterface.frequency
            unit: "Hz"
            source: "qrc:/images/tach.svg"
            iconOpacity: platformInterface.pwm_enabled ? 1 : .5

            onClicked:
            {
                frequencyPop.visible = !frequencyPop.visible
                dutyPop.visible = frequencyPop.visible
                platformInterface.frequency  = frequencyPop.value
                platformInterface.duty  = dutyPop.value
            }

            SliderPopup {
                id: frequencyPop
                x: parent.width + sideBarColumn.anchors.margins
                title: "PWM Frequency               "
                unit: "Hz"
                from: 0
                to: 10000
                value: platformInterface.frequency
            }
        }

        IconButton {
            id: dutyButton
            toolTipText: "The slider will set the PWM Positive Duty Cycle % signal going to the Load."
            value: platformInterface.duty
            unit: "%"
            source: "qrc:/images/tach.svg"
            iconOpacity: platformInterface.pwm_enabled ? 1 : .5

            onClicked:  {
                dutyPop.visible = !dutyPop.visible
                frequencyPop.visible = dutyPop.visible
                platformInterface.duty  = dutyPop.value
                platformInterface.frequency  = frequencyPop.value
            }

            SliderPopup {
                id: dutyPop
                x: parent.width + sideBarColumn.anchors.margins
                title: "PWM Positive Duty Cycle"
                unit: "%"
                from: 0
                to: 100
                value: platformInterface.duty
            }
        }

        FaultLight {
            text: "OUTPUT OFF#"
            toolTipText: "Output OFF for any reason"
            status: {
                if(output_off){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "POWER GOOD#"
            toolTipText: "Output Power Good.\nSTATUS_WORD: Bit <3> POWER_GOOD# [Power Good signal is de−asserted]"
            status: {
                if(pgood){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            id: temperature_fault_light
            text: "TEMPERATURE"
            toolTipText: "Temperature.\nDefined in: PMBus Specification Rev 1.3 part II, 15.17. OT_WARN_LIMIT/OT_FAULT_LIMIT"
            status: {
                switch (temp_status)
                {
                    case 0:
                    {
                        temperature_fault_light.text = "TEMPERATURE"
                        return SGStatusLight.Off
                    }
                    case 1:
                    {
                        temperature_fault_light.text = "TEMP WARN"
                        return SGStatusLight.Orange
                    }
                    case 2:
                    {
                        temperature_fault_light.text = "TEMP FAULT"
                        return SGStatusLight.Red
                    }
                    default:
                        temperature_fault_light.text = "TEMPERATURE"
                        return SGStatusLight.Off
                }
            }
        }

        FaultLight {
            id: vout_ov_status_light
            text: "VOUT OV"
            toolTipText: "Output Voltage Over Voltage.\nDefined in: PMBus Specification Rev 1.3 part II, 15.4 VOUT_OV_WARN_LIMIT/VOUT_OV_FAULT_LIMIT"
            status: {
                switch (vout_ov_status)
                {
                    case 0:
                    {
                        vout_ov_status_light.text = "VOUT OV"
                        return SGStatusLight.Off
                    }
                    case 1:
                    {
                        vout_ov_status_light.text = "VOUT OV WARN"
                        return SGStatusLight.Orange
                    }
                    case 2:
                    {
                        vout_ov_status_light.text = "VOUT OV FAULT"
                        return SGStatusLight.Red
                    }
                    default:
                        vout_ov_status_light.text = "VOUT OV"
                        return SGStatusLight.Off
                }
            }
        }

        FaultLight {
            id: vout_uv_status_light
            text: "VOUT UV"
            toolTipText: "Output Voltage Under Voltage.\nDefined in: PMBus Specification Rev 1.3 part II, 15.5 VOUT_UV_WARN_LIMIT/VOUT_UV_FAULT_LIMIT"
            status: {
                switch (vout_uv_status)
                {
                    case 0:
                    {
                        vout_uv_status_light.text = "VOUT UV"
                        return SGStatusLight.Off
                    }
                    case 1:
                    {
                        vout_uv_status_light.text = "VOUT UV WARN"
                        return SGStatusLight.Orange
                    }
                    case 2:
                    {
                        vout_uv_status_light.text = "VOUT UV FAULT"
                        return SGStatusLight.Red
                    }
                    default:
                        vout_uv_status_light.text = "VOUT UV"
                        return SGStatusLight.Off
                }
            }
        }

        FaultLight {
            id: iout_oc_status_light
            text: "IOUT OC"
            toolTipText: "Input Current Over Current.\nDefined in: PMBus Specification Rev 1.3 part II, 15.12 IOUT_OC_WARN_LIMIT/IOUT_OC_FAULT_LIMIT"
            status: {                
                switch (iout_oc_status)
                {
                    case 0:
                    {
                        iout_oc_status_light.text = "IOUT OC"
                        return SGStatusLight.Off
                    }
                    case 1:
                    {
                        iout_oc_status_light.text = "IOUT OC WARN"
                        return SGStatusLight.Orange
                    }
                    case 2:
                    {
                        iout_oc_status_light.text = "IOUT OC FAULT"
                        return SGStatusLight.Red
                    }
                    default:
                        iout_oc_status_light.text = "IOUT OC"
                        return SGStatusLight.Off
                }
            }
        }

        FaultLight {
            id: vin_uv_status_light
            text: "VIN UV"
            toolTipText: "Input Voltage Under Voltage.\nDefined in: PMBus Specification Rev 1.3 part II, 17.5. STATUS_INPUT"
            status: {
                switch (vin_uv_status)
                {
                    case 0:
                    {
                        vin_uv_status_light.text = "VIN UV"
                        return SGStatusLight.Off
                    }
                    case 1:
                    {
                        vin_uv_status_light.text = "VIN UV WARN"
                        return SGStatusLight.Orange
                    }
                    case 2:
                    {
                        vin_uv_status_light.text = "VIN UV FAULT"
                        return SGStatusLight.Red
                    }
                    default:
                        vin_uv_status_light.text = "VIN UV"
                        return SGStatusLight.Off
                }
            }
        }

        FaultLight {
            text: "VIN LOW"
            toolTipText: "Input Voltage Low.\nDefined in: PMBus Specification Rev 1.3 part II, 17.5. STATUS_INPUT"
            status: {
                if(vin_low){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "CML"
            toolTipText: "Communications, Memory or Logic Fault.\nDefined in: PMBus Specification Rev 1.3 part II, 17.1. STATUS_BYTE"
            status: {
                if(cml){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VOUT STHR"
            toolTipText: " VOUT higher than threshold on startup.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(vout_sthr){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "VINSS STHR"
            toolTipText: "VINSS higher than threshold on startup.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(vinss_sthr){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }


        FaultLight {
            text: "DCX S"
            toolTipText: "DCX VOUT UVLO on startup.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(dcx_s){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "ANA OC"
            toolTipText: "Analog OC Protection.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(ana_oc){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "BUCK DUTY"
            toolTipText: "Buck Duty Fault.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(buck_duty){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "DIG RATIO"
            toolTipText: "Digital Ratio Protection.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(dig_ratio){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        FaultLight {
            text: "ANA RATIO"
            toolTipText: "Analog Ratio Protection.\nDefined in: Manufacturer Specific Status 1 command of FD6000"
            status: {
                if(ana_ratio){SGStatusLight.Red}
                else {SGStatusLight.Off}
            }
        }

        Button {
            id: clearFaultsButton
            text: "Clear \n faults"

            Layout.fillWidth: true

            onClicked:
            {
                platformInterface.clear_faults.update()
            }
        }
    }
}
