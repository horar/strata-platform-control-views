import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "qrc:/js/help_layout_manager.js" as Help

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Rectangle {
    id: root
    property real ratioCalc: root.width / 1200
    property real initialAspectRatio: 1164/816
    color: "light gray"
    property bool vccToggle: false
    anchors.centerIn: parent
    height: parent.height
    width: parent.width / parent.height > initialAspectRatio ? parent.height * initialAspectRatio : parent.width
    property real zeroOffset: 0



    SGText {
        id: boardTitle
        anchors.horizontalCenter: parent.horizontalCenter
        text: "NCS32200 Evaluation System"
        font.bold: true
        font.pixelSize: ratioCalc * 25
        topPadding: 5
    }

    Component.onCompleted:{
        sendCommand()
        startTimer()
    }

    ListModel {
        id: commandQueue
    }

    function addCommand (command,value) {
        commandQueue.append({
                                "command": command,
                                "value" : value

                            })
    }

    function addIntCommand (command,value = -1) {
        commandQueue.append({
                                "command": command,
                                "value" : value

                            })
    }

    function sendCommand () {
        timer.running = false
        if (commandQueue.count > 0) {
            let command = commandQueue.get(0).command
            let value = commandQueue.get(0).value
            if(commandQueue.get(0).value !== "") {
                platformInterface.commands[command].update(value)
                //console.log(platformInterface.commands[command].update(value))
                //                console.log(command)
                //                console.log(value)
                //                console.log("correct value")
            }
            else  {
                platformInterface.commands[command].update()
                //                console.log(command)
                //                console.log(value)
                //                console.log("incorrect value")
            }
            commandQueue.remove(0)

        } else {
            console.log(vccToggle)
            if(vccToggle) {
                platformInterface.commands.get_data.update()
            }
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
        target: platformInterface.notifications.status_telemetry
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
        target: platformInterface.notifications.vcc_en
        onNotificationFinished: {
            sendCommand()
        }
    }

    Connections {
        target: platformInterface.notifications.bat_en
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
        target: platformInterface.notifications.reset_position
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

    function startTimer() {
        getTempCommand.start()
        getErrorCommand.start()
        getLowBattvCommand.start()
        getMaxTempValueCommand.start()
        getFirmwareVersionCommand.start()
        getBattvValueCommand.start()
        getTelemetryCommand.start()
    }


    Timer {
        id: getTempCommand
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            if(vccToggle) {
                var command = "get_temperature"
                addCommand(command)
            }
        }
    }

    Timer {
        id: getErrorCommand
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            if(vccToggle) {
                var command = "get_errors"
                addCommand(command)
            }
        }
    }

    Timer {
        id: getLowBattvCommand
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            if(vccToggle) {
                var command = "get_lowbattv"
                addCommand(command)
            }
        }
    }

    Timer {
        id: getMaxTempValueCommand
        interval: 4000
        running: false
        repeat: false
        onTriggered: {
            if(vccToggle) {
                var command = "get_maxtemp"
                addCommand(command)
            }
        }
    }

    Timer {
        id: getBattvValueCommand
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            if(vccToggle) {
                var command = "get_battv_value"
                addCommand(command)
            }
        }
    }

    Timer {
        id: getTelemetryCommand
        interval: 6000
        running: false
        repeat: false
        onTriggered: {
            var command = "status_telemetry"
            addCommand(command)
        }
    }

    Timer {
        id: getFirmwareVersionCommand
        interval: 7000
        running: false
        repeat: false
        onTriggered: {
            if(vccToggle) {
                var command = "get_firmware_version"
                addCommand(command)
            }
            startTimer()
        }
    }




    RowLayout {
        anchors {
            top: boardTitle.bottom
            topMargin: 5
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin : 10
            bottom: parent.bottom
            bottomMargin: 10
        }
        width: parent.width
        height: root.height - boardTitle.contentHeight

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors {
                    fill:parent
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/20
                    color: "transparent"
                    Text {
                        id: sensorDataHeading
                        text: "Position"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 2
                        }
                    }

                    Rectangle {
                        id: line1
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "black"
                        radius: 1.5
                        anchors {
                            top: sensorDataHeading.bottom
                            topMargin: 2
                        }
                    }
                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item {
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width/5
                        SGText{
                            id: positionLabel
                            text: "Position"
                            font.bold: true
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SGInfoBox{
                            id: currPosition
                            height:  35 * ratioCalc
                            width: 115 * ratioCalc
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "mm "
                            unitOverrideWidth:  50 * ratioCalc
                        }
                    }

                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SGInfoBox{
                            id: currPositionUm
                            height:  35 * ratioCalc
                            width: 115 * ratioCalc
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "um"
                            unitOverrideWidth:  50 * ratioCalc
                        }
                    }
                }

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item {
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width/5

                        SGText{
                            id: velocityLabel
                            text: "Velocity"
                            font.bold: true
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        SGInfoBox {
                            id:  currVelocity
                            height:  35 * ratioCalc
                            width: 115 * ratioCalc
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "mm/s"
                            unitOverrideWidth:  50 * ratioCalc
                        }
                    }

                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        SGInfoBox {
                            id: currVelocityUm
                            height:  35 * ratioCalc
                            width: 115 * ratioCalc
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "um/s"
                            unitOverrideWidth:  50 * ratioCalc
                        }
                    }
                }

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item {
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width/5

                        SGText{
                            id: offsetLabel
                            text: "Zero\nOffset"
                            font.bold: true
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        SGInfoBox {
                            id:  currOffsetMm
                            height:  35 * ratioCalc
                            width: 115 * ratioCalc
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "mm"
                            unitOverrideWidth:  50 * ratioCalc
                        }
                    }

                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        SGInfoBox {
                            id: currOffsetUm
                            height:  35 * ratioCalc
                            width: 115 * ratioCalc
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "um"
                            unitOverrideWidth:  50 * ratioCalc
                        }
                    }
                }

//                Item{
//                    Layout.fillHeight: true
//                    Layout.fillWidth: true

//                    SGAlignedLabel {
//                        id: zeroOffsetLabel
//                        target: zeroOffset
//                        alignment: SGAlignedLabel.SideTopLeft
//                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                        text: "Zero Offset"
//                        font.bold : true

//                        SGSubmitInfoBox {
//                            id: zeroOffset
//                            height:  35 * ratioCalc
//                            width: 135 * ratioCalc
//                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                            infoBoxObject.unitOverrideWidth: 50 * ratioCalc
//                            Layout.alignment: Qt.AlignLeft
//                        }
//                    }
//                }
                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SGButton {
                            height:  40 * ratioCalc
                            width: 120 * ratioCalc
                            text: "Zero\n Position"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter

                            onClicked: {
                                for (var i = 0; i < 10 ; ++i) {
                                    addCommand("reset_position")
                                }
                            }
                        }
                    }
//                    Item{
//                        Layout.fillHeight: true
//                        Layout.fillWidth: true

//                        SGSwitch {
//                            checkedLabel: "Relative"
//                            uncheckedLabel: "Absolute"
//                            anchors.left: parent.left
//                            anchors.verticalCenter: parent.verticalCenter
//                        }
//                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/20
                    color: "transparent"
                    Text {
                        id: telemetryHeading
                        text: "Telemetry"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 5
                        }
                    }

                    Rectangle {
                        id: lineVelo
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "black"
                        radius: 1.5
                        anchors {
                            top: telemetryHeading.bottom
                            topMargin: 5
                        }
                    }
                }


                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true


                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SGAlignedLabel {
                            id: supplyVoltageLabel
                            target: supplyVoltage
                            alignment: SGAlignedLabel.SideTopLeft
                            //anchors.centerIn: parent
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            text: "Supply \nVoltage (VCC)"
                            font.bold : true
                            // horizontalAlignment: Text.AlignHCenter
                            SGInfoBox{
                                id: supplyVoltage
                                height:  35 * ratioCalc
                                width: 135 * ratioCalc
                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                unit: "V "
                                unitOverrideWidth: 50 * ratioCalc
                                text: platformInterface.notifications.status_telemetry.vcc
                            }
                        }
                    }

                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SGAlignedLabel {
                            id: batteryVoltageLabel
                            target: batteryVoltage
                            alignment: SGAlignedLabel.SideTopLeft
                            //anchors.centerIn: parent
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            text: "Battery \nVoltage (VBAT)"
                            font.bold : true
                            //horizontalAlignment: Text.AlignHCenter
                            SGInfoBox{
                                id: batteryVoltage
                                height:  35 * ratioCalc
                                width: 135 * ratioCalc
                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                unit: "V"
                                unitOverrideWidth: 50 * ratioCalc
                                text: platformInterface.notifications.status_telemetry.vbat
                            }
                        }
                    }
                }

                RowLayout{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Item{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        SGAlignedLabel {
                            id: batteryCurrentLabel
                            target: batteryCurrent
                            alignment: SGAlignedLabel.SideTopLeft
                            //anchors.centerIn: parent
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            text: "Battery \nCurrent (IBAT)"
                            font.bold : true
                            //horizontalAlignment: Text.AlignHCenter
                            SGInfoBox{
                                id: batteryCurrent
                                height:  35 * ratioCalc
                                width: 135 * ratioCalc
                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                unit: "mA"
                                unitOverrideWidth: 50 * ratioCalc
                                anchors.left: parent.left
                                text: (platformInterface.notifications.status_telemetry.ibat) * 1000
                            }
                        }
                    }
//                    Item{
//                        Layout.fillHeight: true
//                        Layout.fillWidth: true
//                        SGAlignedLabel {
//                            id: offsetLabel
//                            target: offset
//                            alignment: SGAlignedLabel.SideTopLeft
//                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                            text: "Offset \n"
//                            font.bold : true
//                            SGSubmitInfoBox{
//                                id: offset
//                                height:  35 * ratioCalc
//                                width: 135 * ratioCalc
//                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                                unit: "mm"
//                                infoBoxObject.unitOverrideWidth:50 * ratioCalc
//                                anchors.left: parent.left
//                                //                                onEditingFinished {

//                                //                                }
//                            }
//                        }
//                    }
                }
                Item {
                    Layout.preferredHeight: parent.height/3
                    Layout.fillWidth: true

                    RowLayout {
                        anchors {
                            fill: parent
                        }
                        spacing: 10
                        Item{
                            id: tempGaugeContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id: tempGaugeLabel
                                target: tempGauge
                                text: "Temperature \n (˚C)"
                                anchors {
                                    top:parent.top
                                    horizontalCenter: parent.horizontalCenter
                                }
                                alignment: SGAlignedLabel.SideBottomCenter
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                horizontalAlignment: Text.AlignHCenter

                                SGCircularGauge {
                                    id: tempGauge
                                    height: tempGaugeContainer.height - tempGaugeLabel.contentHeight - 50
                                    width:  tempGaugeContainer.width
                                    tickmarkStepSize: 10
                                    minimumValue: 0
                                    maximumValue: 125
                                    gaugeFillColor1: "blue"
                                    gaugeFillColor2: "red"
                                    valueDecimalPlaces: 1
                                    value: platformInterface.notifications.get_temperature.temperature

                                }
                            }
                        }
                        Item{
                            id: batteryPowerContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id: batteryPowerLabel
                                target: batteryPower
                                text: "Battery Power \n (mW)"
                                anchors {
                                    top:parent.top
                                    horizontalCenter: parent.horizontalCenter
                                }

                                alignment: SGAlignedLabel.SideBottomCenter
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                horizontalAlignment: Text.AlignHCenter

                                SGCircularGauge {
                                    id: batteryPower
                                    height: batteryPowerContainer.height - batteryPowerLabel.contentHeight - 50
                                    tickmarkStepSize: 0.5
                                    width:  tempGaugeContainer.width
                                    minimumValue: 0
                                    maximumValue: 5
                                    gaugeFillColor1: "blue"
                                    gaugeFillColor2: "red"
                                    //unitTextFontSizeMultiplier: ratioCalc * 1.5
                                    valueDecimalPlaces: 1
                                    value: platformInterface.notifications.status_telemetry.ibat * 1000 * platformInterface.notifications.status_telemetry.vbat

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
                anchors.left: parent.left
                width: 1
                border.color: "black"
                radius: 2
                z: 3
            }
        }

        Item  {
            Layout.preferredWidth: parent.width/2
            Layout.fillHeight: true

            ColumnLayout {
                id: column1
                height: parent.height
                width: parent.width/1.3
                spacing: 10
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    horizontalCenterOffset: parent.width * (.0175 - .05) // left and right differ by 0.035 as ratio of board width, so offsetting by half of that, 0.5 accounts for y axis text
                }

                Item {
                    id: container
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    z: 10

                    SGBoardImage {
                        id: boardImage
                        source: "board-image.png"
                        anchors {
                            bottom: parent.bottom
                        }
                        width: {
                            let left = timedGraphPoints.mapToPosition(Qt.point(-110, 0))
                            let right = timedGraphPoints.mapToPosition(Qt.point(110, 0))
                            boardImage.graphBaseDimension = (right.x - left.x)/220
                            return (right.x - left.x) / (.475 * 2)
                        }

                        property real graphBaseDimension

                        Component.onCompleted: {
                            if (visible) {
                                update()
                            }
                        }

                        Connections {
                            target: timedGraphPoints
                            onWidthChanged: {
                               boardImage.update()
                            }
                        }

                        Connections {
                            target: currOffsetMm
                            onTextChanged: {
                                boardImage.update()
                            }
                        }
                        Connections {
                            target: currOffsetUm
                            onTextChanged: {
                                boardImage.update()
                            }
                        }

                        function update() {
                            let left = timedGraphPoints.mapToPosition(Qt.point(-110, 0))
                            let right = timedGraphPoints.mapToPosition(Qt.point(110, 0))
                            boardImage.graphBaseDimension = (right.x - left.x)/220
                            boardImage.width = (right.x - left.x) / (.475 * 2) // 110mm scale is .475 of total board width. since graph is 2x110, divide by (.475 *2)
                            boardImage.x = left.x - (boardImage.width * .28) + (-zeroOffset * boardImage.graphBaseDimension) + (110 * boardImage.graphBaseDimension)
                        }

                        Item {
                            width: .475 * boardImage.width
                            height: .55 * boardImage.height
                            x: .28 * boardImage.width
                            y: .29 * boardImage.height

                            SGRotateImage {
                                id: rotatingImage
                                x: boardImage.graphBaseDimension * (Number(currPosition.text) + Number(zeroOffset))
                                width: 0
                                height: parent.height
                                source: "target_edited.png"

                                Rectangle {
                                    color: "black"
                                    width: 1
                                    height: 2000
                                }
                            }
                        }
                    }

                    function getRandomArbitrary(min, max) {
                        return Math.random() * (max - min) + min;
                    }
                }

                Connections  {
                    target: platformInterface.notifications.get_data
                    onNotificationFinished: {
                        var offset = platformInterface.notifications.get_data.auto_zero_offset
                        console.log(boardImage.x,offset)
                        zeroOffset = offset


                        currOffsetMm.text = Math.floor(zeroOffset)
                        currOffsetUm.text = ((offset - Math.floor(zeroOffset))*1000).toFixed(0)

                        var positionIs = platformInterface.notifications.get_data.pos

                        let currentTime = Date.now()
                        let curve = timedGraphPoints.curve(0)

                        curve.shiftPoints(0,(currentTime - graphTimerPoints.lastTime)/1000)
                        curve.append(positionIs,0)

                        graphTimerPoints.removeOutOfViewPoints()
                        timedGraphPoints.update()

                        graphTimerPoints.lastTime = currentTime

                        var data = platformInterface.notifications.get_data.pos
                        var  x = Math.floor(data)
                        var  y = data - x;
                        //console.log(y)
                        currPositionUm.text = (y*1000).toFixed(0)
                        currPosition.text = x

                        var data2 =  platformInterface.notifications.get_data.vel
                        var  x2 = Math.floor(data2)
                        var  y2 = data2 - x2;

                        currVelocityUm.text = (y2*1000).toFixed(0)
                        currVelocity.text = x2
                    }
                }

                Item {
                    id: graphContainer
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/1.35

                    SGGraph {
                        id: timedGraphPoints
                        anchors.bottom: parent.bottom
                        anchors.fill: parent
                        title: "Position Vs Time"
                        xMin: -110
                        xMax: 110
                        yMin: 0
                        yMax: 60
                        xTitle: "Position (mm)"
                        yTitle: "Time (s)"
                        //yRightTitle: "Velocity"
                        xGrid: true
                        yGrid: true
                        //yRightVisible: true
                        gridColor: "black"
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

                        function yourDataValueHere() {
                            return Math.random()
                        }

                        Timer {
                            id: graphTimerPoints
                            interval: 60
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
                                if (timedGraphPoints.curve(0).at(0).x > timedGraphPoints.xMax) {
                                    timedGraphPoints.curve(0).remove(0)
                                    removeOutOfViewPoints()
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
            Layout.leftMargin: 15

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
            Layout.fillWidth:  true
            Layout.fillHeight: true

            ColumnLayout {
                anchors {
                    fill:parent
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/20
                    color: "transparent"
                    Text {
                        id: configHeading
                        text: "Configuration"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 5
                        }
                    }

                    Rectangle {
                        id: line3
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "black"
                        radius: 1.5
                        anchors {
                            top: configHeading.bottom
                            topMargin: 5
                        }
                    }
                }
                Item {
                    Layout.preferredHeight: parent.height/1.9
                    Layout.fillWidth: true
                    ColumnLayout {
                        anchors {
                            fill:parent
                        }

                        Item{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id:  vbatLabel
                                target: vbat
                                text: "VBAT EN"
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                alignment: SGAlignedLabel.SideTopCenter
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                SGSwitch {
                                    id: vbat
                                    checkedLabel: "On"
                                    uncheckedLabel: "Off"
                                    onToggled: {
                                        if(checked)
                                            addCommand("bat_en","on")
                                        else
                                            addCommand("bat_en","off")
                                    }
                                }
                            }
                        }

                        Item{
                            id: vbatSetContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            SGAlignedLabel {
                                id: vbatSetLabel
                                target: vbatSet
                                alignment: SGAlignedLabel.SideTopLeft
                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                font.bold : true
                                text: "VBAT Set"

                                SGSlider {
                                    id: vbatSet
                                    width: vbatSetContainer.width
                                    live: false
                                    from: 2.7
                                    to: 4.5
                                    stepSize: 0.1
                                    fromText.text: "2.7 V"
                                    toText.text: "4.5 V"
                                    inputBoxWidth: vbatSetContainer.width/3
                                    // inputBox.unit: " V"
                                    inputBox.unitFont.bold: true
                                    fontSizeMultiplier: ratioCalc
                                    inputBox.unitOverrideWidth: 30 * ratioCalc
                                    inputBox.validator: DoubleValidator { top: 4.5; bottom: 2.7 }

                                    onUserSet: {
                                        console.log(Number(value).toFixed(1))
                                        addCommand("set_battv",(Number(value).toFixed(1)))
                                    }
                                }
                            }
                        }
                        Item{
                            id: batteryThresholdContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id: batteryThresholdLabel
                                target: batteryThreshold
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.centerIn: parent
                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                font.bold : true
                                text: "Battery Voltage Threshold"

                                SGSlider {
                                    id: batteryThreshold
                                    width: batteryThresholdContainer.width
                                    live: false
                                    from: 2.7
                                    to: 4.5
                                    stepSize: 0.1
                                    fromText.text: "2.7 V"
                                    toText.text: "4.5 V"
                                    inputBoxWidth: batteryThresholdContainer.width/3
                                    //inputBox.unit: " V"
                                    inputBox.unitFont.bold: true
                                    fontSizeMultiplier: ratioCalc
                                    inputBox.unitOverrideWidth: 30 * ratioCalc
                                    inputBox.validator: DoubleValidator { top: 4.5; bottom: 2.7 }

                                    onUserSet: {
                                        addIntCommand("set_low_batt",Number(value.toFixed(1)))
                                    }

                                }
                            }
                        }

                        Item{
                            id: tempThresholdContainer
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id:tempThresholdLabel
                                target: tempThreshold
                                alignment: SGAlignedLabel.SideTopLeft
                                anchors.centerIn: parent
                                fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                font.bold : true
                                text: "Temperature Threshold"

                                SGSlider {
                                    id: tempThreshold
                                    width: tempThresholdContainer.width
                                    live: false
                                    from: 0
                                    to: 125
                                    stepSize: 1
                                    fromText.text: "0 ˚C"
                                    toText.text: "125 ˚C"
                                    inputBoxWidth: tempThresholdContainer.width/3
                                    //inputBox.unit: " C"
                                    inputBox.unitFont.bold: true
                                    fontSizeMultiplier: ratioCalc
                                    inputBox.unitOverrideWidth: 30 * ratioCalc
                                    inputBox.validator: DoubleValidator { top: 125 ; bottom: 0 }

                                    onUserSet: {
                                        addIntCommand("set_over_temp",value.toFixed(2))
                                    }

                                }
                            }
                        }



                        Item{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            SGAlignedLabel {
                                id:  vccDisconnectLabel
                                target: vccDisconnect
                                text: "VCC Enable"
                                fontSizeMultiplier: ratioCalc
                                font.bold : true
                                alignment: SGAlignedLabel.SideTopCenter
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                SGSwitch {
                                    id: vccDisconnect
                                    checkedLabel: "On"
                                    uncheckedLabel: "Off"
                                    onToggled: {
                                        if(checked) {
                                            vccToggle = true
                                            addCommand("vcc_en","on")
                                        }
                                        else {
                                            vccToggle = false
                                            addCommand("vcc_en","off")

                                        }
                                    }

                                }
                            }
                        }
                    }
                }

                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/15
                    color: "transparent"
                    Text {
                        id: diagnosticsHeading
                        text: "Diagnostics"
                        font.bold: true
                        font.pixelSize: ratioCalc * 20
                        color: "#696969"
                        anchors {
                            top: parent.top
                            topMargin: 5
                        }
                    }

                    Rectangle {
                        id: line4
                        height: 2
                        Layout.alignment: Qt.AlignCenter
                        width: parent.width
                        border.color: "black"
                        radius: 1.5
                        anchors {
                            top: diagnosticsHeading.bottom
                            topMargin: 5
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    ColumnLayout {
                        anchors {
                            fill:parent
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            RowLayout {
                                anchors.fill: parent
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: vbatLowLabel
                                        target: vbatLow
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.0 : ratioCalc
                                        font.bold: true
                                        text: "VBAT Low"

                                        SGStatusLight {
                                            id: vbatLow
                                            width : 25
                                            status: platformInterface.notifications.get_errors.low_bat ? SGStatusLight.Red : SGStatusLight.Off

                                        }
                                    }
                                }

                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    SGAlignedLabel {
                                        id: noPowerLabel
                                        target: noPower
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                        font.bold: true
                                        text: "No Power"

                                        SGStatusLight {
                                            id: noPower
                                            width : 25
                                            status: platformInterface.notifications.get_errors.no_power ? SGStatusLight.Red : SGStatusLight.Off

                                        }
                                    }
                                }
                            }

                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            RowLayout {
                                anchors.fill: parent
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: sensorErrorLabel
                                        target: sensorError
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                        font.bold: true
                                        text: "Sensor Error"

                                        SGStatusLight {
                                            id: sensorError
                                            width : 25
                                            status: platformInterface.notifications.get_errors.sensor_error ? SGStatusLight.Red : SGStatusLight.Off

                                        }

                                    }
                                }

                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: batteryThresholdAlarmLabel
                                        target: batteryThresholdAlarm
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                        font.bold: true
                                        text: "Battery Threshold Alarm"

                                        SGStatusLight {
                                            id: batteryThresholdAlarm
                                            width : 25
                                            status: platformInterface.notifications.get_errors.batt_alarm ? SGStatusLight.Red : SGStatusLight.Off

                                        }
                                    }
                                }
                            }

                        }


                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            RowLayout{
                                anchors.fill: parent
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    SGAlignedLabel {
                                        id: overTempLabel
                                        target: overTemp
                                        alignment: SGAlignedLabel.SideTopCenter
                                        anchors.centerIn: parent
                                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                                        font.bold: true
                                        text: "Over Temperature"

                                        SGStatusLight {
                                            id: overTemp
                                            width : 25
                                            status: platformInterface.notifications.get_errors.over_temp ? SGStatusLight.Red : SGStatusLight.Off

                                        }
                                    }
                                }

                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            RowLayout {
                                anchors.fill: parent

                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    SGButton {
                                        width: 100 * ratioCalc
                                        height: 50 * ratioCalc
                                        text: "Reset \n Errors"
                                        anchors.centerIn: parent
                                        onClicked: {
                                            for (var i = 0; i < 10 ; ++i) {
                                                addCommand("reset_errors")
                                            }
                                        }
                                    }
                                }
                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    SGSwitch {
                                        id: dummy_switch
                                        checkedLabel: "Dummy"
                                        uncheckedLabel: "Real"
                                        onToggled: {
                                            if(checked)
                                                addCommand("dummy_data","true")
                                            else
                                                addCommand("dummy_data","false")
                                        }
                                    }
                                }
//                                Item{
//                                    Layout.fillHeight: true
//                                    Layout.fillWidth: true
//                                    SGAlignedLabel {
//                                        id: posmultlabel
//                                        alignment: SGAlignedLabel.SideTopLeft
//                                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                                        text: "position mult"
//                                        font.bold : true
//                                        SGSubmitInfoBox {
//                                            id: posmult
//                                            height:  35 * ratioCalc
//                                            width: 50 * ratioCalc
//                                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                                            infoBoxObject.unitOverrideWidth: 50 * ratioCalc
//                                            Layout.alignment: Qt.AlignLeft
//                                        }
//                                    }
//                                }
//                                Item{
//                                    Layout.fillHeight: true
//                                    Layout.fillWidth: true
//                                    SGAlignedLabel {
//                                        id: offsetlabel
//                                        alignment: SGAlignedLabel.SideTopLeft
//                                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                                        text: "Offset"
//                                        font.bold : true
//                                        SGSubmitInfoBox {
//                                            id: offsetbox
//                                            height:  35 * ratioCalc
//                                            width: 50 * ratioCalc
//                                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
//                                            infoBoxObject.unitOverrideWidth: 50 * ratioCalc
//                                            Layout.alignment: Qt.AlignLeft
//                                        }
//                                    }
//                                }


                                Item {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
