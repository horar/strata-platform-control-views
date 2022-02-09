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
        dataArray_actual_speed_calc_graph = []
        dataArray_dc_link_vin_calc_graph = []
        dataArray_winding_iout_iu_calc_graph = []
        dataArray_winding_iout_iv_calc_graph = []
        dataArray_winding_iout_iw_calc_graph = []
        dataArray_temp_U_calc_graph = []
        dataArray_temp_V_calc_graph = []
        dataArray_temp_W_calc_graph = []

        if(basicGraph.count > 0) {
            basicGraph.removeCurve(0)
        }
        if(basicGraph1.count > 0) {
            basicGraph1.removeCurve(0)
        }

        Help.registerTarget(basicGraph,"Speed/DC link graph:\n\t-Actual Speed.\n\t-DC Link Voltage.", 0, "exportControlHelp")
        Help.registerTarget(basicGraph1,"Current graph:\n\t-Winding Iout I1.\n\t-Winding Iout I2.\n\t-Winding Iout I3.\n\t-Temperature 1.\n\t-Temperature 2.\n\t-Temperature 3.\n\t-Frequency.", 1, "exportControlHelp")
        Help.registerTarget(rect431,"Error message status are shown here.", 2, "exportControlHelp")
        Help.registerTarget(rect432,"Reset charts and starts new measurement.", 3, "exportControlHelp")
        Help.registerTarget(rect433,"Exports all data to Excel as a log file.", 4, "exportControlHelp")
    }
    property var graph_selected1
    property var graph_selected2
    property var graph_selected3
    property var graph_selected4
    property var graph_selected5
    property var graph_selected6
    property var graph_selected7
    property var graph_selected8
    property real ratioCalc: root.width / 1200
    property real initialAspectRatio: 1200/820
    property alias virtualtextarea: virtualtextarea
    property alias logSwitch: logSwitch
    property var x_Axis_Timer_:0
    property var x_Axis_Timer_1:0
    property  int clear:0
    property var pointsCount: settingsControl.pointsCount

    // property that reads the initial notification
    property var pole_pairs: settingsControl.pole_pairs
    property var max_motor_speed: settingsControl.max_motor_speed

    property var resistance: (settingsControl.resistance/100).toFixed(3)
    property var inductance: (settingsControl.inductance/1000).toFixed(3)
    property var target_speed: platformInterface.status_vi.t.toFixed(0)
    property var max_motor_vout: settingsControl.max_motor_vout.toFixed(0)
    property var actual_speed: platformInterface.status_vi.a.toFixed(0)
    property var amperes: settingsControl.amperes

    property string error_code: basicControl.error_code

    property var actual_speed_calc: platformInterface.status_vi.a
    property var dataArray_actual_speed_calc_graph: []
    property var actual_speed_calc_validator:0
    onActual_speed_calcChanged:{
        actual_speed_calc_validator++
        if(graph_selected1 === 1){
            if(actual_speed_calc_validator>0){
                dataArray_actual_speed_calc_graph.push({"x":x_Axis_Timer_,"y":actual_speed_calc})
                x_Axis_Timer_=x_Axis_Timer_+(+virtualtextarea.realtimelog)
                basicGraph.xMax = x_Axis_Timer_
            }
        }
    }

    property var dc_link_vin_calc: platformInterface.status_vi.l
    property var dataArray_dc_link_vin_calc_graph: []
    property var dc_link_vin_calc_validator:0
    onDc_link_vin_calcChanged:{
        dc_link_vin_calc_validator++
        if(graph_selected2 === 1){
            if(dc_link_vin_calc_validator>0){
                dataArray_dc_link_vin_calc_graph.push({"x":x_Axis_Timer_,"y":dc_link_vin_calc})
                x_Axis_Timer_=x_Axis_Timer_+(+virtualtextarea.realtimelog)
                basicGraph.xMax = x_Axis_Timer_
            }
        }
    }

    property var winding_iout_iu_calc: platformInterface.status_vi.u
    property var dataArray_winding_iout_iu_calc_graph: []
    property var winding_iout_iu_calc_validator:0
    onWinding_iout_iu_calcChanged:{
        winding_iout_iu_calc_validator++
        if(graph_selected3 === 1){
            if(winding_iout_iu_calc_validator>0){
                dataArray_winding_iout_iu_calc_graph.push({"x":x_Axis_Timer_1,"y":winding_iout_iu_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var winding_iout_iv_calc: platformInterface.status_vi.v
    property var dataArray_winding_iout_iv_calc_graph: []
    property var winding_iout_iv_calc_validator:0
    onWinding_iout_iv_calcChanged:{
        winding_iout_iv_calc_validator++
        if(graph_selected4 === 1){
            if(winding_iout_iv_calc_validator>0){
                dataArray_winding_iout_iv_calc_graph.push({"x":x_Axis_Timer_1,"y":winding_iout_iv_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var winding_iout_iw_calc: platformInterface.status_vi.w
    property var dataArray_winding_iout_iw_calc_graph: []
    property var winding_iout_iw_calc_validator:0
    onWinding_iout_iw_calcChanged:{
        winding_iout_iw_calc_validator++
        if(graph_selected5 === 1){
            if(winding_iout_iw_calc_validator>0){
                dataArray_winding_iout_iw_calc_graph.push({"x":x_Axis_Timer_1,"y":winding_iout_iw_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var temp_U_calc: platformInterface.status_vi.U
    property var dataArray_temp_U_calc_graph: []
    property var temp_U_calc_validator:0
    onTemp_U_calcChanged:{
        temp_U_calc_validator++
        if(graph_selected6 === 1){
            if(temp_U_calc_validator>0){
                dataArray_temp_U_calc_graph.push({"x":x_Axis_Timer_1,"y":temp_U_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var temp_V_calc: platformInterface.status_vi.V
    property var dataArray_temp_V_calc_graph: []
    property var temp_V_calc_validator:0
    onTemp_V_calcChanged:{
        temp_V_calc_validator++
        if(graph_selected7 === 1){
            if(temp_V_calc_validator>0){
                dataArray_temp_V_calc_graph.push({"x":x_Axis_Timer_1,"y":temp_V_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var temp_W_calc: platformInterface.status_vi.W
    property var dataArray_temp_W_calc_graph: []
    property var temp_W_calc_validator:0
    onTemp_W_calcChanged:{
        temp_W_calc_validator++
        if(graph_selected8 === 1){
            if(temp_W_calc_validator>0){
                dataArray_temp_W_calc_graph.push({"x":x_Axis_Timer_1,"y":temp_W_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    function clearGraphsData() {
        if (clear==1){          
            dataArray_actual_speed_calc_graph = []
            dataArray_dc_link_vin_calc_graph = []
            dataArray_winding_iout_iu_calc_graph = []
            dataArray_winding_iout_iv_calc_graph = []
            dataArray_winding_iout_iw_calc_graph = []
            dataArray_temp_U_calc_graph = []
            dataArray_temp_V_calc_graph = []
            dataArray_temp_W_calc_graph = []

            if(basicGraph.count > 0) {
                basicGraph.removeCurve(0)
            }
            if(basicGraph1.count > 0) {
                basicGraph1.removeCurve(0)
            }
            actual_speed_calc_validator=0
            dc_link_vin_calc_validator=0
            winding_iout_iu_calc_validator=0
            winding_iout_iv_calc_validator=0
            winding_iout_iw_calc_validator=0
            temp_U_calc_validator=0
            temp_V_calc_validator=0
            temp_W_calc_validator=0

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
                                        yMax: max_motor_speed
                                        backgroundColor: "white"
                                        foregroundColor: "black"
                                        xTitle: ""
                                        yTitle: "RPM / Volts"

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
                                            id: rpmText
                                            anchors {
                                                top: resetChartButton.bottom
                                                topMargin: (parent.width + parent.height)/ 150
                                                right: resetChartButton.right
                                                rightMargin: (parent.width + parent.height)/ 150
                                            }
                                            text: ""+ platformInterface.status_vi.a +" rpm"
                                            font.pixelSize: (parent.width + parent.height)/ 150
                                            color: "orange"
                                        }

                                        Text {
                                            id: dclinkText
                                            anchors {
                                                top: rpmText.bottom
                                                right: resetChartButton.right
                                                rightMargin: (parent.width + parent.height)/ 150
                                            }
                                            text: ""+ dc_link_vin_calc +" V"
                                            font.pixelSize: (parent.width + parent.height)/ 150
                                            color: "blue"
                                        }

                                        function resetChart() {
                                            basicGraph.xMin = 0//somevalue
                                            basicGraph.xMax = x_Axis_Timer_//basicGraph.xMax	//somevalue
                                            basicGraph.yMin = 0//somevalue
                                            basicGraph.yMax = max_motor_speed//somevalue
                                        }

                                        Text {
                                            id: actual_speedText
                                            text: "<b>Actual Speed<b>"
                                            anchors.top: basicGraph.bottom
                                            anchors.topMargin: parent.height*0.01
                                            anchors.right: parent.right
                                            anchors.rightMargin: parent.width*0.01
                                            font.pixelSize: parent.height*0.04
                                            color: "orange"
                                        }

                                        Text {
                                            id: dc_link_vinText
                                            text: "<b>DC Link<b>"
                                            anchors.top: basicGraph.bottom
                                            anchors.topMargin: parent.height*0.01
                                            anchors.right: actual_speedText.left
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

                                            if(graph_selected1 === 1){
                                                var curve1 = basicGraph.createCurve("graphCurve")
                                                curve1.color = "orange"
                                                curve1.appendList(dataArray_actual_speed_calc_graph)
                                            }

                                            if(graph_selected2 === 1){
                                                var curve2 = basicGraph.createCurve("graphCurve")
                                                curve2.color = "blue"
                                                curve2.appendList(dataArray_dc_link_vin_calc_graph)
                                            }
                                        }
                                    }

                                    Widget09.SGSegmentedButtonStrip {
                                        id: graphSelector
                                        label: "<b>Show Graphs:</b>"
                                        labelLeft: true
                                        anchors {
                                            top: basicGraph.top
                                            topMargin: parent.height*0.03
                                            left: basicGraph.left
                                            leftMargin: parent.width/15
                                        }
                                        textColor: "#666"
                                        activeTextColor: "white"
                                        activeColor: "green"
                                        radius: parent.height*0.04
                                        buttonHeight: parent.height*0.005
                                        exclusive: false
                                        buttonImplicitWidth: (parent.width + parent.height)/40
                                        property int howManyChecked: 0

                                        segmentedButtons: GridLayout {
                                            columnSpacing: 2
                                            rowSpacing: 2

                                            Widget09.SGSegmentedButton{
                                                text: qsTr("Actual Speed")
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
                                                text: qsTr("DC link")
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
                                                text: qsTr("Winding I1")
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
                                                text: qsTr("Winding I2")
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
                                                text: qsTr("Winding I3")
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
                                                text: qsTr("Temp. 1")
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

                                            Widget09.SGSegmentedButton{
                                                text: qsTr("Temp. 2")
                                                onCheckedChanged: {
                                                    if (checked) {
                                                        graph_selected7 = 1
                                                        graphSelector.howManyChecked++
                                                    } else {
                                                        graph_selected7 = 0
                                                        graphSelector.howManyChecked--
                                                    }
                                                }
                                            }
                                            Widget09.SGSegmentedButton{
                                                text: qsTr("Temp. 3")
                                                onCheckedChanged: {
                                                    if (checked) {
                                                        graph_selected8 = 1
                                                        graphSelector.howManyChecked++
                                                    } else {
                                                        graph_selected8 = 0
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
                                            yMin: amperes*-1
                                            yMax: amperes
                                            backgroundColor: "white"
                                            foregroundColor: "black"
                                            xTitle: "Realtime Log Samples"
                                            yTitle: "Amperes / °C"

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
                                                id: iuText
                                                anchors {
                                                    top: resetChartButton1.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ winding_iout_iu_calc +"  A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "brown"
                                            }

                                            Text {
                                                id: ivText
                                                anchors {
                                                    top: iuText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ winding_iout_iv_calc +"  A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "black"
                                            }

                                            Text {
                                                id: iwText
                                                anchors {
                                                    top: ivText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ winding_iout_iw_calc +"  A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "grey"
                                            }

                                            Text {
                                                id: tuText
                                                anchors {
                                                    top: iwText.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ temp_U_calc +" °C"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "brown"
                                            }

                                            Text {
                                                id: tvText
                                                anchors {
                                                    top: tuText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ temp_V_calc +" °C"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "black"
                                            }

                                            Text {
                                                id: twText
                                                anchors {
                                                    top: tvText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ temp_W_calc +" °C"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "grey"
                                            }


                                            Text {
                                                id: hzText
                                                anchors {
                                                    top: twText.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (actual_speed/60)*pole_pairs +" Hz"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "blue"
                                            }

                                            function resetChart() {
                                                basicGraph1.xMin = 0
                                                basicGraph1.xMax = x_Axis_Timer_1
                                                basicGraph1.yMin = amperes*-1
                                                basicGraph1.yMax = amperes
                                            }

                                            Text {
                                                id: iWText
                                                text: "<b>Temp.3<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: parent.right
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "grey"
                                            }

                                            Text {
                                                id: iVText
                                                text: "<b>Temp.2<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: iWText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "black"
                                            }

                                            Text {
                                                id: iUText
                                                text: "<b>Temp.1<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: iVText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "brown"
                                            }

                                            Text {
                                                id: winding_iout_iwText
                                                text: "<b>Winding I3<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: iUText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "grey"
                                            }

                                            Text {
                                                id: winding_iout_ivText
                                                text: "<b>Winding I2<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: winding_iout_iwText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "black"
                                            }

                                            Text {
                                                id: winding_iout_iuText
                                                text: "<b>Winding I1<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: winding_iout_ivText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "brown"
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

                                                if(graph_selected3 === 1){
                                                    var curve3 = basicGraph1.createCurve("graphCurve")
                                                    curve3.color = "brown"
                                                    curve3.appendList(dataArray_winding_iout_iu_calc_graph)
                                                }

                                                if(graph_selected4 === 1){
                                                    var curve4 = basicGraph1.createCurve("graphCurve")
                                                    curve4.color = "black"
                                                    curve4.appendList(dataArray_winding_iout_iv_calc_graph)
                                                }

                                                if(graph_selected5 === 1){
                                                    var curve5 = basicGraph1.createCurve("graphCurve")
                                                    curve5.color = "grey"
                                                    curve5.appendList(dataArray_winding_iout_iw_calc_graph)
                                                }

                                                if(graph_selected6 === 1){
                                                    var curve6 = basicGraph1.createCurve("graphCurve")
                                                    curve6.color = "brown"
                                                    curve6.appendList(dataArray_temp_U_calc_graph)
                                                }

                                                if(graph_selected7 === 1){
                                                    var curve7 = basicGraph1.createCurve("graphCurve")
                                                    curve7.color = "black"
                                                    curve7.appendList(dataArray_temp_V_calc_graph)
                                                }

                                                if(graph_selected8 === 1){
                                                    var curve8 = basicGraph1.createCurve("graphCurve")
                                                    curve8.color = "grey"
                                                    curve8.appendList(dataArray_temp_W_calc_graph)
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
                                border.color: "lightgray"
                                Grid {
                                    id: grid42
                                    anchors.fill: parent
                                    columns: 3
                                    spacing: 1

                                    Rectangle {
                                        id: rect431
                                        color: "transparent"; width: parent.width*0.5; height: parent.height
                                        Text {
                                            id: name319
                                            text: "Error status"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: parent.height*0.01
                                            font.pixelSize: parent.height*0.1
                                            color: "black"
                                        }

                                        Widget09.SGLabelledInfoBox {
                                            id: labelledInfoBox1exr
                                            infoBoxWidth: parent.width*0.7
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: parent.height*0.2
                                            textPixelSize: (parent.width + parent.height)/50
                                            infoBoxHeight:40
                                            label: ""
                                            info: error_code
                                            labelLeft: true
                                            infoBoxColor: "lightgray"
                                            infoBoxBorderColor: "grey"
                                            infoBoxBorderWidth: 3
                                            textColor: "red"
                                        }

                                        Button {
                                            id:resetErrorButton
                                            anchors {
                                                top : parent.top
                                                topMargin : parent.height*0.2
                                                right: labelledInfoBox1exr.left
                                                rightMargin: 0
                                            }
                                            font.pixelSize: (parent.width + parent.height)/60
                                            text: "Reset"
                                            visible: true
                                            width: parent.width/8
                                            height: 40
                                            onClicked: {
                                                platformInterface.set_system_mode.update(4)
                                                basicControl.error_code = ""
                                            }
                                        }

                                    }
                                    Rectangle {
                                        id: rect432
                                        color: "#00000000"; width: parent.width*0.25; height: parent.height
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
                                        width: parent.width*0.25
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
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
