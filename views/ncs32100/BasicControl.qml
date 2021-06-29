import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Rectangle {
    id: root
    property real ratioCalc: root.width / 1200
    property real initialAspectRatio: 1164/816
    property var test: 0
    color: "light gray"
    property var initialStart: 0
    property var velocityReadingCount: 0
    anchors.centerIn: parent
    height: parent.height
    width: parent.width / parent.height > initialAspectRatio ? parent.height * initialAspectRatio : parent.width

    function returnAngle (num)  {
        return (num/1048576)*360
    }

    function returnVelocity (num)  {
        var speedIs = (num/536870912)*60000000
        return speedIs.toFixed(2)
    }

    Connections  {
        target: platformInterface.notifications.get_errors
        onNotificationFinished: {
            if(platformInterface.notifications.get_errors.overspeed === 1)
                overSpeed.status =  SGStatusLight.Red
            else overSpeed.status = SGStatusLight.Green

            if(platformInterface.notifications.get_errors.sensor_error === 1)
                sensorError.status = SGStatusLight.Red
            else sensorError.status = SGStatusLight.Green

            if(platformInterface.notifications.get_errors.overflow === 1)
                turnCountOverflow.status = SGStatusLight.Red
            else turnCountOverflow.status = SGStatusLight.Green

            if(platformInterface.notifications.get_errors.low_bat === 1)
                lowBattery.status = SGStatusLight.Red
            else lowBattery.status = SGStatusLight.Green

            if(platformInterface.notifications.get_errors.no_power === 1)
                nopower.status =  SGStatusLight.Red
            else nopower.status = SGStatusLight.Green

            if(platformInterface.notifications.get_errors.over_temp === 1)
                overTempError.status =  SGStatusLight.Red
            else overTempError.status = SGStatusLight.Green

            if(platformInterface.notifications.get_errors.batt_alarm === 1)
                battAlarmThresError.status =  SGStatusLight.Red
            else battAlarmThresError.status = SGStatusLight.Green
        }
    }

    MouseArea {
        id: containMouseArea
        anchors.fill:parent
        onClicked: {
            forceActiveFocus()
        }
    }

    Component.onCompleted:{
        addCommand("get_data")
        sendCommand()
        startTimer()
    }

    ListModel {
        id: commandQueue
    }

    function addCommand (command,value = -1) {
        commandQueue.append({
                                "command": command,
                                "value" : value

                            })
    }
    function sendCommand () {
        timer.running = false
        if (commandQueue.count > 0) {
            let command = commandQueue.get(0).command
            if(commandQueue.get(0).value !== -1) {
                platformInterface.commands[command].update(commandQueue.get(0).value)
            }
            else  {
                platformInterface.commands[command].update()
            }
            commandQueue.remove(0)

        } else {
            platformInterface.commands.get_data.update()
        }

        timer.start()
    }

    Timer {
        id: timer
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            console.log("Error: TimedOut")
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.get_data
        onNotificationFinished: {
            timer.running = false
            addCommand("get_data")
            sendCommand()

        }
    }

    Connections {
        target: platformInterface.notifications.get_temperature
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.get_errors
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.get_lowbattv
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.get_maxtemp
        onNotificationFinished: {
            sendCommand()
        }
    }


    Connections {
        target: platformInterface.notifications.get_battv
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.get_firmware_version
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.reset_turns
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.reset_position
        onNotificationFinished: {
            sendCommand()
        }
    }
    Connections {
        target: platformInterface.notifications.reset_errors
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.set_low_batt
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.set_over_temp
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.set_velocity_resolution
        onNotificationFinished: {
            sendCommand()
        }
    }

    function startTimer() {
        getTempCommand.start()
        getErrorCommand.start()
        getLowBattvCommand.start()
        getMaxTempValueCommand.start()
        getFirmwareVersionCommand.start()
        getBattvValueCommand.start()
    }


    Timer {
        id: getTempCommand
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            var command = "get_temperature"
            console.log(command)
            addCommand(command)
        }
    }

    Timer {
        id: getErrorCommand
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            var command = "get_errors"
            addCommand(command)
        }
    }

    Timer {
        id: getLowBattvCommand
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            var command = "get_lowbattv"
            addCommand(command)
        }
    }

    Timer {
        id: getMaxTempValueCommand
        interval: 4000
        running: false
        repeat: false
        onTriggered: {
            var command = "get_maxtemp"
            addCommand(command)
        }
    }

    Timer {
        id: getBattvValueCommand
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            var command = "get_battv_value"
            addCommand(command)
        }
    }

    Timer {
        id: getFirmwareVersionCommand
        interval: 6000
        running: false
        repeat: false
        onTriggered: {
            var command = "get_firmware_version"
            addCommand(command)
            startTimer()
        }
    }

    ColumnLayout {
        anchors.fill: parent

        SGText {
            id: boardTitle
            Layout.alignment: Qt.AlignHCenter
            text: "NCS32100 Evaluation System"
            font.bold: true
            font.pixelSize: ratioCalc * 20
            topPadding: 5
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.bottomMargin: 25
            Layout.leftMargin: 5
            Layout.rightMargin: 5

            RowLayout {
                anchors.fill: parent
                spacing: 5

                Rectangle {
                    id:left
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Text {
                        id: configurationHeading
                        text: "Configuration"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 3
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Rectangle {
                        id: line
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width + 2
                        border.color: "black"
                        radius: 2
                        anchors {
                            top: configurationHeading.bottom
                        }
                    }

                    ColumnLayout {
                        anchors {
                            top: line.bottom
                            topMargin: 5
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        spacing: 7

                        Item {
                            id: lowBatteryContainer
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: lowbatteryAlarmLabel
                                target: lowbatteryAlarmValue
                                text: "Set Low Battery \nThreshold"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                //                                anchors.centerIn: parent
                                SGSubmitInfoBox {
                                    id: lowbatteryAlarmValue
                                    validator: DoubleValidator {    // Default: no input validator - you may assign your own configured DoubleValidator, IntValidator or RegExpValidator
                                        bottom: 1.00
                                        top: 3.50
                                    }                     // String to this to be displayed in box
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.1
                                    infoBoxObject.unitOverrideWidth: 40 * ratioCalc
                                    anchors.left: parent.left
                                    Component.onCompleted: {
                                        infoBoxObject.Layout.preferredWidth = 130 * ratioCalc
                                    }
                                    unit : "V"
                                    placeholderText: "1-3.5"
                                    onEditingFinished: {
                                        var test = parseFloat(lowbatteryAlarmValue.text).toFixed(2)
                                        var stringValue = test.toString()
                                        lowbatteryAlarmValue.text = stringValue
                                        addCommand("set_low_batt",Number(test))
                                    }
                                }
                            }
                        }

                        Item {
                            id: overTempContainer
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: overTempLabel
                                target: overTempValue
                                text: "Over Temperature"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                SGSubmitInfoBox {
                                    id: overTempValue
                                    validator: IntValidator {    // Default: no input validator - you may assign your own configured DoubleValidator, IntValidator or RegExpValidator
                                        bottom: 0
                                        top: 125
                                    }                     // String to this to be displayed in box
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.1                  // Default: 1.0 (affects text and unit)
                                    infoBoxObject.unitOverrideWidth: 40 * ratioCalc
                                    Component.onCompleted: {
                                        infoBoxObject.Layout.preferredWidth = 130 * ratioCalc
                                    }
                                    anchors.left: parent.left
                                    unit: "°C"

                                    placeholderText: "0-125"
                                    onEditingFinished: {
                                        addCommand("set_over_temp",Number(text))
                                    }
                                }
                            }
                        }

                        Item {
                            id: velocityResolutionContaine
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: velocityResolutionLabel
                                target: velocityResolution
                                text: "Velocity Resolution"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft

                                SGSubmitInfoBox {
                                    id: velocityResolution
                                    validator: IntValidator {    // Default: no input validator - you may assign your own configured DoubleValidator, IntValidator or RegExpValidator
                                        bottom: 1
                                        top: 20
                                    }                     // String to this to be displayed in box
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.1                 // Default: 1.0 (affects text and unit)
                                    unit: "bit"                                 // Default: ""
                                    infoBoxObject.unitOverrideWidth: 40 * ratioCalc
                                    anchors.left: parent.left
                                    Component.onCompleted: {
                                        infoBoxObject.Layout.preferredWidth = 130 * ratioCalc
                                    }

                                    placeholderText: "1-20"
                                    onEditingFinished: {
                                        addCommand("set_velocity_resolution",Number(text))
                                    }
                                }

                            }
                        }

                        Item {
                            id: accelerationContainer
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: accelerationResolutionLabel
                                target: accelerationResolution
                                text: "Raw Position"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft

                                SGSubmitInfoBox {
                                    id: accelerationResolution
                                    // String to this to be displayed in box
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.1                // Default: 1.0 (affects text and unit)
                                    anchors.left: parent.left
                                    infoBoxObject.unitOverrideWidth: 40 * ratioCalc
                                    readOnly: true
                                    Component.onCompleted: {
                                        infoBoxObject.Layout.preferredWidth = 130 * ratioCalc
                                    }

                                    text: platformInterface.notifications.get_data.pos.toFixed(0)
                                    unit: "count"
                                }
                            }
                        }


                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height/22

                            Text {
                                id: errorReportHeading
                                text: "Error Report"
                                font.bold: true
                                font.pixelSize: ratioCalc * 20
                                color: "#696969"
                                anchors {
                                    top: parent.top
                                    left: parent.left
                                    leftMargin: 5
                                }
                            }

                            Rectangle {
                                id: line2
                                height: 2
                                Layout.alignment: Qt.AlignCenter
                                width: parent.width + 2
                                border.color: "black"
                                radius: 2
                                anchors {
                                    top: errorReportHeading.bottom
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: overSpeedLable
                                target: overSpeed
                                text: "Over Speed"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: overSpeed
                                    width: 25
                                    status: SGStatusLight.Green
                                }
                            }

                        }
                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: sensorErrorLable
                                target: sensorError
                                text: "Sensor Error"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: sensorError
                                    width: 25
                                    status: SGStatusLight.Green
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            SGAlignedLabel {
                                id: turnCountOverflowLable
                                target: turnCountOverflow
                                text: "Turn Count Overflow"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: turnCountOverflow
                                    width: 25
                                    status: SGStatusLight.Green
                                }
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: lowBatteryLable
                                target: lowBattery
                                text: "Low Battery"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: lowBattery
                                    width: 25
                                    status: SGStatusLight.Green

                                }
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: nopowerLable
                                target: nopower
                                text: "No Power"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: nopower
                                    width: 25
                                    status: SGStatusLight.Green

                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: battAlarmThresErrorLable
                                target: battAlarmThresError
                                text: "Battery Alarm\nThreshold "
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: battAlarmThresError
                                    width: 25
                                    status: SGStatusLight.Green
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: overTempLable
                                target: overTempError
                                text: "Over Temperature"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                anchors.centerIn: parent
                                alignment: SGAlignedLabel.SideTopCenter

                                SGStatusLight {
                                    id: overTempError
                                    width: 25
                                    status: SGStatusLight.Green
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.preferredHeight: parent.height + 10
                    Layout.preferredWidth: parent.width/120

                    Rectangle {
                        id:leftLine
                        color: "transparent"
                        height: parent.height + 5
                        anchors.left: parent.left
                        width: 1
                        border.color: "black"
                        radius: 2
                        z: 3
                    }
                }
                Item {
                    Layout.preferredWidth: parent.width/1.6
                    Layout.fillHeight: true

                    ColumnLayout{
                        anchors.fill:parent

                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height/1.3

                            ColumnLayout {
                                anchors.fill: parent
                                spacing: 5

                                Connections  {
                                    target: platformInterface.notifications.get_data
                                    onNotificationFinished: {
                                        var positionIs = returnAngle(platformInterface.notifications.get_data.pos.toFixed(0))

                                        currentPosition.text = Number(positionIs).toFixed(2)

                                        if(positionIs.toFixed(0) === "360") {
                                            angleDial.previousAngle = 0
                                            angleDial.angle = 0
                                            angleDial.rotation.start()
                                        }
                                        else  {
                                            angleDial.previousAngle = angleDial.angle
                                            angleDial.angle = positionIs.toFixed(0)
                                            angleDial.rotation.start()
                                        }

                                        var speed = Math.abs(returnVelocity(platformInterface.notifications.get_data.vel))
                                        if(root.velocityReadingCount === 9) {
                                            currentVelocity.text  = returnVelocity(platformInterface.notifications.get_data.vel).toString()
                                            root.velocityReadingCount = 0
                                        }
                                        else  {
                                            ++root.velocityReadingCount
                                        }

                                        let currentTime = Date.now()
                                        let curve = timedGraphPoints.curve(0)

                                        curve.shiftPoints((currentTime - graphTimerPoints.lastTime)/1000, 0)
                                        curve.append(0, positionIs)

                                        let curve2 = speedGraphPoints.curve(0)
                                        curve2.shiftPoints((currentTime - graphTimerPoints.lastTime)/1000, 0)
                                        curve2.append(0,speed)

                                        graphTimerPoints.removeOutOfViewPoints()
                                        timedGraphPoints.update()
                                        speedGraphPoints.update()
                                        graphTimerPoints.lastTime = currentTime
                                    }
                                }


                                Item {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    Timer {
                                        id: graphTimerPoints
                                        interval: 30
                                        running: false
                                        repeat: true

                                        property real lastTime
                                        onRunningChanged: {
                                            if (running){
                                                lastTime = Date.now()
                                            }
                                        }

                                        function removeOutOfViewPoints() {
                                            // recursively clean up points that have moved out of view
                                            if (timedGraphPoints.curve(0).at(0).x > timedGraphPoints.xMax ) {
                                                timedGraphPoints.curve(0).remove(0)
                                                removeOutOfViewPoints()
                                            }

                                            if(speedGraphPoints.curve(0).at(0).x > speedGraphPoints.xMax ) {
                                                speedGraphPoints.curve(0).remove(0)
                                                removeOutOfViewPoints()
                                            }
                                        }
                                    }

                                    SGGraph {
                                        id: timedGraphPoints
                                        height: parent.height
                                        width: parent.width
                                        anchors.centerIn: parent
                                        title: "Position/Time"
                                        xMin: 0
                                        xMax: 10
                                        yMin: 0
                                        yMax: 360
                                        xTitle: "Time (seconds)"
                                        yTitle: "Position (degrees)"
                                        xGrid: true
                                        yGrid: true
                                        gridColor: "red"
                                        foregroundColor: "black"
                                        panXEnabled: false
                                        panYEnabled: false
                                        zoomXEnabled: false
                                        zoomYEnabled: false
                                        autoUpdate: false
                                        backgroundColor: "white"
                                        Component.onCompleted:  {
                                            let positionCurve = createCurve("graphCurve")
                                            positionCurve.color = "blue"
                                            positionCurve.autoUpdate = false
                                        }
                                    }
                                }

                                Item {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    SGGraph {
                                        id: speedGraphPoints
                                        height: parent.height
                                        width: parent.width
                                        anchors.centerIn: parent
                                        title: "Speed/Time"
                                        xMin: 0
                                        xMax: 10
                                        yMin: 0
                                        yMax: 2000
                                        xTitle: "Time (seconds)"
                                        yTitle: "Speed (RPM)"
                                        xGrid: true
                                        yGrid: true
                                        gridColor: "red"
                                        foregroundColor: "black"
                                        panXEnabled: false
                                        panYEnabled: false
                                        zoomXEnabled: false
                                        zoomYEnabled: false
                                        autoUpdate: false
                                        backgroundColor: "white"
                                        Component.onCompleted:  {
                                            let speedCurve = createCurve("graphCurve")
                                            speedCurve.color = "green"
                                            speedCurve.autoUpdate = false
                                        }
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            RowLayout {
                                width: parent.width
                                height: parent.height
                                anchors {
                                    left: parent.left
                                    leftMargin: 20
                                    top:parent.top
                                    topMargin: 10
                                    right: parent.right
                                    rightMargin: 20
                                }
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    SGAlignedLabel {
                                        id: currentVelocityLabel
                                        target: currentVelocity
                                        text: "Current \nVelocity"
                                        font.bold: true
                                        fontSizeMultiplier: ratioCalc * 1.1
                                        alignment: SGAlignedLabel.SideBottomCenter
                                        anchors.centerIn: parent

                                        SGInfoBox {
                                            id: currentVelocity
                                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2                  // Default: 1.0 (affects text and unit)
                                            width: 130 * ratioCalc
                                            unit: "RPM"
                                            text: "0"
                                            boxColor: "#dcdcdc"
                                            boxBorderColor: "#a9a9a9"
                                            anchors.left: parent.left
                                        }
                                    }
                                }

                                Item {
                                    Layout.fillHeight: true
                                    Layout.preferredWidth: parent.width/1.5

                                    RotationEncoder {
                                        id: angleDial
                                        width: 210
                                        height: parent.height
                                        anchors.centerIn: parent
                                        z: -1
                                    }

                                    SGAlignedLabel {
                                        id: currentPositionLabel
                                        target: currentPosition
                                        text: "Current \n Position"
                                        font.bold: true
                                        fontSizeMultiplier: ratioCalc * 1.1
                                        alignment: SGAlignedLabel.SideBottomCenter
                                        anchors.centerIn: parent

                                        SGInfoBox {
                                            id: currentPosition
                                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2                  // Default: 1.0 (affects text and unit)
                                            width: 100 * ratioCalc
                                            unit: "deg"
                                            boxColor: "#dcdcdc"
                                            boxBorderColor: "#a9a9a9"
                                            z: 3
                                        }
                                    }
                                }

                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    SGAlignedLabel {
                                        id: turnCountLabel
                                        target: turnCount
                                        text: "Turns\nCount "
                                        font.bold: true
                                        fontSizeMultiplier: ratioCalc * 1.1
                                        alignment: SGAlignedLabel.SideBottomCenter
                                        anchors.centerIn: parent
                                        SGInfoBox {
                                            id: turnCount
                                            fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2                  // Default: 1.0 (affects text and unit)
                                            unit: ""                                   // Default: ""
                                            width: 100 * ratioCalc
                                            text: platformInterface.notifications.get_data.turns.toString()
                                            boxColor: "#dcdcdc"
                                            boxBorderColor: "#a9a9a9"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    Layout.preferredHeight: parent.height + 10
                    Layout.preferredWidth: parent.width/120

                    Rectangle {
                        id:rightLine
                        color: "transparent"
                        height: parent.height + 5
                        anchors.left: parent.right
                        width: 1.5
                        border.color: "black"
                        radius: 2
                        z: 3

                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        id: analyticsHeading
                        text: "Analytics"
                        font.bold: true
                        font.pixelSize: ratioCalc * 25
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 8
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Rectangle {
                        id: line1
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width + 2.5
                        border.color: "black"
                        radius: 2
                        anchors {
                            top: analyticsHeading.bottom
                            topMargin: 7
                            left: parent.left
                            leftMargin: -2
                        }
                    }

                    ColumnLayout {
                        anchors {
                            top: line1.bottom
                            topMargin: 10
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        spacing: 5

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: versionLabel
                                target: version
                                text: "Version #"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.top: parent.top
                                anchors.topMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 30

                                SGInfoBox {
                                    id: version
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2                  // Default: 1.0 (affects text and unit)
                                    unit: " "                                   // Default: ""
                                    width: 100 * ratioCalc
                                    text: platformInterface.notifications.get_firmware_version.version.toString()
                                    boxColor: "#dcdcdc"
                                    boxBorderColor: "#a9a9a9"

                                }
                            }
                        }


                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: batteryBackupVoltageLabel
                                target: batteryBackupVoltage
                                text: "Backup Battery \n Voltage"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.left: parent.left
                                anchors.leftMargin: 30

                                SGInfoBox {
                                    id: batteryBackupVoltage
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2                  // Default: 1.0 (affects text and unit)
                                    unit: "V"                                   // Default: ""
                                    width: 100 * ratioCalc
                                    boxColor: "#dcdcdc"
                                    boxBorderColor: "#a9a9a9"
                                    anchors.left: parent.left
                                    text: platformInterface.notifications.get_battv.battv.toString()
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: battAlarmThresLabel
                                target: battAlarmThres
                                text: "Low Battery\nThreshold"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.left: parent.left
                                anchors.leftMargin: 30

                                SGInfoBox {
                                    id: battAlarmThres
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2
                                    width: 100 * ratioCalc
                                    unit : "V"
                                    text: platformInterface.notifications.get_lowbattv.lowbatt_threshold.toString()
                                    boxColor: "#dcdcdc"
                                    anchors.left: parent.left
                                    boxBorderColor: "#a9a9a9"
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            SGAlignedLabel {
                                id: temperatureLabel
                                target: temperature
                                text: "Temperature"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.left: parent.left
                                anchors.leftMargin: 30

                                SGInfoBox {
                                    id: temperature
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2
                                    unit: "°C"
                                    width: 100 * ratioCalc
                                    text: platformInterface.notifications.get_temperature.temperature.toString()
                                    boxColor: "#dcdcdc"
                                    anchors.left: parent.left
                                    boxBorderColor: "#a9a9a9"

                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGAlignedLabel {
                                id: maxTemperatureLabel
                                target: maxTemperature
                                text: "Max Temperature"
                                font.bold: true
                                fontSizeMultiplier: ratioCalc * 1.1
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.left: parent.left
                                anchors.leftMargin: 30

                                SGInfoBox {
                                    id: maxTemperature
                                    fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc * 1.2
                                    unit: "°C"
                                    width: 100 * ratioCalc
                                    anchors.left: parent.left
                                    text: platformInterface.notifications.get_maxtemp.maxtemp_threshold.toString()
                                    boxColor: "#dcdcdc"
                                    boxBorderColor: "#a9a9a9"
                                }
                            }
                        }

                        Item   {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGButton {
                                id: resetTurns
                                text: "RESET \n TURNS"
                                fontSizeMultiplier: ratioCalc * 1.1
                                width: 100 * ratioCalc
                                height: 70 * ratioCalc
                                anchors.centerIn: parent
                                onClicked: {
                                    for (var i = 0; i < 10 ; ++i) {
                                        addCommand("reset_turns")
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGButton {
                                id: resetPosition
                                text: "RESET \n POSITION"
                                fontSizeMultiplier: ratioCalc * 1.1
                                width: 100 * ratioCalc
                                height: 70 * ratioCalc
                                anchors.centerIn: parent

                                property var reset_positionValue: platformInterface.notifications.reset_position.position
                                onReset_positionValueChanged: {
                                    var positionIs = returnAngle(reset_positionValue)
                                    console.log(returnAngle(reset_positionValue))
                                    currentPosition.text = Number(positionIs).toFixed(2)
                                }

                                onClicked: {
                                    for (var i = 0; i < 10 ; ++i) {
                                        addCommand("reset_position")
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            SGButton {
                                id: resetError
                                text: "RESET \n ERRORS"
                                fontSizeMultiplier: ratioCalc * 1.1
                                width: 100 * ratioCalc
                                height: 70 * ratioCalc
                                anchors.centerIn: parent
                                roundedTop: true
                                roundedBottom: true
                                onClicked: {
                                    for (var i = 0; i < 10 ; ++i) {
                                        addCommand("reset_errors")
                                    }
                                }
                            }

                            Connections  {
                                target: platformInterface.notifications.reset_errors
                                onNotificationFinished: {
                                    if(platformInterface.notifications.reset_errors.overspeed === 1)
                                        overSpeed.status =  SGStatusLight.Red
                                    else overSpeed.status = SGStatusLight.Green

                                    if(platformInterface.notifications.reset_errors.sensor_error === 1)
                                        sensorError.status = SGStatusLight.Red
                                    else sensorError.status = SGStatusLight.Green

                                    if(platformInterface.notifications.reset_errors.overflow === 1)
                                        turnCountOverflow.status = SGStatusLight.Red
                                    else turnCountOverflow.status = SGStatusLight.Green

                                    if(platformInterface.notifications.reset_errors.low_bat === 1)
                                        lowBattery.status = SGStatusLight.Red
                                    else lowBattery.status = SGStatusLight.Green

                                    if(platformInterface.notifications.reset_errors.no_power === 1)
                                        nopower.status =  SGStatusLight.Red
                                    else nopower.status = SGStatusLight.Green

                                    if(platformInterface.notifications.reset_errors.over_temp === 1)
                                        overTempError.status =  SGStatusLight.Red
                                    else overTempError.status = SGStatusLight.Green

                                    if(platformInterface.notifications.reset_errors.batt_alarm === 1)
                                        battAlarmThresError.status =  SGStatusLight.Red
                                    else battAlarmThresError.status = SGStatusLight.Green
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
