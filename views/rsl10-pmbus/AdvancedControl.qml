import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

import "qrc:/js/navigation_control.js" as NavigationControl
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

    // property that reads the initial notification
    property var temp_calc: platformInterface.status_temperature_sensor.temperature
    property var vin_calc: platformInterface.status_voltage_current.vin/1000
    property var iin_calc: platformInterface.status_voltage_current.iin
    property var vout_calc: platformInterface.status_voltage_current.vout/1000
    property var iout_calc: platformInterface.status_voltage_current.iout

    property var pin_calc: vin_calc * iin_calc * 1000
    property var pout_calc: vout_calc * iout_calc * 1000
    property var effi_calc: ((pout_calc * 100) / pin_calc).toFixed(3)

    property var overTemperatureFault: platformInterface.overTemperatureFault
    property var overTemperatureWarning: platformInterface.overTemperatureWarning
    property var voutOVlimitFault: platformInterface.voutOVlimitFault
    property var voutOVlimitWarning: platformInterface.voutOVlimitWarning
    property var voutUVlimitFault: platformInterface.voutUVlimitFault
    property var voutUVlimitWarning: platformInterface.voutUVlimitWarning
    property var ioutOClimitFault: platformInterface.ioutOClimitFault
    property var ioutOClimitWarning: platformInterface.ioutOClimitWarning

    property var status_mfr_specific1_b0: platformInterface.status_mfr_specific1.b0
    property var status_mfr_specific1_b1: platformInterface.status_mfr_specific1.b1
    property var status_mfr_specific1_b2: platformInterface.status_mfr_specific1.b2
    property var status_mfr_specific1_b3: platformInterface.status_mfr_specific1.b3
    property var status_mfr_specific1_b4: platformInterface.status_mfr_specific1.b4
    property var status_mfr_specific1_b5: platformInterface.status_mfr_specific1.b5
    property var status_mfr_specific1_b6: platformInterface.status_mfr_specific1.b6
    property var status_mfr_specific1_b7: platformInterface.status_mfr_specific1.b7
    property var status_mfr_specific2_b4: platformInterface.status_mfr_specific2.b4
    property var status_mfr_specific2_b5: platformInterface.status_mfr_specific2.b5
    property var status_mfr_specific2_b6: platformInterface.status_mfr_specific2.b6
    property var status_mfr_specific2_b7: platformInterface.status_mfr_specific2.b7

    property string read_enable_state: platformInterface.initial_status.enable_status
    onRead_enable_stateChanged: {
        if(read_enable_state === "on") {
            platformInterface.enabled = true
            platformInterface.pause_periodic = false
        }
        else  {
            platformInterface.enabled = false
            platformInterface.pause_periodic = true
        }
    }

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
        Help.registerTarget(specific2Text, "PMBus: STATUS_MFR_SPECIFIC2.", 5, "advanceHelp")
        Help.registerTarget(voutOVFaultResponseCombo, "PMBus: VOUT_OV_FAULT_RESPONSE. Latch, retry, ignore.", 6, "advanceHelp")
        Help.registerTarget(voutUVFaultResponseCombo, "PMBus: VOUT_UV_FAULT_RESPONSE. Latch, retry, ignore.", 7, "advanceHelp")
        Help.registerTarget(ioutOCFaultResponseCombo, "PMBus: IOUT_OT_FAULT_RESPONSE. Latch, retry, ignore.", 8, "advanceHelp")
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

                GraphConverter{
                    id: efficiencyGraph
                    width: parent.width/3
                    height: parent.height*1.3
                    anchors {
                        left: parent.left
                        leftMargin: 0
                        top: parent.top
                        topMargin: 0
                    }
                    showOptions: false
                    autoAdjustMaxMin: false
                    //repeatOldData: visible
                    dataLineColor: "purple"
                    textColor: "black"
                    axesColor: "black"
                    gridLineColor: "lightgrey"
                    underDataColor: "transparent"
                    backgroundColor: "white"
                    xAxisTickCount: 11
                    yAxisTickCount: 11
                    throttlePlotting: true
                    pointCount: if (platformInterface.systemMode === false) {1} else {50}
                    title: "<b>Efficiency</b>"
                    yAxisTitle: "<b>η [%]</b>"
                    xAxisTitle: "<b>10 µs / div<b>"
                    inputData: effi_calc
                    maxYValue: 100
                    minYValue: 0
                    showYGrids: true
                    showXGrids: true
                    minXValue: 0
                    maxXValue:5
                    reverseDirection: true
                }

                SGLabelledInfoBox {
                    id: effiPower
                    label: "%"
                    info: effi_calc

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""

                    infoBoxWidth: pdissGraph.width/1.5
                    infoBoxHeight : pdissGraph.height/10
                    fontSize :  (pdissGraph.width + pdissGraph.height)/37
                    unitSize: (pdissGraph.width + pdissGraph.height)/35
                    anchors {
                        top : efficiencyGraph.bottom
                        topMargin : -parent.height/18
                        left: efficiencyGraph.left
                        leftMargin: parent.width/50
                    }
                }

                SGAlignedLabel{
                    id: overTemperatureFaultLabel
                    target: overTemperatureFaultSlider
                    text:"<b>Over temperature Fault:<b>"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/10
                    anchors {
                        top: parent.top
                        topMargin: parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: overTemperatureFaultSlider
                        width: parent.width
                        from: 115
                        to: 135
                        value: platformInterface.status_predefined_values.OT_fault
                        stepSize: 1
                        onValueChanged: overTemperatureFault = value
                        onUserSet: platformInterface.overTemperatureFault = overTemperatureFaultSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: overTemperatureFaultLabel.bottom
                        topMargin: parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: voutOVlimitFaultSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.status_predefined_values.OV_fault
                        stepSize: 1
                        onValueChanged: voutOVlimitFault = value
                        onUserSet: platformInterface.voutOVlimitFault = voutOVlimitFaultSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: voutOVlimitFaultLabel.bottom
                        topMargin: parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: voutUVlimitFaultSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.status_predefined_values.UV_fault
                        stepSize: 1
                        onValueChanged: voutUVlimitFault = value
                        onUserSet: platformInterface.voutUVlimitFault = voutUVlimitFaultSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: voutUVlimitFaultLabel.bottom
                        topMargin: parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/2.75
                        }
                    SGSlider {
                        id: ioutOClimitFaultSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.ioutScale
                        value: platformInterface.status_predefined_values.OC_fault
                        stepSize: 1
                        onValueChanged: ioutOClimitFault = value
                        onUserSet: platformInterface.ioutOClimitFault = ioutOClimitFaultSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: parent.top
                        topMargin: parent.height/15
                        right: parent.right
                        rightMargin: parent.width/20
                        }
                    SGSlider {
                        id: overTemperatureWarningSlider
                        width: parent.width
                        from: 85
                        to: 105
                        value: platformInterface.status_predefined_values.OT_warning
                        stepSize: 1
                        onValueChanged: overTemperatureWarning = value
                        onUserSet: platformInterface.overTemperatureWarning = overTemperatureWarningSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: overTemperatureWarningLabel.bottom
                        topMargin: parent.height/15
                        right: parent.right
                        rightMargin: parent.width/20
                        }
                    SGSlider {
                        id: voutOVlimitWarningSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.status_predefined_values.OV_warning
                        stepSize: 1
                        onValueChanged: voutOVlimitWarning = value
                        onUserSet: platformInterface.voutOVlimitWarning = voutOVlimitWarningSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: voutOVlimitWarningLabel.bottom
                        topMargin: parent.height/15
                        right: parent.right
                        rightMargin: parent.width/20
                        }
                    SGSlider {
                        id: voutUVlimitWarningSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.voutScale
                        value: platformInterface.status_predefined_values.UV_warning
                        stepSize: 1
                        onValueChanged: voutUVlimitWarning = value
                        onUserSet: platformInterface.voutUVlimitWarning = voutUVlimitWarningSlider.value
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
                    width: parent.width/10
                    anchors {
                        top: voutUVlimitWarningLabel.bottom
                        topMargin: parent.height/15
                        right: parent.right
                        rightMargin: parent.width/20
                        }
                    SGSlider {
                        id: ioutOClimitWarningSlider
                        width: parent.width
                        from: 0
                        to: multiplePlatform.ioutScale
                        value: platformInterface.status_predefined_values.OC_warning
                        stepSize: 1
                        onValueChanged: ioutOClimitWarning = value
                        onUserSet: platformInterface.ioutOClimitWarning = ioutOClimitWarningSlider.value
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
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1BitOText
                    text: "DCX FRZ"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b0 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit1Text
                    text: "PRC Control out of Limits"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b1 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1BitOText.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit2Text
                    text: "Digital ADC Ratio Vin/Vout"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b2 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit1Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit3Text
                    text: "Analog Ratio Vin/Vout"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b3 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit2Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit4Text
                    text: "CSR2 OCP Negative"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b4 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit3Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit5Text
                    text: "CSR2 OCP Positive"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b5 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit4Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit6Text
                    text: "CSR1 OCP Negative"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b6 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit5Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Text{
                    id: specific1Bit7Text
                    text: "CSR1 OCP Positive"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific1_b7 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific1Bit6Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    }

                Button {
                    id:resetErrorButton
                    anchors {
                        top : specific1Bit7Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    font.pixelSize: (parent.width + parent.height)/150
                    text: "<b>CLEAR FAULTS<b>"
                    visible: true
                    width: parent.width/8
                    height: parent.height/12
                    onClicked: {
                        platformInterface.set_reset_error.update(1)
                    }
                }

                Button {
                    id:setParametersButton
                    anchors {
                        top : resetErrorButton.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    font.pixelSize: (parent.width + parent.height)/150
                    text: "<b>SET PARAMETERS<b>"
                    visible: true
                    width: parent.width/8
                    height: parent.height/12
                    onClicked: {
                        platformInterface.set_parameters.update(1)
                    }
                }

                Button {
                    id:writeParametersButton
                    anchors {
                        top : setParametersButton.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/20
                        }
                    font.pixelSize: (parent.width + parent.height)/150
                    text: "<b>WRITE PARAMETERS<b>"
                    visible: true
                    width: parent.width/8
                    height: parent.height/12
                    onClicked: {
                        platformInterface.set_write.update(1)
                    }
                }

                Text{
                    id: specific2Text
                    text: "<b>STATUS MFR SPECIFIC 2<b>"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: "black"
                    anchors {
                        top : parent.top
                        topMargin : parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                Text{
                    id: specific2Bit4Text
                    text: "DCX SKIP"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific2_b4 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific2Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                Text{
                    id: specific2Bit5Text
                    text: "PRC MIN FREQ %"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific2_b5 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific2Bit4Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                Text{
                    id: specific2Bit6Text
                    text: "PRC MAX FREQ %"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific2_b6 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific2Bit5Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                Text{
                    id: specific2Bit7Text
                    text: "PRC LL"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: {
                        if(status_mfr_specific2_b7 === 1){"red"}
                        else {"grey"}
                        }
                    anchors {
                        top : specific2Bit6Text.top
                        topMargin : parent.height/10
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                Text{
                    id: voutOVFaultResponseText
                    text: "<b>Vout OV Fault Response:<b>"
                    font.pixelSize: (parent.width + parent.height)/140
                    color: "black"
                    anchors {
                        top : specific2Bit7Text.top
                        topMargin : parent.height/8
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                SGComboBox {
                    id: voutOVFaultResponseCombo
                    currentIndex: platformInterface.voutOVFaultResponse.voutOVFaultResponse
                    model: [ "Latch","Retry","Ignore"]
                    borderColor: "green"
                    textColor: "black"
                    indicatorColor: "green"
                    width: parent.width/20
                    height:parent.height/10
                    anchors {
                        top : voutOVFaultResponseText.top
                        topMargin : parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    onActivated: {
                        platformInterface.set_voutOVFaultResponse.update(currentIndex)
                        platformInterface.voutOVFaultResponse_state = currentIndex
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
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                SGComboBox {
                    id: voutUVFaultResponseCombo
                    currentIndex: platformInterface.voutUVFaultResponse.voutUVFaultResponse
                    model: [ "Latch","Retry","Ignore"]
                    borderColor: "green"
                    textColor: "black"
                    indicatorColor: "green"
                    width: parent.width/20
                    height:parent.height/10
                    anchors {
                        top : voutUVFaultResponseText.top
                        topMargin : parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    onActivated: {
                        platformInterface.set_voutUVFaultResponse.update(currentIndex)
                        platformInterface.voutUVFaultResponse_state = currentIndex
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
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    }

                SGComboBox {
                    id: ioutOCFaultResponseCombo
                    currentIndex: platformInterface.ioutOCFaultResponse.ioutOCFaultResponse
                    model: [ "Latch","Retry","Ignore"]
                    borderColor: "green"
                    textColor: "black"
                    indicatorColor: "green"
                    width: parent.width/20
                    height:parent.height/10
                    anchors {
                        top : ioutOCFaultResponseText.top
                        topMargin : parent.height/15
                        left: efficiencyGraph.right
                        leftMargin: parent.width/5
                        }
                    onActivated: {
                        platformInterface.set_ioutOCFaultResponse.update(currentIndex)
                        platformInterface.ioutOCFaultResponse_state = currentIndex
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
                        width: parent.width/6
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
                        inputData: vin_calc
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
                        info: {
                            if(multiplePlatform.showDecimal === true) {vin_calc.toFixed(3)}
                            else {vin_calc.toFixed(0)}
                        }

                        infoBoxColor: if (multiplePlatform.nominalVin < vin_calc) {"red"}
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
                        id: iinGraph
                        width: parent.width/6
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
                        yAxisTitle: if(multiplePlatform.current === "mA") {"Input Current (mA)"}
                                    else{"Input Current (A)"}
                        inputData: {
                            if(multiplePlatform.current === "A") {(iin_calc/1000).toFixed(3)}
                            else {iin_calc.toFixed(0)}
                        }
                        maxYValue: if(multiplePlatform.current === "mA") {multiplePlatform.iinScale * 1000}
                                   else{multiplePlatform.iinScale}
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true
                    }


                    SGLabelledInfoBox {
                        id: inputCurrent
                        label: ""
                        info: {
                            if(multiplePlatform.current === "A") {(iin_calc/1000).toFixed(3)}
                            else {iin_calc.toFixed(0)}
                        }

                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: if(multiplePlatform.current === "mA") {"mA"}
                              else{"A"}
                        infoBoxWidth: iinGraph.width/1.5
                        infoBoxHeight : iinGraph.height/10
                        fontSize :  (iinGraph.width + iinGraph.height)/37
                        unitSize: (iinGraph.width + iinGraph.height)/35
                        anchors {
                            top : iinGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: iinGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: pdissGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: iinGraph.right
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
                        yAxisTitle: if(multiplePlatform.pdiss === "mW") {"Power Dissipated (mW)"}
                                    else{"Power Dissipated (W)"}
                        inputData: if(pin_calc > pout_calc)
                                   {if(multiplePlatform.pdiss === "W") {((pin_calc - pout_calc)/1000000).toFixed(0)}
                                       else{((pin_calc - pout_calc)/1000).toFixed(0)}}
                                   else{0}
                        maxYValue: multiplePlatform.pdissScale
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: pdissPower
                        label: ""
                        info: if(pin_calc > pout_calc)
                              {if(multiplePlatform.pdiss === "W") {((pin_calc - pout_calc)/1000000).toFixed(2)}
                                  else{((pin_calc - pout_calc)/1000).toFixed(1)}}
                              else{0}

                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: if(multiplePlatform.pdiss === "mW") {"mW"}
                              else{"W"}

                        infoBoxWidth: pdissGraph.width/1.5
                        infoBoxHeight : pdissGraph.height/10
                        fontSize :  (pdissGraph.width + pdissGraph.height)/37
                        unitSize: (pdissGraph.width + pdissGraph.height)/35
                        anchors {
                            top : pdissGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: pdissGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: poutGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: pdissGraph.right
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
                        yAxisTitle: if(multiplePlatform.pdiss === "mW") {"Output Power (mW)"}
                                    else{"Output Power (W)"}
                        inputData: if(multiplePlatform.pdiss === "W") {(pout_calc/1000000).toFixed(0)}
                                   else{(pout_calc/1000).toFixed(0)}
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
                        info: if(multiplePlatform.pdiss === "W") {(pout_calc/1000000).toFixed(2)}
                              else{(pout_calc/1000).toFixed(1)}

                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: if(multiplePlatform.pdiss === "mW") {"mW"}
                              else{"W"}

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
                        id: voutGraph
                        width: parent.width/6
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
                        inputData: {vout_calc}
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
                        info: {
                            if(multiplePlatform.showDecimal === true) {vout_calc.toFixed(3)}
                            else {vout_calc.toFixed(0)}
                        }

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
                        width: parent.width/6
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
                        yAxisTitle: if(multiplePlatform.current === "mA") {"Output Current (mA)"}
                                    else{"Output Current (A)"}
                        inputData: if(multiplePlatform.current === "mA") {iout_calc}
                                   else{(iout_calc/1000).toFixed(3)}
                        maxYValue: if(multiplePlatform.current === "mA") {multiplePlatform.ioutScale * 1000}
                                   else{multiplePlatform.ioutScale}
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: 5
                        reverseDirection: true

                    }


                    SGLabelledInfoBox {
                        id: outputCurrent
                        label: ""
                        info: {
                            if(multiplePlatform.current === "A") {(iout_calc/1000).toFixed(3)}
                            else {iout_calc.toFixed(0)}
                        }

                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3

                        unit: if(multiplePlatform.current === "mA") {"mA"}
                              else{"A"}
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
                }
            }
        }
    }
}
