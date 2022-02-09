/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.6
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import tech.strata.sgwidgets 0.9 as Widget09
import tech.strata.sgwidgets 1.0 as Widget01
import tech.strata.fonts 1.0
import QtGraphicalEffects 1.0
import "qrc:/js/help_layout_manager.js" as Help
import QtQuick.Dialogs 1.2
import tech.strata.logger 1.0
import QtCharts 2.0
import QtQml 2.0

ColumnLayout {
    id: root

    Component.onCompleted: {
        graphTimerPoints.start()
        graphTimerPoints1.start()

        dataArray_effi_calc_graph = []
        dataArray_temp_calc_graph = []
        dataArray_vin_calc_graph = []
        dataArray_vout_calc_graph = []
        dataArray_iin_calc_graph = []
        dataArray_iout_calc_graph = []

        if(basicGraph.count > 0) {
            basicGraph.removeCurve(0)
        }
        if(basicGraph1.count > 0) {
            basicGraph1.removeCurve(0)
        }
        Help.registerTarget(rect432,"Reset charts and starts new measurement.", 0, "exportControlHelp")
        Help.registerTarget(rect433,"Exports all data to Excel as a log file.", 1, "exportControlHelp")
        Help.registerTarget(graphSelector,"Graph selector.", 2, "exportControlHelp")
    }
    property var graph_selected1
    property var graph_selected2
    property var graph_selected3
    property var graph_selected4
    property var graph_selected5
    property var graph_selected6
    property real ratioCalc: root.width / 1200
    property real initialAspectRatio: 1200/820
    property alias virtualtextarea: virtualtextarea
    property alias logSwitch: logSwitch
    property var x_Axis_Timer_:0
    property var x_Axis_Timer_1:0
    property  int clear:0

    property var vin_calc: platformInterface.status_voltage_current.vin/1000
    property var dataArray_vin_calc_graph: []
    property var vin_calc_validator:0
    onVin_calcChanged:{
        vin_calc_validator++
        if(graph_selected1 === 1){
            if(vin_calc_validator>0){
                dataArray_vin_calc_graph.push({"x":x_Axis_Timer_1,"y":vin_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var iin_calc: platformInterface.status_voltage_current.iin/1000
    property var dataArray_iin_calc_graph: []
    property var iin_calc_validator:0
    onIin_calcChanged:{
        iin_calc_validator++
        if(graph_selected2 === 1){
            if(iin_calc_validator>0){
                dataArray_iin_calc_graph.push({"x":x_Axis_Timer_,"y":iin_calc})
                x_Axis_Timer_=x_Axis_Timer_+(+virtualtextarea.realtimelog)
                basicGraph.xMax = x_Axis_Timer_
            }
        }
    }

    property var vout_calc: platformInterface.status_voltage_current.vout/1000
    property var dataArray_vout_calc_graph: []
    property var vout_calc_validator:0
    onVout_calcChanged:{
        vout_calc_validator++
        if(graph_selected3 === 1){
            if(vout_calc_validator>0){
                dataArray_vout_calc_graph.push({"x":x_Axis_Timer_,"y":vout_calc})
                x_Axis_Timer_=x_Axis_Timer_+(+virtualtextarea.realtimelog)
                basicGraph.xMax = x_Axis_Timer_
            }
        }
    }

    property var iout_calc: platformInterface.status_voltage_current.iout/1000
    property var dataArray_iout_calc_graph: []
    property var iout_calc_validator:0
    onIout_calcChanged:{
        iout_calc_validator++
        if(graph_selected4 === 1){
            if(iout_calc_validator>0){
                dataArray_iout_calc_graph.push({"x":x_Axis_Timer_1,"y":iout_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var pin_calc: vin_calc * iin_calc
    property var pout_calc: vout_calc * iout_calc

    property var effi_calc: ((pout_calc * 100) / pin_calc).toFixed(3)
    property var dataArray_effi_calc_graph: []
    property var effi_calc_validator:0
    onEffi_calcChanged:{
        effi_calc_validator++
        if(graph_selected5 === 1){
            if(effi_calc_validator>0){
                dataArray_effi_calc_graph.push({"x":x_Axis_Timer_1,"y":effi_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var temp_calc: (platformInterface.status_temperature_pmbus.temperature_pmbus).toFixed(0)
    property var dataArray_temp_calc_graph: []
    property var temp_calc_validator:0
    onTemp_calcChanged:{
        temp_calc_validator++
        if(graph_selected6 === 1){
            if(temp_calc_validator>0){
                dataArray_temp_calc_graph.push({"x":x_Axis_Timer_1,"y":temp_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    function clearGraphsData() {
        if (clear==1){
            dataArray_vin_calc_graph = []
            dataArray_iin_calc_graph = []
            dataArray_vout_calc_graph = []
            dataArray_iout_calc_graph = []
            dataArray_effi_calc_graph = []
            dataArray_temp_calc_graph = []

            if(basicGraph.count > 0) {
                basicGraph.removeCurve(0)
            }
            if(basicGraph1.count > 0) {
                basicGraph1.removeCurve(0)
            }
            vin_calc_validator=0
            iin_calc_validator=0
            vout_calc_validator=0
            iout_calc_validator=0
            effi_calc_validator=0
            temp_calc_validator=0

            x_Axis_Timer_=0
            x_Axis_Timer_1=0
            basicGraph1.xMax=+virtualtextarea.realtimelog
            basicGraph.xMax=+virtualtextarea.realtimelog
            clear=0;
        }
        return 0
    }

    spacing: 1
    anchors {
        fill: parent
        bottom: parent.bottom
        bottomMargin: 1
        topMargin: 0

    }

    RowLayout {
        id: rowLayout
        width: root.width
        height: root.height

        Item {
            id: main_item
            width: root.width
            height: root.height

            Rectangle {
                id: mainrect
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                color: "white"
                Layout.fillHeight: true
                Layout.fillWidth: true
                border.width: 0
                border.color: "transparent"

                Grid {
                    id: maingrid
                    anchors.fill: parent
                    columns: 1
                    spacing:1

                    Rectangle {
                        id: rect2
                        color: "white"
                        width: parent.width
                        height: parent.height*0.5
                        border.width: 0
                        border.color: "lightgrey"

                        TextArea{
                            id:virtualtextarea
                            visible: false
                            font.pixelSize: 5
                            persistentSelection: true
                            text: virtualtextarea.text

                            property int realtimelog:foo1()
                            function foo1(){
                                return 1 //pointsCount
                            }

                            //time capture start
                            property var start_stop_time: logSwitch.clear_log_data
                            property var start_time: 0
                            property var start_check:0
                            property var one_time_top_row_excel: 0


                            onStart_stop_timeChanged:{
                                if(start_check===0){
                                    start_time= (new Date().toLocaleString(Qt.locale(),"yyyy/MM/dd h:mm:ss.zzz"))
                                    start_check=1
                                    }
                                }
                            }

                        Rectangle {
                            id: rectangle_graphs
                            color: "white"
                            width: parent.width
                            height: parent.height
                            anchors.bottom: parent.bottom
                            Rectangle {
                                anchors.fill: parent
                                Rectangle {
                                    width: parent.width
                                    height: parent.height*0.7
                                    anchors.top: parent.top
                                    Widget01.SGGraph {
                                        id: basicGraph
                                        anchors.fill: parent
                                        anchors.left: parent.left
                                        anchors.leftMargin: 8
                                        title: ""
                                        xMin: 0
                                        xMax: +virtualtextarea.realtimelog
                                        yMin: 0
                                        yMax: 20
                                        backgroundColor: "white"
                                        foregroundColor: "black"
                                        xTitle: ""
                                        yTitle: "Iin (A) / Vout (V)"

                                        Button {
                                            id:resetChartButton
                                            anchors {
                                                top:parent.top
                                                topMargin: 100
                                                right: parent.right
                                            }
                                            text: "Reset"
                                            visible: true
                                            width: 60
                                            height: 30
                                            onClicked: {
                                                basicGraph.resetChart()
                                            }
                                        }

                                        Text {
                                            id: iinSideText
                                            anchors {
                                                top: resetChartButton.bottom
                                                topMargin: (parent.width + parent.height)/ 150
                                                right: resetChartButton.right
                                                rightMargin: (parent.width + parent.height)/ 150
                                            }
                                            text: ""+ (platformInterface.status_voltage_current.iin/1000).toFixed(3) +" A"
                                            font.pixelSize: (parent.width + parent.height)/ 150
                                            color: "green"
                                        }

                                        Text {
                                            id: voutSideText
                                            anchors {
                                                top: iinSideText.bottom
                                                right: resetChartButton.right
                                                rightMargin: (parent.width + parent.height)/ 150
                                            }
                                            text: ""+ (platformInterface.status_voltage_current.vout/1000).toFixed(3) +" V"
                                            font.pixelSize: (parent.width + parent.height)/ 150
                                            color: "blue"
                                        }

                                        function resetChart() {
                                            basicGraph.xMin = 0//somevalue
                                            basicGraph.xMax = x_Axis_Timer_//basicGraph.xMax	//somevalue
                                            basicGraph.yMin = 0//somevalue
                                            basicGraph.yMax = 20//somevalue
                                        }

                                        Text {
                                            id: iinText
                                            text: "<b>Input Current<b>"
                                            anchors.top: basicGraph.bottom
                                            anchors.topMargin: parent.height*0.01
                                            anchors.right: parent.right
                                            anchors.rightMargin: parent.width*0.01
                                            font.pixelSize: parent.height*0.04
                                            color: "green"
                                        }

                                        Text {
                                            id: voutText
                                            text: "<b>Output Voltage<b>"
                                            anchors.top: basicGraph.bottom
                                            anchors.topMargin: parent.height*0.01
                                            anchors.right: iinText.left
                                            anchors.rightMargin: parent.width*0.01
                                            font.pixelSize: parent.height*0.04
                                            color: "blue"
                                        }

                                    }

                                    Timer{
                                        id: graphTimerPoints
                                        interval: +virtualtextarea.realtimelog*300
                                        running: false
                                        repeat: true
                                        onTriggered: {

                                            if(basicGraph.count > 0) {
                                                basicGraph.removeCurve(0)
                                            }

                                            if(graph_selected2 === 1){
                                                var curve1 = basicGraph.createCurve("graphCurve")
                                                curve1.color = "green"
                                                curve1.appendList(dataArray_iin_calc_graph)
                                            }

                                            if(graph_selected3 === 1){
                                                var curve2 = basicGraph.createCurve("graphCurve")
                                                curve2.color = "blue"
                                                curve2.appendList(dataArray_vout_calc_graph)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: rect4
                        color: "transparent"
                        width: parent.width
                        height: parent.height*0.85
                        border.width: 0
                        border.color: "lightgrey"
                        Grid {
                            id: grid4
                            anchors.fill: parent
                            rows: 3
                            spacing: 0

                            Rectangle {
                                id: rect41
                                color: "#ffffff"
                                width: parent.width
                                height: parent.height*0.47
                                border.width: 0; border.color: "#fafafa"
                                Rectangle {
                                    id: rect214
                                    color: "#FDEEF4"; width: parent.width; height: parent.height*1.25
                                    anchors.bottom:parent.bottom
                                    anchors.bottomMargin: 19
                                    anchors.right: parent.right
                                    Rectangle {
                                        anchors.fill: parent
                                        Widget01.SGGraph {
                                            id: basicGraph1
                                            anchors.fill: parent
                                            anchors.left: parent.left
                                            anchors.leftMargin: 8
                                            title: ""
                                            xMin: 0
                                            xMax: +virtualtextarea.realtimelog
                                            yMin: 0
                                            yMax: 100
                                            backgroundColor: "white"
                                            foregroundColor: "black"
                                            xTitle: "Realtime Log Samples"
                                            yTitle: "Vin (V) / Iout (A) / Effi. (%) / Chip Temp. (°C)"

                                            Button {
                                                id:resetChartButton1
                                                anchors {
                                                    top:parent.top
                                                    topMargin: 0
                                                    right: parent.right
                                                }
                                                text: "Reset"
                                                visible: true
                                                width: 60
                                                height: 30
                                                onClicked: {
                                                    basicGraph1.resetChart()
                                                }
                                            }

                                            Text {
                                                id: vinSideText
                                                anchors {
                                                    top: resetChartButton1.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (platformInterface.status_voltage_current.vin/1000).toFixed(3) +" V"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "blue"
                                            }

                                            Text {
                                                id: ioutSideText
                                                anchors {
                                                    top: vinSideText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (platformInterface.status_voltage_current.vout/1000).toFixed(3) +" A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "green"
                                            }

                                            Text {
                                                id: effiSideText
                                                anchors {
                                                    top: ioutSideText.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ ((pout_calc * 100) / pin_calc).toFixed(3) +" %"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "purple"
                                            }

                                            Text {
                                                id: tempSideText
                                                anchors {
                                                    top: effiSideText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (platformInterface.status_temperature_pmbus.temperature_pmbus).toFixed(0) +" °C"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "red"
                                            }

                                            function resetChart() {
                                                basicGraph1.xMin = 0
                                                basicGraph1.xMax = x_Axis_Timer_1
                                                basicGraph1.yMin = 0
                                                basicGraph1.yMax = 100
                                            }

                                            Text {
                                                id: vinText
                                                text: "<b>Input Voltage<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: parent.right
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "blue"
                                            }

                                            Text {
                                                id: ioutText
                                                text: "<b>Output Current<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: vinText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "green"
                                            }

                                            Text {
                                                id: effiText
                                                text: "<b>Efficieny<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: ioutText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "purple"
                                            }

                                            Text {
                                                id: tempText
                                                text: "<b>Chip Temperature<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: effiText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "red"
                                            }

                                        }

                                        Timer{
                                            id: graphTimerPoints1
                                            interval: +virtualtextarea.realtimelog
                                            running: false
                                            repeat: true
                                            onTriggered: {

                                                if(basicGraph1.count > 0) {
                                                    basicGraph1.removeCurve(0)
                                                }

                                                if(graph_selected1 === 1){
                                                    var curve3 = basicGraph1.createCurve("graphCurve")
                                                    curve3.color = "blue"
                                                    curve3.appendList(dataArray_vin_calc_graph)
                                                }

                                                if(graph_selected4 === 1){
                                                    var curve4 = basicGraph1.createCurve("graphCurve")
                                                    curve4.color = "green"
                                                    curve4.appendList(dataArray_iout_calc_graph)
                                                }

                                                if(graph_selected5 === 1){
                                                    var curve5 = basicGraph1.createCurve("graphCurve")
                                                    curve5.color = "purple"
                                                    curve5.appendList(dataArray_effi_calc_graph)
                                                }

                                                if(graph_selected6 === 1){
                                                    var curve6 = basicGraph1.createCurve("graphCurve")
                                                    curve6.color = "red"
                                                    curve6.appendList(dataArray_temp_calc_graph)
                                                }
                                            }
                                        }
                                    }
                                }

                            }

                            Rectangle {
                                id: rect43
                                color: "transparent"; width: parent.width*0.99; height: parent.height*0.22
                                border.width: 0
                                border.color: "transparent"

                                Grid {
                                    id: grid42
                                    anchors.fill: parent
                                    columns: 3
                                    spacing: 1

                                    Rectangle {
                                        id: rect432
                                        color: "#00000000"
                                        width: parent.width*0.15
                                        height: parent.height

                                        Text {
                                            id: name320
                                            text: "Measure (Start/Reset)"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: -parent.height*0.01
                                            font.pixelSize: parent.height*0.1
                                            color: "black"
                                        }

                                        Widget09.SGSwitch{
                                            id: logSwitch
                                            switchWidth: 105
                                            switchHeight: 46
                                            checkedLabel: "<b>Reset</b>"
                                            uncheckedLabel: "<b>Start</b>"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: parent.height*0.18
                                            label: ""
                                            labelLeft: false
                                            labelsInside: true
                                            textColor: "black"
                                            handleColor: "#fff9f4"
                                            grooveColor: "#00b82c"
                                            grooveFillColor: "#ff471a"
                                            property var condition1: "start"
                                            property var condition0: "stop"
                                            property var start_stop_measure: 0
                                            property var clear_log_data:2

                                            onClicked: {
                                                if(logSwitch.checked == true) {
                                                    clear=1
                                                    clearGraphsData()
                                                    clear_log_data=1
                                                }
                                                if(logSwitch.checked == false){
                                                    clear_log_data=0
                                                    virtualtextarea.start_check=0
                                                }
                                            }
                                        }
                                    }

                                    Rectangle {
                                        id: rect433
                                        color: "#00000000"
                                        width: parent.width*0.2
                                        height: parent.height
                                        Text {
                                            id: name321
                                            text: "Log File"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: -parent.height*0.01
                                            font.pixelSize: parent.height*0.1
                                            color: "black"
                                        }

                                        SaveDialogMenu {
                                            id:save_dialog_menu
                                            anchors.left: parent.left
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: parent.height*0.18
                                        }
                                    }

                                    Rectangle {
                                        id: rect434
                                        color: "#00000000"
                                        width: parent.width
                                        height: parent.height

                                        Widget09.SGSegmentedButtonStrip {
                                            id: graphSelector
                                            label: "<b>Show Graphs:</b>"
                                            labelLeft: true

                                            textColor: "#666"
                                            activeTextColor: "white"
                                            activeColor: "green"
                                            radius: parent.height*0.04
                                            buttonHeight: parent.height*0.2
                                            exclusive: false
                                            buttonImplicitWidth: (parent.width + parent.height)/30
                                            property int howManyChecked: 0

                                            segmentedButtons: GridLayout {
                                                columnSpacing: 2
                                                rowSpacing: 2

                                                Widget09.SGSegmentedButton{
                                                    text: qsTr("Vin")
                                                    onCheckedChanged: {
                                                        if (checked) {
                                                            graph_selected1 = 1
                                                            graphSelector.howManyChecked++
                                                        } else {
                                                            graph_selected1 = 0
                                                            graphSelector.howManyChecked--
                                                        }
                                                    }
                                                }

                                                Widget09.SGSegmentedButton{
                                                    text: qsTr("Iin")
                                                    onCheckedChanged: {
                                                        if (checked) {
                                                            graph_selected2 = 1
                                                            graphSelector.howManyChecked++
                                                        } else {
                                                            graph_selected2 = 0
                                                            graphSelector.howManyChecked--
                                                        }
                                                    }
                                                }

                                                Widget09.SGSegmentedButton{
                                                    text: qsTr("Vout")
                                                    onCheckedChanged: {
                                                        if (checked) {
                                                            graph_selected3 = 1
                                                            graphSelector.howManyChecked++
                                                        } else {
                                                            graph_selected3 = 0
                                                            graphSelector.howManyChecked--
                                                        }
                                                    }
                                                }

                                                Widget09.SGSegmentedButton{
                                                    text: qsTr("Iout")
                                                    onCheckedChanged: {
                                                        if (checked) {
                                                            graph_selected4 = 1
                                                            graphSelector.howManyChecked++
                                                        } else {
                                                            graph_selected4 = 0
                                                            graphSelector.howManyChecked--
                                                        }
                                                    }
                                                }

                                                Widget09.SGSegmentedButton{
                                                    text: qsTr("Efficiency")
                                                    onCheckedChanged: {
                                                        if (checked) {
                                                            graph_selected5 = 1
                                                            graphSelector.howManyChecked++
                                                        } else {
                                                            graph_selected5 = 0
                                                            graphSelector.howManyChecked--
                                                        }
                                                    }
                                                }

                                                Widget09.SGSegmentedButton{
                                                    text: qsTr("Temperature")
                                                    onCheckedChanged: {
                                                        if (checked) {
                                                            graph_selected6 = 1
                                                            graphSelector.howManyChecked++
                                                        } else {
                                                            graph_selected6 = 0
                                                            graphSelector.howManyChecked--
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

