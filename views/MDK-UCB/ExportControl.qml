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
        dataArray_foc_iout_id_calc_graph = []
        dataArray_foc_iout_iq_calc_graph = []
        dataArray_winding_iout_iu_calc_graph = []
        dataArray_winding_iout_iv_calc_graph = []
        dataArray_winding_iout_iw_calc_graph = []
        dataArray_dc_link_vin_calc_graph = []
        dataArray_actual_speed_calc_graph = []
        if(basicGraph.count > 0) {
            basicGraph.removeCurve(0)
        }
        if(basicGraph1.count > 0) {
            basicGraph1.removeCurve(0)
        }

        Help.registerTarget(basicGraph,"Speed/DC link graph:\n\t-Actual Speed.\n\t-DC Link Voltage.", 0, "exportControlHelp")
        Help.registerTarget(basicGraph1,"Current graph:\n\t-FOC Iout Id.\n\t-FOC Iout Iq.\n\t-Winding Iout Iu.\n\t-Winding Iout Iv.\n\t-Winding Iout Iw.", 1, "exportControlHelp")
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
    property var ratioCalc: root.width / 1200
    property var initialAspectRatio: 1200/820
    property alias virtualtextarea: virtualtextarea
    property alias logSwitch: logSwitch
    property var x_Axis_Timer_:0
    property var x_Axis_Timer_1:0
    property int clear:0
    property var pointsCount: settingsControl.pointsCount

    // property that reads the initial notification
    property var temp_calc: (platformInterface.status_temperature_sensor.temperature).toFixed(3)
    property var pole_pairs: settingsControl.pole_pairs
    property var max_motor_speed: settingsControl.max_motor_speed
    property var current_pi_p_gain: (settingsControl.current_pi_p_gain).toFixed(0)
    property var current_pi_i_gain: (settingsControl.current_pi_i_gain).toFixed(0)
    property var speed_pi_p_gain: (settingsControl.speed_pi_p_gain/1000).toFixed(3)
    property var speed_pi_i_gain: (settingsControl.speed_pi_i_gain/1000).toFixed(3)
    property var resistance: (settingsControl.resistance/100).toFixed(3)
    property var inductance: (settingsControl.inductance/1000).toFixed(3)
    property var target_speed: platformInterface.status_vi.t
    property var max_motor_vout: settingsControl.max_motor_vout
    property var actual_speed: platformInterface.status_vi.a
    property var amperes: settingsControl.amperes

    property string error_code: basicControl.error_code

    property var foc_iout_id_calc: (platformInterface.status_vi.d/1000).toFixed(3)
    property var dataArray_foc_iout_id_calc_graph: []
    property var foc_iout_id_calc_validator:0
    onFoc_iout_id_calcChanged:{
        foc_iout_id_calc_validator++
        if(graph_selected3 === 1){
            if(foc_iout_id_calc_validator>0){
                dataArray_foc_iout_id_calc_graph.push({"x":x_Axis_Timer_1,"y":foc_iout_id_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var foc_iout_iq_calc: (platformInterface.status_vi.q/1000).toFixed(3)
    property var dataArray_foc_iout_iq_calc_graph: []
    property var foc_iout_iq_calc_validator:0
    onFoc_iout_iq_calcChanged:{
        foc_iout_iq_calc_validator++
        if(graph_selected4 === 1){
            if(foc_iout_iq_calc_validator>0){
                dataArray_foc_iout_iq_calc_graph.push({"x":x_Axis_Timer_1,"y":foc_iout_id_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var winding_iout_iu_calc: (platformInterface.status_vi.u/1000).toFixed(3)
    property var dataArray_winding_iout_iu_calc_graph: []
    property var winding_iout_iu_calc_validator:0
    onWinding_iout_iu_calcChanged:{
        winding_iout_iu_calc_validator++
        if(graph_selected5 === 1){
            if(winding_iout_iu_calc_validator>0){
                dataArray_winding_iout_iu_calc_graph.push({"x":x_Axis_Timer_1,"y":winding_iout_iu_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var winding_iout_iv_calc: (platformInterface.status_vi.v/1000).toFixed(3)
    property var dataArray_winding_iout_iv_calc_graph: []
    property var winding_iout_iv_calc_validator:0
    onWinding_iout_iv_calcChanged:{
        winding_iout_iv_calc_validator++
        if(graph_selected6 === 1){
            if(winding_iout_iv_calc_validator>0){
                dataArray_winding_iout_iv_calc_graph.push({"x":x_Axis_Timer_1,"y":winding_iout_iv_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var winding_iout_iw_calc: (platformInterface.status_vi.w/1000).toFixed(3)
    property var dataArray_winding_iout_iw_calc_graph: []
    property var winding_iout_iw_calc_validator:0
    onWinding_iout_iw_calcChanged:{
        winding_iout_iw_calc_validator++
        if(graph_selected7 === 1){
            if(winding_iout_iw_calc_validator>0){
                dataArray_winding_iout_iw_calc_graph.push({"x":x_Axis_Timer_1,"y":winding_iout_iw_calc})
                x_Axis_Timer_1=x_Axis_Timer_1+(+virtualtextarea.realtimelog)
                basicGraph1.xMax = x_Axis_Timer_1
            }
        }
    }

    property var dc_link_vin_calc: (platformInterface.status_vi.l/1000).toFixed(3)
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

    function clearGraphsData() {
        if (clear==1){
            dataArray_foc_iout_id_calc_graph = []
            dataArray_foc_iout_iq_calc_graph = []
            dataArray_winding_iout_iu_calc_graph = []
            dataArray_winding_iout_iv_calc_graph = []
            dataArray_winding_iout_iw_calc_graph = []
            dataArray_dc_link_vin_calc_graph = []
            dataArray_actual_speed_calc_graph = []

            if(basicGraph.count > 0) {
                basicGraph.removeCurve(0)
            }
            if(basicGraph1.count > 0) {
                basicGraph1.removeCurve(0)
            }
            foc_iout_id_calc_validator=0
            foc_iout_iq_calc_validator=0
            winding_iout_iu_calc_validator=0
            winding_iout_iv_calc_validator=0
            winding_iout_iw_calc_validator=0
            dc_link_vin_calc_validator=0
            actual_speed_calc_validator=0

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

                            text:  {
                                if(one_time_top_row_excel===0){
                                    "Time\tDC_Link(V)\t    Id(A)\t    Iq(A)\t    Iu(A)\t    Iv(A)\t    Iw(A)\tTemp.(C)\tPole Pairs\tMax vout\tMax speed\tC.prop gain\tC.int gain\tS.prop gain\tS.int gain\tRes(Ohms)\tInd(H)\tTarget(rpm)\tActual(rpm)"+"\n"
                                    one_time_top_row_excel=1
                                    }
                                else(","+ (new Date().toLocaleString(Qt.locale(),"    h:mm:ss:zzz")) +"\t"+ dc_link_vin_calc +"\t"+ foc_iout_id_calc +"\t"+ foc_iout_iq_calc +"\t"+ winding_iout_iu_calc +"\t"+ winding_iout_iv_calc +"\t"+ winding_iout_iw_calc +"\t"+ temp_calc +"\t"+ pole_pairs +"\t"+ max_motor_vout +"\t"+ max_motor_speed +"\t"+ current_pi_p_gain +"\t"+ current_pi_i_gain +"\t"+ speed_pi_p_gain +"\t"+ speed_pi_i_gain +"\t"+ resistance +"\t"+ inductance +"\t"+ target_speed +"\t"+ actual_speed +"\n")
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
                                            text: ""+ (platformInterface.status_vi.l/1000).toFixed(3) +" V"
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
                                                text: qsTr("FOC Id")
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
                                                text: qsTr("FOC Iq")
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
                                                text: qsTr("Winding Iu")
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
                                                text: qsTr("Winding Iv")
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
                                                text: qsTr("Winding Iw")
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
                                            yTitle: "Amperes"

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
                                                id: idText
                                                anchors {
                                                    top: resetChartButton1.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (platformInterface.status_vi.d/1000).toFixed(3) +" A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "red"
                                            }

                                            Text {
                                                id: iqText
                                                anchors {
                                                    top: idText.bottom
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (platformInterface.status_vi.q/1000).toFixed(3) +" A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "green"
                                            }

                                            Text {
                                                id: iuText
                                                anchors {
                                                    top: iqText.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (platformInterface.status_vi.u/1000).toFixed(3) +" A"
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
                                                text: ""+ (platformInterface.status_vi.v/1000).toFixed(3) +" A"
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
                                                text: ""+ (platformInterface.status_vi.w/1000).toFixed(3) +" A"
                                                font.pixelSize: (parent.width + parent.height)/ 150
                                                color: "grey"
                                            }

                                            Text {
                                                id: hzText
                                                anchors {
                                                    top: iwText.bottom
                                                    topMargin:(parent.width + parent.height)/ 150
                                                    right: resetChartButton1.right
                                                    rightMargin: (parent.width + parent.height)/ 150
                                                }
                                                text: ""+ (((platformInterface.status_vi.a)/60)*pole_pairs).toFixed(0) +" Hz"
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
                                                id: winding_iout_iwText
                                                text: "<b>Winding Iout Iw<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: parent.right
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "grey"
                                            }

                                            Text {
                                                id: winding_iout_ivText
                                                text: "<b>Winding Iout Iv<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: winding_iout_iwText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "black"
                                            }

                                            Text {
                                                id: winding_iout_iuText
                                                text: "<b>Winding Iout Iu<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: winding_iout_ivText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "brown"
                                            }

                                            Text {
                                                id: foc_iout_iqText
                                                text: "<b>FOC Iout Iq<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: winding_iout_iuText.left
                                                anchors.rightMargin: parent.width*0.01
                                                font.pixelSize: parent.height*0.03
                                                color: "green"
                                            }

                                            Text {
                                                id: foc_iout_idText
                                                text: "<b>FOC Iout Id<b>"
                                                anchors.top: basicGraph1.bottom
                                                anchors.topMargin: -parent.height*0.03
                                                anchors.right: foc_iout_iqText.left
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

                                                if(graph_selected3 === 1){
                                                    var curve3 = basicGraph1.createCurve("graphCurve")
                                                    curve3.color = "red"
                                                    curve3.appendList(dataArray_foc_iout_id_calc_graph)
                                                }

                                                if(graph_selected4 === 1){
                                                    var curve4 = basicGraph1.createCurve("graphCurve")
                                                    curve4.color = "green"
                                                    curve4.appendList(dataArray_foc_iout_iq_calc_graph)
                                                }

                                                if(graph_selected5 === 1){
                                                    var curve5 = basicGraph1.createCurve("graphCurve")
                                                    curve5.color = "brown"
                                                    curve5.appendList(dataArray_winding_iout_iu_calc_graph)
                                                }

                                                if(graph_selected6 === 1){
                                                    var curve6 = basicGraph1.createCurve("graphCurve")
                                                    curve6.color = "black"
                                                    curve6.appendList(dataArray_winding_iout_iv_calc_graph)
                                                }

                                                if(graph_selected7 === 1){
                                                    var curve7 = basicGraph1.createCurve("graphCurve")
                                                    curve7.color = "grey"
                                                    curve7.appendList(dataArray_winding_iout_iw_calc_graph)
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
