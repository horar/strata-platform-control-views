import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/sgwidgets"
import "qrc:/image"
import "qrc:/js/help_layout_manager.js" as Help

import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0
import tech.strata.sgwidgets 0.9 as Widget09

Item {
    id: root
    Layout.fillHeight: true
    Layout.fillWidth: true
    anchors.left: parent.left

    property int labelFontSize: 36

    property var ratio:0
    property var acceleration:0
    property var target:0
    property var limit:12000
    property var offset:0

    property var time:20
    property var pointsCount:50
    property var amperes: multiplePlatform.ioutScale
    property var ioutScaleCalc:multiplePlatform.ioutScale

    property var speedLine: []

    property var xvalue
    property var yvalue
    property var x2value
    property var y2value

    property var pole_pairs
    property var max_motor_vout
    property var max_motor_speed:10000

    property var current_pi_p_gain
    property var current_pi_i_gain

    property var speed_pi_p_gain
    property var speed_pi_i_gain

    property var resistance
    property var inductance

    Component.onCompleted: {        
        laAccelerationSliderLabel.opacity = 0
        laAccelerationSlider.enabled  = false
        laSpeedSliderLabel.opacity = 0
        laSpeedSlider.enabled  = false

        Help.registerTarget(laMotorContainerRow1,"For all control technique: Pole pairs, Max. Motor voltage & Max Motor speed.", 0, "settingsHelp")
        Help.registerTarget(laSettingsContainerRow2,"Shows the axis in time, plots and amperes units.", 1, "settingsHelp")
        Help.registerTarget(leadAngleAdjustmentGraph,"Target Speed & Acceleration can be simulated with this signal graph generator and can be sent to the motor.", 2, "settingsHelp")
        Help.registerTarget(systemModeMainsLabel,"Drop-down menu to select V/F control (default) or FOC control.", 3, "settingsHelp")
        Help.registerTarget(current_pi_p_gainLabel,"For FOC control: Speed & current PI control parameters + R & L for the motor properties.", 4, "settingsHelp")
    }


    RowLayout {
        anchors.fill: parent
        spacing: 10

        FontLoader {
            id: icons
            source: "sgwidgets/fonts/sgicons.ttf"
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            ColumnLayout{
                anchors.fill: parent

                Rectangle {
                    id: laMotorContainerRow1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "white"

                    Text {
                        id: motorText
                        anchors {
                            top: parent.top
                            topMargin: 20
                            horizontalCenter: parent.horizontalCenter
                        }
                        text:  "<b> Motor Driving Parameters <b>"
                        font.pixelSize: (parent.width + parent.height)/ 35
                        color: "black"
                    }

                    SGAlignedLabel{
                        id: pole_pairsLabel
                        target: pole_pairsSlider
                        text:"Poles pairs:"
                        font.pixelSize: (parent.width + parent.height)/ 60
                        anchors {
                            top: laMotorContainerRow1.top
                            topMargin: parent.height/4
                            horizontalCenter: parent.horizontalCenter
                            }
                        SGSlider {
                            id: pole_pairsSlider
                            width: laMotorContainerRow1.width/1.2
                            from: 0
                            to: 100
                            value: 4
                            stepSize: 1
                            onValueChanged: pole_pairs = value
                            onUserSet: platformInterface.pole_pairs = pole_pairsSlider.value
                            live: false
                        }
                    }

                    SGAlignedLabel{
                        id: max_motor_voutLabel
                        target: max_motor_voutSlider
                        text:"Max. Motor Voltage:"
                        font.pixelSize: (parent.width + parent.height)/ 60
                        anchors {
                            top: laMotorContainerRow1.top
                            topMargin: (parent.height/4)*2
                            horizontalCenter: parent.horizontalCenter
                            }
                        SGSlider {
                            id: max_motor_voutSlider
                            width: laMotorContainerRow1.width/1.2
                            from: 0
                            to: 500
                            value: 200
                            stepSize: 1
                            onValueChanged: max_motor_vout = value
                            onUserSet: platformInterface.max_motor_vout = max_motor_voutSlider.value
                            live: false
                        }
                        Text{
                            id:max_motor_voutSliderUnit
                            text:"Volts"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "black"
                            anchors.left: max_motor_voutSlider.right
                            }
                    }

                    SGAlignedLabel{
                        id: max_motor_speedLabel
                        target: max_motor_speedSlider
                        text:"Max. Motor Speed (RPM):"
                        font.pixelSize: (parent.width + parent.height)/ 60
                        anchors {
                            top: laMotorContainerRow1.top
                            topMargin: (parent.height/4)*3
                            horizontalCenter: parent.horizontalCenter
                            }
                        SGSlider {
                            id: max_motor_speedSlider
                            width: laMotorContainerRow1.width/1.2
                            from: 0
                            to: 10000
                            value: 9001
                            stepSize: 10
                            onValueChanged: max_motor_speed = value
                            onUserSet: platformInterface.max_motor_speed = max_motor_speedSlider.value
                            live: false
                        }
                        Text{
                            id:max_motor_speedSliderUnit
                            text:"RPM"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "black"
                            anchors.left: max_motor_speedSlider.right
                            }
                    }
                }

                Rectangle {
                    id: laSettingsContainerRow2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "white"

                    Text {
                        id: timeText
                        anchors {
                            top: parent.top
                            topMargin: 20
                            horizontalCenter: parent.horizontalCenter
                        }
                        text:  "<b> Graph's Settings <b>"
                        font.pixelSize: (parent.width + parent.height)/ 35
                        color: "black"
                    }

                    SGAlignedLabel{
                        id: timeLabel
                        target: timeSlider
                        text:"Time / div:"
                        font.pixelSize: (parent.width + parent.height)/ 60
                        anchors {
                            top: laSettingsContainerRow2.top
                            topMargin: parent.height/4
                            horizontalCenter: parent.horizontalCenter
                            }
                        SGSlider {
                            id: timeSlider
                            width: laSettingsContainerRow2.width/1.2
                            from: 5
                            value: 10
                            to: 20
                            stepSize: 5
                            onValueChanged: time = value
                            onUserSet: time = value
                        }
                        Text{
                            id:timeSliderUnit
                            text:"s"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "black"
                            anchors.left: timeSlider.right
                            }
                    }

                    SGAlignedLabel{
                        id: pointsCountLabel
                        target: pointsCountSlider
                        text:"Plots a point every (1/pointCount):"
                        font.pixelSize: (parent.width + parent.height)/ 60
                        anchors {
                            top: laSettingsContainerRow2.top
                            topMargin: (parent.height/4)*2
                            horizontalCenter: parent.horizontalCenter
                            }
                        SGSlider {
                            id: pointsCountSlider
                            width: laSettingsContainerRow2.width/1.2
                            from: 1
                            value: 30
                            to: 100
                            stepSize: 1
                            onValueChanged: pointsCount = value
                            onUserSet: pointsCount = value
                        }
                        Text{
                            id:pointsCountSliderUnit
                            text:"Points"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "black"
                            anchors.left: pointsCountSlider.right
                            }
                    }

                    SGAlignedLabel{
                        id: amperesLabel
                        target: amperesSlider
                        text:"Amperes:"
                        font.pixelSize: (parent.width + parent.height)/ 60
                        anchors {
                            top: laSettingsContainerRow2.top
                            topMargin: (parent.height/4)*3
                            horizontalCenter: parent.horizontalCenter
                            }
                        SGSlider {
                            id: amperesSlider
                            width: laSettingsContainerRow2.width/1.2
                            from: 0
                            value: multiplePlatform.ioutScale
                            to: ioutScaleCalc
                            stepSize: 1
                            onValueChanged: amperes = value
                            onUserSet: amperes = value
                        }
                        Text{
                            id:amperesSliderUnit
                            text:"Amps"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "black"
                            anchors.left: amperesSlider.right
                            }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: parent.height
            Layout.preferredWidth: parent.width/1.45
            ColumnLayout{
                anchors.fill: parent
                Rectangle {
                    Layout.preferredHeight: parent.height
                    Layout.fillWidth: parent.width/1.1
                    Layout.alignment: Qt.AlignTop
                    color: "white"

                    SGGraph {
                        id: leadAngleAdjustmentGraph
                        width: parent.width/1.05
                        height: parent.height/2.7
                        anchors {
                            top: parent.top
                            topMargin: (parent.width + parent.height)/ 25
                            horizontalCenter: parent.horizontalCenter
                        }
                        title: "Target Speed"
                        xMin: 0
                        xMax: time
                        yMin: 0
                        yMax: max_motor_speed
                        xTitle: "<b> Time / div <b>"
                        yTitle: "RPM"
                        xGrid: true
                        yGrid: true
                        gridColor: "grey"
                    }

                    SGAlignedLabel{
                        id: laSpeedSliderLabel
                        target: laSpeedSlider
                        text:"Target Speed:"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: leadAngleAdjustmentGraph.bottom
                            topMargin: (parent.width + parent.height)/ 120
                            left: leadAngleAdjustmentGraph.left
                            }
                        SGSlider {
                            id: laSpeedSlider
                            width: leadAngleAdjustmentGraph.width/2.3
                            from: 0
                            to: max_motor_speed
                            stepSize: 1
                            enabled:true
                            value: target
                            live: false
                            onValueChanged: {
                                for (let y = 0; y < leadAngleAdjustmentGraph.count; y++) {
                                    if (leadAngleAdjustmentGraph.curve(y).name === "laCurve") {
                                        leadAngleAdjustmentGraph.removeCurve(y)
                                    break
                                    }
                                }
                                let curve = leadAngleAdjustmentGraph.createCurve("laCurve")
                                curve.color = "blue"
                                speedLine = []
                                yvalue = offset

                                for (let i = 0; i <= time*100; i++) {
                                    if(limit===time && offset===0){
                                        if(yvalue < target){
                                            xvalue=i/100
                                            yvalue=(i/100-0) * ratio
                                        }
                                        else{
                                            xvalue = i/100
                                            yvalue = target
                                        }
                                    }
                                    else if(limit!==time && offset===0){
                                        if(i/100 <= limit){
                                            if(yvalue < target){
                                                xvalue=i/100
                                                yvalue=(i/100-0) * ratio
                                            }
                                            else{
                                                xvalue = i/100
                                                yvalue = target
                                            }
                                        }
                                        else{
                                            xvalue = i/100
                                            yvalue = yvalue
                                        }
                                    }
                                    else if(limit===time && offset!==0){
                                        if(yvalue < target){
                                            xvalue=i/100
                                            yvalue=((i/100-0) * ratio) + offset
                                        }
                                        else{
                                            xvalue = i/100
                                            yvalue = target
                                        }
                                    }
                                    else{}
                                    speedLine.push({"x": xvalue, "y": yvalue})
                                }
                                if(leadAngleAdjustmentGraph.title=== "Target Speed"){
                                    curve.appendList(speedLine)
                                }
                                else {}
                            }
                        }

                        Text{
                            id:laSpeedSliderUnit
                            text:"RPM"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "lightgrey"
                            anchors.left: laSpeedSlider.right
                        }
                    }

                    SGAlignedLabel{
                        id: laAccelerationSliderLabel
                        target: laAccelerationSlider
                        text:"Acceleration:"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: leadAngleAdjustmentGraph.bottom
                            topMargin: (parent.width + parent.height)/ 120
                            left: laSpeedSliderLabel.right
                            leftMargin: leadAngleAdjustmentGraph.width/12
                            }

                        SGSlider {
                            id: laAccelerationSlider
                            width: leadAngleAdjustmentGraph.width/2.3
                            from: 0
                            to: max_motor_speed
                            stepSize: 1
                            enabled:true
                            value: ratio
                            live: false
                            onValueChanged: {
                                for (let y = 0; y < leadAngleAdjustmentGraph.count; y++) {
                                    if (leadAngleAdjustmentGraph.curve(y).name === "laCurve") {
                                        leadAngleAdjustmentGraph.removeCurve(y)
                                    break
                                    }
                                }
                                let curve = leadAngleAdjustmentGraph.createCurve("laCurve")
                                curve.color = "blue"
                                speedLine = []
                                yvalue = offset

                                for (let i = 0; i <= time*100; i++) {
                                    if(limit===time && offset===0){
                                        if(yvalue < target){
                                            xvalue=i/100
                                            yvalue=(i/100-0) * ratio
                                        }
                                        else{
                                            xvalue = i/100
                                            yvalue = target
                                        }
                                    }
                                    else if(limit!==time && offset===0){
                                        if(i/100 <= limit){
                                            if(yvalue < target){
                                                xvalue=i/100
                                                yvalue=(i/100-0) * ratio
                                            }
                                            else{
                                                xvalue = i/100
                                                yvalue = target
                                            }
                                        }
                                        else{
                                            xvalue = i/100
                                            yvalue = yvalue
                                        }
                                    }
                                    else if(limit===time && offset!==0){
                                        if(yvalue < target){
                                            xvalue=i/100
                                            yvalue=((i/100-0) * ratio) + offset
                                        }
                                        else{
                                            xvalue = i/100
                                            yvalue = target
                                        }
                                    }
                                    else{}

                                    speedLine.push({"x": xvalue, "y": yvalue})
                                }
                                if(leadAngleAdjustmentGraph.title=== "Target Speed"){
                                    curve.appendList(speedLine)
                                }
                                else {}
                            }
                        }
                        Text{
                            id:laAccelerationSliderUnit
                            text:"RPM/s"
                            font.pixelSize: (parent.width + parent.height)/ 40
                            color: "lightgrey"
                            anchors.left: laAccelerationSlider.right
                        }

                    }

                    Text {
                        id: controlText
                        anchors {
                            top: leadAngleAdjustmentGraph.bottom
                            topMargin: (parent.width + parent.height)/ 60
                            horizontalCenter: leadAngleAdjustmentGraph.horizontalCenter
                        }
                        text:  "<b> Closed Loop Parameters <b>"
                        font.pixelSize: (parent.width + parent.height)/ 70
                        color: "black"
                    }

                    Rectangle{
                        id: systemModeMainsContainer
                        color: "transparent"
                        anchors {
                            top : controlText.top
                            topMargin: (parent.width + parent.height)/ 40
                            left: controlText.left
                        }
                        width : parent.width/20
                        height:  parent.height/30

                    SGAlignedLabel {
                        id: systemModeMainsLabel
                        target: systemModeMainsCombo
                        text: "Select V/F control (default) or FOC control"
                        horizontalAlignment: Text.AlignHCenter
                        alignment: SGAlignedLabel.SideLeftCenter
                        anchors.fill: parent
                        font.bold : false

                        SGComboBox {
                            id: systemModeMainsCombo
                            currentIndex: platformInterface.system_mode_state
                            model: [ "V/F","FOC"]
                            borderColor: "green"
                            textColor: "black"          // Default: "black"
                            indicatorColor: "green"
                            onActivated: {
                                platformInterface.set_system_mode.update(currentIndex)
                                platformInterface.system_mode_state = currentIndex
                                }
                            }
                        }
                    }

                    Text {
                        id: current_piText
                        anchors {
                            top: laSpeedSliderLabel.top
                            topMargin: parent.height/5
                            horizontalCenter: laSpeedSliderLabel.horizontalCenter
                            horizontalCenterOffset: -(parent.width + parent.height)/ 40
                        }
                        text:  "<b> Current PI (Volts/Ampere) <b>"
                        font.pixelSize: (parent.width + parent.height)/100
                        color: "grey"
                    }

                    SGAlignedLabel{
                        id: current_pi_p_gainLabel
                        target: current_pi_p_gainSlider
                        text:"Proportional Gain, P:"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: laSpeedSliderLabel.top
                            topMargin: parent.height/3.5
                            horizontalCenter: laSpeedSliderLabel.horizontalCenter
                            horizontalCenterOffset: -(parent.width + parent.height)/ 40
                            }
                        SGSlider {
                            id: current_pi_p_gainSlider
                            width: laMotorContainerRow1.width/2
                            from: 0
                            to: 1000
                            value: 30
                            stepSize: 1
                            onValueChanged: current_pi_p_gain = value
                            onUserSet: platformInterface.current_pi_p_gain = current_pi_p_gainSlider.value
                            live: false
                        }
                    }

                    SGAlignedLabel{
                        id: current_pi_i_gainLabel
                        target: current_pi_i_gainSlider
                        text:"Integral Gain, I:"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: current_pi_p_gainLabel.top
                            topMargin: parent.height/10
                            horizontalCenter: laSpeedSliderLabel.horizontalCenter
                            horizontalCenterOffset: -(parent.width + parent.height)/ 40
                            }
                        SGSlider {
                            id: current_pi_i_gainSlider
                            width: laMotorContainerRow1.width/2
                            from: 0
                            to: 10000
                            value: 2500
                            stepSize: 1
                            onValueChanged: current_pi_i_gain = value
                            onUserSet: platformInterface.current_pi_i_gain = current_pi_i_gainSlider.value
                            live: false
                        }
                    }

                    Text {
                        id: speed_piText
                        anchors {
                            top: laSpeedSliderLabel.top
                            topMargin: parent.height/5
                            horizontalCenter: controlText.horizontalCenter
                        }
                        text:  "<b> Speed PI (Ampere/Speed) <b>"
                        font.pixelSize: (parent.width + parent.height)/100
                        color: "grey"
                    }


                    SGAlignedLabel{
                        id: speed_pi_p_gainLabel
                        target: speed_pi_p_gainSlider
                        text:"Proportional Gain, P:"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: laSpeedSliderLabel.top
                            topMargin: parent.height/3.5
                            horizontalCenter: controlText.horizontalCenter
                            }
                        SGSlider {
                            id: speed_pi_p_gainSlider
                            width: laMotorContainerRow1.width/2
                            from: 0
                            to: 1
                            value: 0.08
                            stepSize: 0.001
                            onValueChanged: speed_pi_p_gain = value*1000
                            onUserSet: platformInterface.speed_pi_p_gain = speed_pi_p_gainSlider.value*1000
                            live: false
                        }
                    }

                    SGAlignedLabel{
                        id: speed_pi_i_gainLabel
                        target: speed_pi_i_gainSlider
                        text:"Integral Gain, I:"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: speed_pi_p_gainLabel.top
                            topMargin: parent.height/10
                            horizontalCenter: controlText.horizontalCenter
                            }
                        SGSlider {
                            id: speed_pi_i_gainSlider
                            width: laMotorContainerRow1.width/2
                            from: 0
                            to: 1
                            value: 0.05
                            stepSize: 0.001
                            onValueChanged: speed_pi_i_gain = value*1000
                            onUserSet: platformInterface.speed_pi_i_gain = speed_pi_i_gainSlider.value*1000
                            live: false
                        }
                    }

                    SGAlignedLabel{
                        id: resistanceLabel
                        target: resistanceSlider
                        text:"Resistance (Ohms):"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: laAccelerationSliderLabel.top
                            topMargin: parent.height/3.5
                            horizontalCenter: laAccelerationSliderLabel.horizontalCenter
                            horizontalCenterOffset: (parent.width + parent.height)/ 20
                            }
                        SGSlider {
                            id: resistanceSlider
                            width: laMotorContainerRow1.width/2
                            from: 0
                            to: 10
                            value: 2.5
                            stepSize: 0.01
                            onValueChanged: resistance = value*100
                            onUserSet: platformInterface.resistance = resistanceSlider.value*100
                            live: false
                        }
                        Text{
                            id: resistanceSliderUnit
                            text:"Ohm"
                            font.pixelSize: (parent.width + parent.height)/ 25
                            color: "black"
                            anchors.left: resistanceSlider.right
                            }
                    }

                    SGAlignedLabel{
                        id: inductanceLabel
                        target: inductanceSlider
                        text:"Inductance (H):"
                        font.pixelSize: (parent.width + parent.height)/ 120
                        anchors {
                            top: resistanceLabel.top
                            topMargin: parent.height/10
                            horizontalCenter: laAccelerationSliderLabel.horizontalCenter
                            horizontalCenterOffset: (parent.width + parent.height)/ 20
                            }
                        SGSlider {
                            id: inductanceSlider
                            width: laMotorContainerRow1.width/2
                            from: 0
                            to: 1
                            value: 0.016
                            stepSize: 0.001
                            onValueChanged: inductance = value*1000
                            onUserSet: platformInterface.inductance = inductanceSlider.value*1000
                            live: false
                        }
                        Text{
                            id: inductanceSliderUnit
                            text:"Henry"
                            font.pixelSize: (parent.width + parent.height)/ 25
                            color: "black"
                            anchors.left: inductanceSlider.right
                            }
                    }
               }
            }
        }
    }

    function play ()
    {
        platformInterface.set_system_mode.update(3)
        pole_pairsSlider.enabled = false
        max_motor_voutSlider.enabled = false
        max_motor_speedSlider.enabled = false
        systemModeMainsCombo.enabled = false
    }

    function stop ()
    {
        platformInterface.set_system_mode.update(2)
        pole_pairsSlider.enabled = true
        max_motor_voutSlider.enabled = true
        max_motor_speedSlider.enabled = true
        systemModeMainsCombo.enabled = true
    }

}
