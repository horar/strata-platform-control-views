/*
 * Copyright (c) 2018-2021 onsemi.
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
import "qrc:/js/navigation_control.js" as NavigationControl
import "sgwidgets/"
import "qrc:/image"
import "qrc:/js/help_layout_manager.js" as Help

Item {
    id: root
    height: parent.width/4
    width: parent.width

    property bool debugLayout: false

    property var dc_link_vin_calc: platformInterface.status_vi.l

    property var temp_U_calc: platformInterface.status_vi.U
    property var temp_V_calc: platformInterface.status_vi.V
    property var temp_W_calc: platformInterface.status_vi.W

    property var time: settingsControl.time
    property var pointsCount: settingsControl.pointsCount

    Rectangle {
        id: measuredValues

        anchors.fill: parent
        color: "transparent"

        anchors {
            top: parent.top
            topMargin: parent.height/20
            left: parent.left
            leftMargin: 0
        }

        GraphConverter{
            id: temp_U_graph
            width: parent.width/4
            height: parent.height/1.3
            anchors {
                left: parent.left
                leftMargin: 0
                top: parent.top
                topMargin: -parent.height/20
            }
            showOptions: false
            autoAdjustMaxMin: false
            //repeatOldData: visible
            dataLineColor: "brown"
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
            yAxisTitle: "Temperature 1 (°C)"
            inputData: temp_U_calc
            maxYValue: 200
            showYGrids: true
            showXGrids: true
            minXValue: 0
            maxXValue: time
            reverseDirection: true
        }

        SGLabelledInfoBox {
            id: temp_U_box
            label: ""
            info: temp_U_calc
            infoBoxColor: "lightgrey"
            infoBoxBorderColor: "grey"
            infoBoxBorderWidth: 3
            unit: "°C"
            infoBoxWidth: temp_U_graph.width/3
            infoBoxHeight : temp_U_graph.height/10
            fontSize :  (temp_U_graph.width + temp_U_graph.height)/37
            unitSize: (temp_U_graph.width + temp_U_graph.height)/35
            anchors {
                top : temp_U_graph.bottom
                topMargin : parent.height/100
                horizontalCenter: temp_U_graph.horizontalCenter
            }
        }

        GraphConverter{
            id: temp_V_graph
            width: parent.width/4
            height: parent.height/1.3
            anchors {
                left: temp_U_graph.right
                leftMargin: 0
                top: parent.top
                topMargin: -parent.height/20
            }
            showOptions: false
            autoAdjustMaxMin: false
            //repeatOldData: visible
            dataLineColor: "black"
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
            yAxisTitle: "Temperature 2 (°C)"
            inputData: temp_V_calc
            maxYValue: 200
            showYGrids: true
            showXGrids: true
            minXValue: 0
            maxXValue: time
            reverseDirection: true
        }

        SGLabelledInfoBox {
            id: temp_V_box
            label: ""
            info: temp_V_calc
            infoBoxColor: "lightgrey"
            infoBoxBorderColor: "grey"
            infoBoxBorderWidth: 3
            unit: "°C"
            infoBoxWidth: temp_V_graph.width/3
            infoBoxHeight : temp_V_graph.height/10
            fontSize :  (temp_V_graph.width + temp_V_graph.height)/37
            unitSize: (temp_V_graph.width + temp_V_graph.height)/35
            anchors {
                top : temp_U_graph.bottom
                topMargin : parent.height/100
                horizontalCenter: temp_V_graph.horizontalCenter
            }
        }

        GraphConverter{
            id: temp_W_graph
            width: parent.width/4
            height: parent.height/1.3
            anchors {
                left: temp_V_graph.right
                leftMargin: 0
                top: parent.top
                topMargin: -parent.height/20
            }
            showOptions: false
            autoAdjustMaxMin: false
            //repeatOldData: visible
            dataLineColor: "darkgrey"
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
            yAxisTitle: "Temperature 3 (°C)"
            inputData: temp_W_calc
            maxYValue: 200
            showYGrids: true
            showXGrids: true
            minXValue: 0
            maxXValue: time
            reverseDirection: true
        }

        SGLabelledInfoBox {
            id: temp_W_box
            label: ""
            info: temp_W_calc
            infoBoxColor: "lightgrey"
            infoBoxBorderColor: "grey"
            infoBoxBorderWidth: 3
            unit: "°C"
            infoBoxWidth: temp_W_graph.width/3
            infoBoxHeight : temp_W_graph.height/10
            fontSize :  (temp_W_graph.width + temp_W_graph.height)/37
            unitSize: (temp_W_graph.width + temp_W_graph.height)/35
            anchors {
                top : temp_W_graph.bottom
                topMargin : parent.height/100
                horizontalCenter: temp_W_graph.horizontalCenter
            }
        }

        GraphConverter{
            id: dcLink_graph
            width: parent.width/4
            height: parent.height/1.3
            anchors {
                left: temp_W_graph.right
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
            yAxisTitle: "DC Link (Volts)"
            inputData: dc_link_vin_calc
            maxYValue: multiplePlatform.vinScale
            showYGrids: true
            showXGrids: true
            minXValue: 0
            maxXValue: time
            reverseDirection: true
        }

        SGLabelledInfoBox {
            id: dcLink_box
            label: ""
            info: dc_link_vin_calc
            infoBoxColor: "lightgrey"
            infoBoxBorderColor: "grey"
            infoBoxBorderWidth: 3
            unit: "Volts"
            infoBoxWidth: dcLink_graph.width/3
            infoBoxHeight : dcLink_graph.height/10
            fontSize :  (dcLink_graph.width + dcLink_graph.height)/37
            unitSize: (dcLink_graph.width + dcLink_graph.height)/35
            anchors {
                top : dcLink_graph.bottom
                topMargin : parent.height/100
                horizontalCenter: dcLink_graph.horizontalCenter
            }
        }


    }

}

