/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

import "qrc:/sgwidgets"
import "sgwidgets/"
import "qrc:/js/help_layout_manager.js" as Help

import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3

import tech.strata.fonts 1.0
import tech.strata.sgwidgets 0.9 as Widget09
import tech.strata.sgwidgets 1.0

Item {
    anchors.fill: parent
    property string vinlable: ""
    property bool hideEcoSwitch: false
    property string warningVin: multiplePlatform.warningHVVinLable

    FontLoader {
        id: icons
        source: "sgwidgets/fonts/sgicons.ttf"
    }

    Component.onCompleted:  {
        Help.registerTarget(efficiencyGraph, "Efficiency (η) is plotted in real time.", 0, "advanceHelp")
        Help.registerTarget(specific1Text, "PMBus: STATUS_MFR_SPECIFIC1.", 1, "advanceHelp")
        Help.registerTarget(resetErrorButton, "PMBus: CLEAR_FAULTS. Clears all fault status registers to 0x00 and releases SMBALERT#.", 2, "advanceHelp")
        Help.registerTarget(setParametersButton, "Save all user parameters to volatile memory.", 3, "advanceHelp")
        Help.registerTarget(writeParametersButton, "PMBus: WRITE_PROTECT. Allow writes to all registers. Is used to control writing to the PMBus device. Provide protection against accidental changes. Bits <7:0> 0010 0000 − Disable all writes except to the WRITE_PROTECT, OPERATION, ON_OFF_CONFIG and VOUT_COMMAND commands", 4, "advanceHelp")
        Help.registerTarget(voutOVFaultResponseCombo, "PMBus: VOUT_OV_FAULT_RESPONSE. Retry, ignore.", 6, "advanceHelp")
        Help.registerTarget(voutUVFaultResponseCombo, "PMBus: VOUT_UV_FAULT_RESPONSE. Retry, ignore.", 7, "advanceHelp")
        Help.registerTarget(ioutOCFaultResponseCombo, "PMBus: IOUT_OT_FAULT_RESPONSE. Retry, ignore.", 8, "advanceHelp")
        Help.registerTarget(overTemperatureFaultSlider, "PMBus: OT_FAULT_LIMIT. Sets the temperature of the unit, in degrees Celsius, at which it should indicate an Over temperature Fault.", 9, "advanceHelp")
        Help.registerTarget(voutOVlimitFaultSlider, "PMBus: VOUT_OV_FAULT_LIMIT.", 10, "advanceHelp")
        Help.registerTarget(voutUVlimitFaultSlider, "PMBus: VOUT_UV_FAULT_LIMIT.", 11, "advanceHelp")
        Help.registerTarget(ioutOClimitFaultSlider, "PMBus: IOUT_OC_FAULT_LIMIT.", 12, "advanceHelp")
        Help.registerTarget(overTemperatureWarningSlider, "PMBus: OT_WARN_LIMIT. Sets the temperature of the unit, in degrees Celsius, at which it should indicate an Over temperature Warning.", 13, "advanceHelp")
        Help.registerTarget(voutOVlimitWarningSlider, "PMBus: VOUT_OV_WARN_LIMIT.", 14, "advanceHelp")
        Help.registerTarget(voutUVlimitWarningSlider, "PMBus: VOUT_UV_WARN_LIMIT.", 15, "advanceHelp")
        Help.registerTarget(ioutOClimitWarningSlider, "PMBus: IOUT_OC_WARN_LIMIT.", 16, "advanceHelp")
        Help.registerTarget(vinGraph, "Input Voltage is plotted in real time", 17, "advanceHelp")
        Help.registerTarget(iinGraph, "Input Current is plotted in real time", 18, "advanceHelp")
        Help.registerTarget(pdissGraph, "Power Dissipated is plotted in real time", 19, "advanceHelp")
        Help.registerTarget(poutGraph, "Output Power is plotted in real time", 20, "advanceHelp")
        Help.registerTarget(voutGraph, "Output Voltage is plotted in real time", 21, "advanceHelp")
        Help.registerTarget(ioutGraph, "Output Current is plotted in real time", 22, "advanceHelp")
    }

    Rectangle{
        anchors.fill: parent
        width : parent.width
        height: parent.height

        Rectangle {
            id: controlSection1
            width: parent.width
            height: parent.height - 100
            anchors{
                top: parent.top
                topMargin: 10
            }
            Rectangle {
                id: topControl
                anchors {
                    left: controlSection1.left
                    top: controlSection1.top
                }
                width: parent.width
                height: controlSection1.height/3

                SGAlignedLabel{
                    id: overTemperatureFaultLabel
                    target: overTemperatureFaultSlider
                    text:"<b>Over temperature Fault:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: parent.top
                        topMargin: parent.height/15
                        left: parent.left
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: overTemperatureFaultSlider
                        width: parent.width
                        from: 115
                        to: 135
                        value: platformInterface.temp_fault.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.temp_fault = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: overTemperatureFaultSliderUnit
                        text:"°C"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: overTemperatureFaultSlider.right
                        anchors.verticalCenter: overTemperatureFaultSlider.top
                        }
                }

                SGAlignedLabel{
                    id: voutOVlimitFaultLabel
                    target: voutOVlimitFaultSlider
                    text:"<b>Vout OV Fault Limit:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: overTemperatureFaultLabel.bottom
                        topMargin: parent.height/15
                        left: parent.left
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: voutOVlimitFaultSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.vout_ov_fault.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.vout_ov_fault = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: voutOVlimitFaultSliderUnit
                        text:"V"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: voutOVlimitFaultSlider.right
                        anchors.verticalCenter: voutOVlimitFaultSlider.top
                        }
                }

                SGAlignedLabel{
                    id: voutUVlimitFaultLabel
                    target: voutUVlimitFaultSlider
                    text:"<b>Vout UV Fault Limit:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: voutOVlimitFaultLabel.bottom
                        topMargin: parent.height/15
                        left: parent.left
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: voutUVlimitFaultSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.vout_uv_fault.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.vout_uv_fault = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: voutUVlimitFaultSliderUnit
                        text:"V"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: voutUVlimitFaultSlider.right
                        anchors.verticalCenter: voutUVlimitFaultSlider.top
                        }
                }

                SGAlignedLabel{
                    id: ioutOClimitFaultLabel
                    target: ioutOClimitFaultSlider
                    text:"<b>Iout OC Fault Limit:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: voutUVlimitFaultLabel.bottom
                        topMargin: parent.height/15
                        left: parent.left
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: ioutOClimitFaultSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.ioutScale
                        value: platformInterface.iout_oc_fault.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.iout_oc_fault = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: ioutOClimitFaultSliderUnit
                        text:"A"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: ioutOClimitFaultSlider.right
                        anchors.verticalCenter: ioutOClimitFaultSlider.top
                        }
                }

                SGAlignedLabel{
                    id: overTemperatureWarningLabel
                    target: overTemperatureWarningSlider
                    text:"<b>Over temperature Warning:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: parent.top
                        topMargin: parent.height/15
                        left: overTemperatureFaultLabel.right
                        leftMargin: parent.width/20
                        }
                    SGSlider {
                        id: overTemperatureWarningSlider
                        width: parent.width
                        from: 85
                        to: 105
                        value: platformInterface.temp_warn.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.temp_warn = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: overTemperatureWarningSliderUnit
                        text:"°C"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: overTemperatureWarningSlider.right
                        anchors.verticalCenter: overTemperatureWarningSlider.top
                        }
                    }

                SGAlignedLabel{
                    id: voutOVlimitWarningLabel
                    target: voutOVlimitWarningSlider
                    text:"<b>Vout OV Warning Limit:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: overTemperatureWarningLabel.bottom
                        topMargin: parent.height/15
                        left: voutOVlimitFaultLabel.right
                        leftMargin: parent.width/20
                        }
                    SGSlider {
                        id: voutOVlimitWarningSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.vout_ov_warn.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.vout_ov_warn = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: voutOVlimitWarningSliderUnit
                        text:"V"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: voutOVlimitWarningSlider.right
                        anchors.verticalCenter: voutOVlimitWarningSlider.top
                        }
                }

                SGAlignedLabel{
                    id: voutUVlimitWarningLabel
                    target: voutUVlimitWarningSlider
                    text:"<b>Vout UV Warning Limit:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: voutOVlimitWarningLabel.bottom
                        topMargin: parent.height/15
                        left: voutUVlimitFaultLabel.right
                        leftMargin: parent.width/20
                        }
                    SGSlider {
                        id: voutUVlimitWarningSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.vout_uv_warn.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.vout_uv_warn = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: voutUVlimitWarningSliderUnit
                        text:"V"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: voutUVlimitWarningSlider.right
                        anchors.verticalCenter: voutUVlimitWarningSlider.top
                        }
                }

                SGAlignedLabel{
                    id: ioutOClimitWarningLabel
                    target: ioutOClimitWarningSlider
                    text:"<b>Iout OC Warning Limit:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: voutUVlimitWarningLabel.bottom
                        topMargin: parent.height/15
                        left: ioutOClimitFaultLabel.right
                        leftMargin: parent.width/20
                        }
                    SGSlider {
                        id: ioutOClimitWarningSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.ioutScale
                        value: platformInterface.iout_oc_warn.toFixed(3)
                        stepSize: 0.001
                        onUserSet: platformInterface.iout_oc_warn = value.toFixed(3)
                        live: false
                    }
                    Text{
                        id: ioutOClimitWarningSliderUnit
                        text:"A"
                        font.pixelSize: (parent.width + parent.height)/20
                        color: "black"
                        anchors.left: ioutOClimitWarningSlider.right
                        anchors.verticalCenter: ioutOClimitWarningSlider.top
                        }
                }


                Text{
                    id: specific1Text
                    text: "<b>STATUS MFR SPECIFIC 1<b>"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: "black"
                    anchors {
                        top : parent.top
                        topMargin : parent.height/15
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1BitOText
                    text: "VOUT higher than threshold on startup"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.vout_sthr){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit1Text
                    text: "VINSS higher than threshold on startup"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.vinss_sthr){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1BitOText.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit2Text
                    text: "DCX VOUT UVLO on startup"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.dcx_s){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit1Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit3Text
                    text: "Analog OC Protection"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.ana_oc){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit2Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit4Text
                    text: "Buck Duty Fault"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.buck_duty){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit3Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit5Text
                    text: "Digital Ratio Protection"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.dig_ratio){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit4Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit6Text
                    text: "Analog Ratio Protection"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(platformInterface.ana_ratio){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit5Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    }

                Button {
                    id:resetErrorButton
                    anchors {
                        top : specific1Bit6Text.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    font.pixelSize: (parent.width + parent.height)/150
                    text: "<b>CLEAR FAULTS<b>"
                    visible: true
                    width: parent.width/8
                    height: parent.height/12
                    onClicked: {
                        platformInterface.clear_faults1.update()
                    }
                }

                Button {
                    id:setParametersButton
                    anchors {
                        top : resetErrorButton.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    font.pixelSize: (parent.width + parent.height)/150
                    text: "<b>SET PARAMETERS<b>"
                    visible: true
                    width: parent.width/8
                    height: parent.height/12
                    onClicked: {
                        platformInterface.set_fault_config_all.update(platformInterface.temp_warn, platformInterface.temp_fault,
                                                                      platformInterface.vout_ov_warn, platformInterface.vout_ov_fault, platformInterface.vout_ov_response,
                                                                      platformInterface.vout_uv_warn, platformInterface.vout_uv_fault, platformInterface.vout_uv_response,
                                                                      platformInterface.iout_oc_warn, platformInterface.iout_oc_fault, platformInterface.iout_oc_response)
                    }
                }

                Button {
                    id:writeParametersButton
                    anchors {
                        top : setParametersButton.top
                        topMargin : parent.height/10
                        left: parent.left
                        leftMargin: parent.width/20
                        }
                    font.pixelSize: (parent.width + parent.height)/150
                    text: "<b>WRITE PARAMETERS<b>"
                    visible: true
                    width: parent.width/8
                    height: parent.height/12
                    onClicked: {
                        platformInterface.write_config_to_otp1.update()
                    }
                }

                Text{
                    id: voutOVFaultResponseText
                    text: "<b>Vout OV Fault Response:<b>"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: "black"
                    anchors {
                        top : parent.top
                        topMargin : parent.height/8
                        left: parent.left
                        leftMargin: parent.width/5
                        }
                    }

                SGComboBox {
                    id: voutOVFaultResponseCombo
                    currentIndex:
                    {
                        if (platformInterface.vout_ov_response === "ignore")
                        {
                            platformInterface.vout_ov_response ="ignore"
                            return 1
                        }
                        else
                        {
                            platformInterface.vout_ov_response ="retry"
                            return 0
                        }
                    }
                    model: [ "Retry","Ignore"]
                    borderColor: "green"
                    textColor: "black"
                    indicatorColor: "green"
                    width: parent.width/10
                    height:parent.height/8
                    anchors {
                        top : voutOVFaultResponseText.top
                        topMargin : parent.height/15
                        left: parent.left
                        leftMargin: parent.width/5
                        }
                    onActivated:
                    {
                        if(currentIndex == 1)
                        {
                            platformInterface.vout_ov_response ="ignore"
                        }
                        else
                        {
                            platformInterface.vout_ov_response ="retry"
                        }
                    }
                }

                Text{
                    id: voutUVFaultResponseText
                    text: "<b>Vout UV Fault Response:<b>"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: "black"
                    anchors {
                        top : voutOVFaultResponseText.top
                        topMargin : parent.height/5
                        left: parent.left
                        leftMargin: parent.width/5
                        }
                    }

                SGComboBox {
                    id: voutUVFaultResponseCombo
                    currentIndex:
                    {
                        if (platformInterface.vout_uv_response === "ignore")
                        {
                            platformInterface.vout_uv_response ="ignore"
                            return 1
                        }
                        else
                        {
                            platformInterface.vout_uv_response ="retry"
                            return 0
                        }
                    }
                    model: [ "Retry","Ignore"]
                    borderColor: "green"
                    textColor: "black"
                    indicatorColor: "green"
                    width: parent.width/10
                    height:parent.height/8
                    anchors {
                        top : voutUVFaultResponseText.top
                        topMargin : parent.height/15
                        left: parent.left
                        leftMargin: parent.width/5
                        }
                    onActivated:
                    {
                        if(currentIndex == 1)
                        {
                            platformInterface.vout_uv_response ="ignore"
                        }
                        else
                        {
                            platformInterface.vout_uv_response ="retry"
                        }
                    }
                }

                Text{
                    id: ioutOCFaultResponseText
                    text: "<b>Iout OC Fault Response:<b>"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: "black"
                    anchors {
                        top : voutUVFaultResponseText.top
                        topMargin : parent.height/5
                        left: parent.left
                        leftMargin: parent.width/5
                        }
                    }

                SGComboBox
                {
                    id: ioutOCFaultResponseCombo
                    currentIndex:
                    {
                        if (platformInterface.iout_oc_response === "ignore")
                        {
                            platformInterface.iout_oc_response ="ignore"
                            return 1
                        }
                        else
                        {
                            platformInterface.iout_oc_response ="retry"
                            return 0
                        }
                    }
                    model: [ "Retry","Ignore"]
                    borderColor: "green"
                    textColor: "black"
                    indicatorColor: "green"
                    width: parent.width/10
                    height:parent.height/8
                    anchors {
                        top : ioutOCFaultResponseText.top
                        topMargin : parent.height/15
                        left: parent.left
                        leftMargin: parent.width/5
                        }
                    onActivated:
                    {
                        if(currentIndex == 1)
                        {
                            platformInterface.iout_oc_response ="ignore"
                        }
                        else
                        {
                            platformInterface.iout_oc_response ="retry"
                        }
                    }
                }

            }

            Rectangle {
                width: parent.width
                height: parent.height/1.7
                color: "transparent"

                anchors {
                    top : topControl.bottom
                    topMargin: parent.height/6
                }

                Rectangle {
                    id: dataContainer
                    color: "transparent"
                    border.color: "transparent"
                    border.width: 5
                    radius: 10
                    width: parent.width
                    height: parent.height

                    anchors {
                        top: parent.top
                        topMargin : 0
                        left: parent.left
                        leftMargin : 50
                    }

                    GraphConverter{
                        id: vinGraph
                        width: parent.width/5
                        height: parent.height/1.05
                        anchors {
                            left: parent.left
                            leftMargin: -50
                            top: parent.top
                            topMargin: -parent.height/20
                        }
                        showOptions: false
                        autoAdjustMaxMin: false
                        //repeatOldData: visible
                        dataLineColor: "blue"
                        textColor: "black"
                        axesColor: "black"
                        gridLineColor: "lightgrey"
                        underDataColor: "transparent"
                        backgroundColor: "white"
                        xAxisTickCount: 6
                        yAxisTickCount: 11
                        throttlePlotting: true
                        pointCount: 30
                        xAxisTitle: "<b>100 µs / div<b>"
                        yAxisTitle: "Input Voltage (V)"
                        inputData: platformInterface.vin
                        maxYValue: multiplePlatform.vinScale
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true
                    }


                    SGLabelledInfoBox {
                        id: inputVoltage
                        label: ""
                        info: platformInterface.vin.toFixed(3)

                        infoBoxColor: if (multiplePlatform.nominalVin < platformInterface.vin) {"red"}
                                      else{"lightgrey"}
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: "V"
                        infoBoxWidth: vinGraph.width/1.5
                        infoBoxHeight : vinGraph.height/10
                        fontSize :  (vinGraph.width + vinGraph.height)/37
                        unitSize: (vinGraph.width + vinGraph.height)/35
                        anchors {
                            top : vinGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: vinGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: voutGraph
                        width: parent.width/5
                        height: parent.height/1.05
                        anchors {
                            left: vinGraph.right
                            leftMargin: 0
                            top: parent.top
                            topMargin: -parent.height/20
                        }
                        showOptions: false
                        autoAdjustMaxMin: false
                        //repeatOldData: visible
                        dataLineColor: "blue"
                        textColor: "black"
                        axesColor: "black"
                        gridLineColor: "lightgrey"
                        underDataColor: "transparent"
                        backgroundColor: "white"
                        xAxisTickCount: 6
                        yAxisTickCount: 11
                        throttlePlotting: true
                        pointCount: 30
                        xAxisTitle: "<b>100 µs / div<b>"
                        yAxisTitle: "Output Voltage (V)"
                        inputData: platformInterface.vout
                        maxYValue: multiplePlatform.voutScale
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: outputVoltage
                        label: ""
                        info: platformInterface.vout.toFixed(3)
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: "V"
                        infoBoxWidth: voutGraph.width/1.5
                        infoBoxHeight : voutGraph.height/10
                        fontSize :  (voutGraph.width + voutGraph.height)/37
                        unitSize: (voutGraph.width + voutGraph.height)/35
                        anchors {
                            top : voutGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: voutGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: ioutGraph
                        width: parent.width/5
                        height: parent.height/1.05
                        anchors {
                            left: voutGraph.right
                            leftMargin: 0
                            top: parent.top
                            topMargin: -parent.height/20
                        }
                        showOptions: false
                        autoAdjustMaxMin: false
                        //repeatOldData: visible
                        dataLineColor: "green"
                        textColor: "black"
                        axesColor: "black"
                        gridLineColor: "lightgrey"
                        underDataColor: "transparent"
                        backgroundColor: "white"
                        xAxisTickCount: 6
                        yAxisTickCount: 11
                        throttlePlotting: true
                        pointCount: 30
                        xAxisTitle: "<b>100 µs / div<b>"
                        yAxisTitle: "Output Current (A)"
                        inputData: platformInterface.iout
                        maxYValue: multiplePlatform.ioutScale
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true

                    }


                    SGLabelledInfoBox {
                        id: outputCurrent
                        label: ""
                        info: platformInterface.iout.toFixed(3)
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: "A"
                        infoBoxWidth: ioutGraph.width/1.5
                        infoBoxHeight : ioutGraph.height/10
                        fontSize :  (ioutGraph.width + ioutGraph.height)/37
                        unitSize: (ioutGraph.width + ioutGraph.height)/35
                        anchors {
                            top : ioutGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: ioutGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: poutGraph
                        width: parent.width/5
                        height: parent.height/1.05
                        anchors {
                            left: ioutGraph.right
                            leftMargin: 0
                            top: parent.top
                            topMargin: -parent.height/20
                        }
                        showOptions: false
                        autoAdjustMaxMin: false
                        //repeatOldData: visible
                        dataLineColor: "#7bdeff"
                        textColor: "black"
                        axesColor: "black"
                        gridLineColor: "lightgrey"
                        underDataColor: "transparent"
                        backgroundColor: "white"
                        xAxisTickCount: 6
                        yAxisTickCount: 11
                        throttlePlotting: true
                        pointCount: 30
                        xAxisTitle: "<b>100 µs / div<b>"
                        yAxisTitle: "Output Power (W)"
                        inputData: platformInterface.pout.toFixed(3)
                        maxYValue: multiplePlatform.poutScale
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: poutPower
                        label: ""
                        info: platformInterface.pout.toFixed(3)

                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: "W"

                        infoBoxWidth: poutGraph.width/1.5
                        infoBoxHeight : poutGraph.height/10
                        fontSize :  (poutGraph.width + poutGraph.height)/37
                        unitSize: (poutGraph.width + poutGraph.height)/35
                        anchors {
                            top : poutGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: poutGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: ctempGraph
                        width: parent.width/5
                        height: parent.height/1.05
                        anchors {
                            left: poutGraph.right
                            leftMargin: 0
                            top: parent.top
                            topMargin: -parent.height/20
                        }
                        showOptions: false
                        autoAdjustMaxMin: false
                        //repeatOldData: visible
                        dataLineColor: "orange"
                        textColor: "black"
                        axesColor: "black"
                        gridLineColor: "lightgrey"
                        underDataColor: "transparent"
                        backgroundColor: "white"
                        xAxisTickCount: 6
                        yAxisTickCount: 11
                        throttlePlotting: true
                        pointCount: 30
                        xAxisTitle: "<b>100 µs / div<b>"
                        yAxisTitle: "Chip Temperature (°C)"
                        inputData: platformInterface.ctemp
                        maxYValue: multiplePlatform.ctempScale
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: ctempLabel
                        label: ""
                        info: platformInterface.ctemp
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: "°C"

                        infoBoxWidth: ctempGraph.width/1.5
                        infoBoxHeight : ctempGraph.height/10
                        fontSize :  (ctempGraph.width + ctempGraph.height)/37
                        unitSize: (ctempGraph.width + ctempGraph.height)/35
                        anchors {
                            top : ctempGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: ctempGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }




                }
            }
        }
    }
}
