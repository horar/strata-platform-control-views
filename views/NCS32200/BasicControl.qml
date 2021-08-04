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

    SGText {
        id: boardTitle
        anchors.horizontalCenter: parent.horizontalCenter
        text: "NCS32200 Evaluation System"
        font.bold: true
        font.pixelSize: ratioCalc * 25
        topPadding: 5
    }

    Component.onCompleted:{
        addCommand("get_data")
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

    function sendCommand () {
        timer.running = false
        if (commandQueue.count > 0) {
            let command = commandQueue.get(0).command
            if(commandQueue.get(0).value !== "") {
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
        id: getTelemetryCommand
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            var command = "status_telemetry"
            console.log(command)
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
                    Layout.preferredHeight: parent.height/15
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
                        id: line1
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

                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: currPositionLabel
                        target: currPosition
                        alignment: SGAlignedLabel.SideTopLeft
                        //anchors.centerIn: parent
                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                        text: "Current \n Position"

                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: currPosition
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            anchors.left: parent.left
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "mm "
                            unitOverrideWidth:  50 * ratioCalc
                            text: platformInterface.notifications.get_data.pos

                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    SGAlignedLabel {
                        id: currVeloLabel
                        target: currVelo
                        alignment: SGAlignedLabel.SideTopLeft
                        fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                        text: "Current \n Velocity"
                        font.bold : true
                        horizontalAlignment: Text.AlignHCenter
                        SGInfoBox{
                            id: currVelo
                            height:  35 * ratioCalc
                            width: 135 * ratioCalc
                            fontSizeMultiplier: ratioCalc === 0 ? 1.1 : ratioCalc
                            unit: "mm/s"
                            anchors.left: parent.left
                            unitOverrideWidth: 50 * ratioCalc
                            text: platformInterface.notifications.get_data.vel
                        }
                    }
                }

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
                            text: platformInterface.notifications.status_telemetry.ibat
                        }
                    }
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
                                text: "Temperature \n (˚c)"
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
            Layout.preferredWidth: parent.width/2.3
            Layout.fillHeight: true
            ColumnLayout{
                anchors.fill:parent

                Connections  {
                    target: platformInterface.notifications.get_data
                    onNotificationFinished: {
                        var positionIs = platformInterface.notifications.get_data.pos
                        rotatingImage.x = positionIs

                        let currentTime = Date.now()
                        let curve = timedGraphPoints.curve(0)

                        curve.shiftPoints((currentTime - graphTimerPoints.lastTime)/1000, 0)
                        curve.append(0, positionIs)

                        graphTimerPoints.removeOutOfViewPoints()
                        timedGraphPoints.update()

                        graphTimerPoints.lastTime = currentTime
                        //                        currentPosition.text = Number(positionIs).toFixed(2)

                        //                        if(positionIs.toFixed(0) === "360") {
                        //                            angleDial.previousAngle = 0
                        //                            angleDial.angle = 0
                        //                            angleDial.rotation.start()
                        //                        }
                        //                        else  {
                        //                            angleDial.previousAngle = angleDial.angle
                        //                            angleDial.angle = positionIs.toFixed(0)
                        //                            angleDial.rotation.start()
                        //                        }

                    }
                }
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height/1.5
                    SGGraph {
                        id: timedGraphPoints
                        anchors {
                            bottom: parent.bottom
                        }
                        anchors.fill: parent
                        title: "Time Vs.Current Position"
                        xMin: -200
                        xMax: 200
                        yMin: 0
                        yMax: 20
                        //                        yMin: 0
                        //                        yMax: 1
                        //                        xMin: 5
                        //                        xMax: 0
                        xTitle: "Current Position(mm)"
                        yTitle: "Time (s)"
                        xGrid: true
                        yGrid: true
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
                                    //timedGraphPoints.curve(0).clear()
                                    lastTime = Date.now()
                                }
                            }

                            //                            onTriggered: {
                            //                                let currentTime = Date.now()
                            //                                let curve = timedGraphPoints.curve(0)
                            //                                curve.shiftPoints((currentTime - lastTime)/1000, 0)
                            //                                curve.append(0, timedGraphPoints.yourDataValueHere())
                            //                                removeOutOfViewPoints()
                            //                                timedGraphPoints.update()
                            //                                lastTime = currentTime
                            //                            }

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

                Item {
                    id: container
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    SGRotateImage {
                        id: rotatingImage
                        width: parent.width
                        height:  parent.height/2
                        z: -1
                    }

                    function getRandomArbitrary(min, max) {
                        return Math.random() * (max - min) + min;
                    }

                    Button {
                        width: 50
                        height: 50
                        text: "L"
                        anchors.top: rotatingImage.bottom
                        anchors.topMargin: 10
                        anchors.left: right.right

                        MouseArea {
                            anchors.fill: parent
                            onClicked: rotatingImage.x = container.getRandomArbitrary(-200,200)
                        }
                    }

                    //                    Button {
                    //                        id: right
                    //                        width: 50
                    //                        height: 50
                    //                        text: "R"
                    //                        anchors.top: rotatingImage.bottom

                    //                        MouseArea { anchors.fill: parent; onClicked: rotatingImage.x = 200 }
                    //                    }
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
                                    inputBox.unit: " V"
                                    inputBox.unitFont.bold: true
                                    fontSizeMultiplier: ratioCalc
                                    inputBox.unitOverrideWidth: 30 * ratioCalc
                                    inputBox.validator: DoubleValidator { top: 4.5; bottom: 2.7 }

                                    onUserSet: {
                                        platformInterface.commands.set_low_batt.update(value)
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
                                    inputBox.unit: " V"
                                    inputBox.unitFont.bold: true
                                    fontSizeMultiplier: ratioCalc
                                    inputBox.unitOverrideWidth: 30 * ratioCalc
                                    inputBox.validator: DoubleValidator { top: 4.5; bottom: 2.7 }

                                    onUserSet: {
                                        platformInterface.commands.set_battv.update(value)
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
                                    stepSize: 0.1
                                    fromText.text: "0 ˚C"
                                    toText.text: "125 ˚C"
                                    inputBoxWidth: tempThresholdContainer.width/3
                                    inputBox.unit: " V"
                                    inputBox.unitFont.bold: true
                                    fontSizeMultiplier: ratioCalc
                                    inputBox.unitOverrideWidth: 30 * ratioCalc
                                    inputBox.validator: DoubleValidator { top: 125 ; bottom: 0 }

                                    onUserSet: {
                                        platformInterface.commands.set_over_temp.update(value)
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
                                        if(checked)
                                            addCommand("vcc_en","on")
                                        else
                                            addCommand("vcc_en","off")
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
                                    SGButton {
                                        width: 100 * ratioCalc
                                        height: 50 * ratioCalc
                                        text: "Reset \n Positions"
                                        anchors.centerIn: parent
                                        onClicked: {
                                            for (var i = 0; i < 10 ; ++i) {
                                                addCommand("reset_position")
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
