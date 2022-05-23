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
import tech.strata.sgwidgets 0.9 as Widget09
import tech.strata.sgwidgets 1.0 as Widget10
import "sgwidgets/"
import "qrc:/image"
import "qrc:/js/help_layout_manager.js" as Help


Item {
    anchors.fill: parent
    property string vinlable: ""
    property bool hideEcoSwitch: false
    property string warningVin: multiplePlatform.warningHVVinLable

    // property that reads the initial notification
    property var temp_calc: platformInterface.status_temperature_sensor.temperature
    property var dc_link_vin_calc: platformInterface.status_vi.l/1000
    property var foc_iout_id_calc: platformInterface.status_vi.d/1000
    property var foc_iout_iq_calc: platformInterface.status_vi.q/1000
    property var winding_iout_iu_calc: platformInterface.status_vi.u/1000
    property var winding_iout_iv_calc: platformInterface.status_vi.v/1000
    property var winding_iout_iw_calc: platformInterface.status_vi.w/1000
    property var time: settingsControl.time
    property var pointsCount: settingsControl.pointsCount
    property var amperes: settingsControl.amperes
    property var max_motor_speed: settingsControl.max_motor_speed
    property var target_speed: platformInterface.status_vi.t
    property var actual_speed: platformInterface.status_vi.a
    property var target: settingsControl.target.toFixed(0)
    property var pole_pairs: settingsControl.pole_pairs
    property var frequency: ((actual_speed/60)*pole_pairs).toFixed(0)

    property string error_code: basicControl.error_code

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

        Help.registerTarget(labelledInfoBox,"Error message status are shown here.", 0, "advanceHelp")

        Help.registerTarget(targetSpeedGauge, "This gauge shows the target speed. For V/F, they are same (target set by user) as we do not measure the speed but only when steady state is reached. The target is set instantaneously, while actual is the ramp up value.", 1, "advanceHelp")
        Help.registerTarget(actualSpeedGauge, "This gauge shows the actual speed.", 2, "advanceHelp")
        Help.registerTarget(hzGauge, "This gauge shows the output frequency.", 3, "advanceHelp")
        Help.registerTarget(actualSpeedGraph, "The actual speed is plotted in real time.", 4, "advanceHelp")
        Help.registerTarget(dc_link_vinVoltageGraph, "DC link voltage is plotted in real time", 5, "advanceHelp")
        Help.registerTarget(foc_iout_IdGraph, "FOC current, Id is plotted in real time", 6, "advanceHelp")
        Help.registerTarget(foc_iout_IqGraph, "FOC current, Iq is plotted in real time", 7, "advanceHelp")
        Help.registerTarget(winding_iout_IuGraph, "Motor winding current, Iu is plotted in real time", 8, "advanceHelp")
        Help.registerTarget(winding_iout_IvGraph, "Motor winding current, Iv is plotted in real time", 9, "advanceHelp")
        Help.registerTarget(winding_iout_IwGraph, "Motor winding current, Iw is plotted in real time", 10, "advanceHelp")
    }

    Rectangle{
        anchors.fill: parent
        width : parent.width
        height: parent.height

        Rectangle {
            id: pageLable
            width: parent.width/2
            height: parent.height/ 12
            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: pageText
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }

                text:  "<b>"+ multiplePlatform.opn +"<b>"

                font.pixelSize: (parent.width + parent.height)/ 22
                color: "black"
            }
        }

        Rectangle {
            id: controlSection1
            width: parent.width
            height: parent.height - 100
            anchors{
                top: pageLable.bottom
                topMargin: 70
            }

            Rectangle {
                id: logInfoBox
                color: "transparent"; width: parent.width*0.1; height: parent.height/4

                Text {
                    id: nameLogInfoBox
                    text: "Error status"
                    anchors {
                        top : labelledInfoBox.top
                        topMargin : -parent.height/7
                        left: parent.left
                        leftMargin: parent.width/4
                    }
                    font.pixelSize: parent.height/10
                    color: "black"
                }

                Widget09.SGLabelledInfoBox {
                    id: labelledInfoBox
                    infoBoxWidth: parent.width*3.5
                    anchors {
                        top : parent.top
                        topMargin : -parent.height/6
                        left: resetErrorButton.right
                        leftMargin: 0
                    }
                    textPixelSize: (parent.width + parent.height)/18
                    infoBoxHeight: parent.height/7
                    label: ""
                    info: error_code
                    labelLeft: false						// Default: true (if false, label will be on top)
                    infoBoxColor: "lightgray"			// Default: "#eeeeee" (light gray)
                    infoBoxBorderColor: "grey"		    // Default: "#cccccc" (light gray)
                    infoBoxBorderWidth: 3   			// Default: 1 (assign 0 for no border)
                    textColor: "red"					// Default: "black" (colors label as well as text in box
                }

                Button {
                    id:resetErrorButton
                    anchors {
                        top : parent.top
                        topMargin : -parent.height/6
                        left: nameLogInfoBox.left
                        leftMargin: 0
                    }
                    font.pixelSize: (parent.width + parent.height)/30
                    text: "Reset"
                    visible: true
                    width: parent.width/2
                    height: parent.height/7
                    onClicked: {
                        platformInterface.set_system_mode.update(4)
                        basicControl.error_code = ""
                    }
                }
            }

            Rectangle {
                id: topControl
                anchors {
                    left: controlSection1.left
                    top: controlSection1.top
                }
                width: parent.width
                height: controlSection1.height/3

                SGCircularGauge {
                    id: targetSpeedGauge
                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: 20
                    }

                    width: parent.width/7.5
                    height: parent.height
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: max_motor_speed
                    tickmarkStepSize: {
                        if (max_motor_speed <= 100){5}
                            else {if (max_motor_speed <= 500){25}
                            else if (max_motor_speed <= 1000){50}
                            else if (max_motor_speed <= 2000){100}
                            else if (max_motor_speed <= 3000){200}
                            else if (max_motor_speed >= 4000){500}
                            }
                    }
                    outerColor: "#999"
                    unitLabel: "RPM"
                    gaugeTitle: "Target Speed"
                    value: platformInterface.status_vi.t
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                SGCircularGauge {
                    id: actualSpeedGauge
                    anchors {
                        left: targetSpeedGauge.right
                        leftMargin: 20
                        top: parent.top
                    }

                    width: parent.width/7.5
                    height: parent.height
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: max_motor_speed
                    tickmarkStepSize: {
                        if (max_motor_speed <= 100){5}
                            else {if (max_motor_speed <= 500){25}
                            else if (max_motor_speed <= 1000){50}
                            else if (max_motor_speed <= 2000){100}
                            else if (max_motor_speed <= 3000){200}
                            else if (max_motor_speed >= 4000){500}
                            }
                    }
                    outerColor: "#999"
                    unitLabel: "RPM"
                    gaugeTitle: "Actual Speed"
                    value: platformInterface.status_vi.a
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                SGCircularGauge {
                    id: hzGauge
                    anchors {
                        left: actualSpeedGauge.right
                        leftMargin: 20
                        top: parent.top
                    }

                    width: parent.width/7.5
                    height: parent.height
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: ((max_motor_speed/60)*pole_pairs).toFixed(0)
                    tickmarkStepSize: {
                        if (((max_motor_speed/60)*pole_pairs).toFixed(0) <= 100){5}
                            else {if (((max_motor_speed/60)*pole_pairs).toFixed(0) <= 500){25}
                            else if (((max_motor_speed/60)*pole_pairs).toFixed(0) <= 1000){50}
                            else if (((max_motor_speed/60)*pole_pairs).toFixed(0) <= 2000){100}
                            else if (((max_motor_speed/60)*pole_pairs).toFixed(0) <= 3000){200}
                            else if (((max_motor_speed/60)*pole_pairs).toFixed(0) <= 10000){500}
                            else if (((max_motor_speed/60)*pole_pairs).toFixed(0) > 10000){1000}
                            }
                    }
                    outerColor: "#999"
                    unitLabel: "Hz"
                    gaugeTitle: "Frequency"
                    value: frequency
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                GraphConverter {
                    id: actualSpeedGraph
                    width: parent.width/2.5
                    height: parent.height*1.3
                    anchors {
                        left: hzGauge.right
                        leftMargin: 20
                        top: parent.top
                        topMargin: -parent.height/3
                        right:parent.right
                        rightMargin: 5
                    }
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
                    pointCount: pointsCount
                    title: "<b>Actual Speed</b>"
                    yAxisTitle: "<b>RPM</b>"
                    xAxisTitle: "<b>Time / div<b>"
                    inputData: platformInterface.status_vi.a
                    maxYValue: 10000
                    minYValue: 0
                    showYGrids: true
                    showXGrids: true
                    minXValue: 0
                    maxXValue: time
                    reverseDirection: false
                    zoomXEnabled: false
                    zoomYEnabled: false
                    panXEnabled: false
                    panYEnabled: false
                    autoUpdate: false
                    // 'autoUpdate' property for 'SGGraph' is set to false, but 'autoUpdateCurve' property of
                    // 'GraphConverter' is set to true by default - update of curve causes also graph update
                }
            } // end of left control

            Rectangle {
                width: parent.width
                height: parent.height/1.7
                color: "transparent"

                anchors {
                    top : topControl.bottom
                    topMargin: 0
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
                        id: dc_link_vinVoltageGraph
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
                        pointCount: pointsCount
                        xAxisTitle: ""
                        yAxisTitle: "DC link voltage (V)"
                        inputData: dc_link_vin_calc
                        maxYValue: 500
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: time
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: dc_link_vinVoltage
                        label: ""
                        info: {(platformInterface.status_vi.l/1000).toFixed(3)}
                        infoBoxColor: if (multiplePlatform.nominalVin < dc_link_vin_calc) {"red"}
                                      else{"lightgrey"}
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        unit: "V"
                        infoBoxWidth: dc_link_vinVoltageGraph.width/1.5
                        infoBoxHeight : dc_link_vinVoltageGraph.height/10
                        fontSize :  (dc_link_vinVoltageGraph.width + dc_link_vinVoltageGraph.height)/37
                        unitSize: (dc_link_vinVoltageGraph.width + dc_link_vinVoltageGraph.height)/35
                        anchors {
                            top : dc_link_vinVoltageGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: dc_link_vinVoltageGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: foc_iout_IdGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: dc_link_vinVoltageGraph.right
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
                        pointCount: pointsCount
                        xAxisTitle: ""
                        yAxisTitle: "Id (A)"
                        inputData: foc_iout_id_calc
                        maxYValue: amperes
                        minYValue: amperes*-1
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: time
                        reverseDirection: true
                    }


                    SGLabelledInfoBox {
                        id: foc_iout_IdCurrent
                        label: ""
                        info:  {(platformInterface.status_vi.d/1000).toFixed(3)}
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        unit: "A"
                        infoBoxWidth: foc_iout_IdGraph.width/1.5
                        infoBoxHeight : foc_iout_IdGraph.height/10
                        fontSize :  (foc_iout_IdGraph.width + foc_iout_IdGraph.height)/37
                        unitSize: (foc_iout_IdGraph.width + foc_iout_IdGraph.height)/35
                        anchors {
                            top : foc_iout_IdGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: foc_iout_IdGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: foc_iout_IqGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: foc_iout_IdGraph.right
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
                        pointCount: pointsCount
                        xAxisTitle: ""
                        yAxisTitle: "Iq (A)"
                        inputData: foc_iout_iq_calc
                        maxYValue: amperes
                        minYValue: amperes*-1
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: time
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: foc_iout_IqCurrent
                        label: ""
                        info:  {(platformInterface.status_vi.q/1000).toFixed(3)}
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        unit: "A"
                        infoBoxWidth: foc_iout_IqGraph.width/1.5
                        infoBoxHeight : foc_iout_IqGraph.height/10
                        fontSize :  (foc_iout_IqGraph.width + foc_iout_IqGraph.height)/37
                        unitSize: (foc_iout_IqGraph.width + foc_iout_IqGraph.height)/35
                        anchors {
                            top : foc_iout_IqGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: foc_iout_IqGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: winding_iout_IuGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: foc_iout_IqGraph.right
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
                        pointCount: pointsCount
                        xAxisTitle: ""
                        yAxisTitle: "Iu (A)"
                        inputData: winding_iout_iu_calc
                        maxYValue: amperes
                        minYValue: amperes*-1
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: time
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: winding_iout_IuCurrent
                        label: ""
                        info:  {(platformInterface.status_vi.u/1000).toFixed(3)}
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        unit: "A"
                        infoBoxWidth: winding_iout_IuGraph.width/1.5
                        infoBoxHeight : winding_iout_IuGraph.height/10
                        fontSize :  (winding_iout_IuGraph.width + winding_iout_IuGraph.height)/37
                        unitSize: (winding_iout_IuGraph.width + winding_iout_IuGraph.height)/35
                        anchors {
                            top : winding_iout_IuGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: winding_iout_IuGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: winding_iout_IvGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: winding_iout_IuGraph.right
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
                        pointCount: pointsCount
                        xAxisTitle: ""
                        yAxisTitle: "Iv (A)"
                        inputData: winding_iout_iv_calc
                        maxYValue: amperes
                        minYValue: amperes*-1
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: time
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: winding_iout_IvCurrent
                        label: ""
                        info:  {(platformInterface.status_vi.v/1000).toFixed(3)}
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        unit: "A"
                        infoBoxWidth: winding_iout_IvGraph.width/1.5
                        infoBoxHeight : winding_iout_IvGraph.height/10
                        fontSize :  (winding_iout_IvGraph.width + winding_iout_IvGraph.height)/37
                        unitSize: (winding_iout_IvGraph.width + winding_iout_IvGraph.height)/35
                        anchors {
                            top : winding_iout_IvGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: winding_iout_IvGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }

                    GraphConverter{
                        id: winding_iout_IwGraph
                        width: parent.width/6
                        height: parent.height/1.05
                        anchors {
                            left: winding_iout_IvGraph.right
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
                        pointCount: pointsCount
                        xAxisTitle: ""
                        yAxisTitle: "Iw (A)"
                        inputData: winding_iout_iw_calc
                        maxYValue: amperes
                        minYValue: amperes*-1
                        showYGrids: true
                        showXGrids: true
                        minXValue: 0
                        maxXValue: time
                        reverseDirection: true
                    }

                    SGLabelledInfoBox {
                        id: winding_iout_IwCurrent
                        label: ""
                        info:  {(platformInterface.status_vi.w/1000).toFixed(3)}
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        unit: "A"
                        infoBoxWidth: winding_iout_IwGraph.width/1.5
                        infoBoxHeight : winding_iout_IwGraph.height/10
                        fontSize :  (winding_iout_IwGraph.width + winding_iout_IwGraph.height)/37
                        unitSize: (winding_iout_IwGraph.width + winding_iout_IwGraph.height)/35
                        anchors {
                            top : winding_iout_IwGraph.bottom
                            topMargin : parent.height/100
                            horizontalCenter: winding_iout_IwGraph.horizontalCenter
                            horizontalCenterOffset:  parent.height/15
                        }
                    }
                }
            }
        }
    }
}
