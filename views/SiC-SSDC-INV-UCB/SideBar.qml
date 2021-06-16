import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.12

import "qrc:/js/help_layout_manager.js" as Help
import "sgwidgets/"

import tech.strata.sgwidgets 1.0

Rectangle {
    id: sideBar
    color: "#454545"
    implicitWidth: 70
    implicitHeight: parent.height

    property var error_status: platformInterface.error.value

    property bool dpt: false

    onError_statusChanged: {
        if  (error_status === 0) {}
            else {
            runningButton.source = "qrc:/image/stop-solid.svg"
            runningButton.iconColor = "#db0909"
            runningButton.running = false
        }
    }

    Component.onCompleted: {
        Help.registerTarget(runningButton, "Place holder for Basic control view help messages", 0, "BasicControlHelp")
    }

    ColumnLayout {
        id: sideBarColumn
        anchors {
            fill: parent
            margins: 15
        }
        spacing: 5

        SGText {
            text: "Quick Start Controls:"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            fontSizeMultiplier: .7
            color: "white"
        }

        IconButton {
            id: dptButton
            enabled: basicControl.motor_play === 0 //  DPT disabled when motor running
            opacity: enabled ? 1 : .2
            source: dpt ? "qrc:/image/DPT.png" : "qrc:/image/icon-motor.svg"
            toolTipText: "Enable MDK or DPT"

            onClicked:  {
                dpt = !dpt
                //dpt ? PulseControl : BasicControl
            }
        }

        IconButton {
            id: speedButton
            enabled: !dpt
            opacity: !dpt ? 1 : .0
            toolTipText: "Set motor target speed"
            value: speedPop.value
            unit: "RPM"
            source: "qrc:/image/tach.svg"
            iconOpacity: speedPop.visible ? .5 : 1

            onClicked:  {
                speedPop.visible = !speedPop.visible
                settingsControl.target = speedPop.value
                platformInterface.speed = speedPop.value
            }

            SliderPopup {
                id: speedPop
                enabled: !dpt
                opacity: !dpt ? 1 : .0
                x: parent.width + sideBarColumn.anchors.margins
                title: "Target Speed"
                unit: "RPM"
                from: 0
                to: settingsControl.max_motor_speed
                value: 0
            }
        }

        IconButton {
            id: accelButton
            enabled: !dpt
            opacity: !dpt ? 1 : .0
            toolTipText: "Set motor acceleration speed"
            value: accelPop.value
            unit: "RPM/s"
            source: "qrc:/image/tach.svg"
            iconOpacity: accelPop.visible ? .5 : 1

            onClicked:  {
                accelPop.visible = !accelPop.visible
                settingsControl.ratio = accelPop.value
                settingsControl.acceleration = accelPop.value
                platformInterface.acceleration = accelPop.value
            }

            SliderPopup {
                id: accelPop
                enabled: !dpt
                opacity: !dpt ? 1 : .0
                x: parent.width + sideBarColumn.anchors.margins
                title: "Acceleration"
                unit: "RPM/s"
                from: 0
                to: 1000
                value: 0
            }
        }

        IconButton {
            id: forwardReverseButton
            enabled: runningButton.running === false && platformInterface.status_vi.a < 5 && !dpt //  direction control disabled when motor running
            opacity: enabled  && !dpt ? 1 : .0
            source: forward ? "qrc:/image/redo-alt-solid.svg" : "qrc:/image/undo.svg"
            toolTipText: "Set motor direction"
            animationRunning: runningButton.running
            animationDirection: forward ? RotationAnimator.Clockwise : RotationAnimator.Counterclockwise

            property bool forward: true

            onClicked:  {
                forward = !forward
                // directional logic here
                forward ? platformInterface.set_direction.update(1) : platformInterface.set_direction.update(0)
            }
        }

        IconButton {
            id: runningButton
            enabled: basicControl.motor_play === 1  && !dpt //  direction control disabled when motor running
            opacity: enabled  && !dpt ? 1 : .0
            source: running ? "qrc:/image/stop-solid.svg" : "qrc:/image/play-solid.svg"
            iconColor: running ? "#db0909" : "#45e03a"
            toolTipText: "Start/stop motor"

            property bool running: false
            property var speed: platformInterface.status_vi.a

            onSpeedChanged: {
                if (speed < 5){
                    runningButton.source = "qrc:/image/play-solid.svg"
                    runningButton.iconColor = "#45e03a"
                    forwardReverseButton.animationRunning = false
                }
                else {
                    runningButton.source = "qrc:/image/stop-solid.svg"
                    runningButton.iconColor = "#db0909"
                    forwardReverseButton.animationRunning = true
                }
            }

            onClicked:  {
                running = !running
                // start/stop logic here
                if (basicControl.motor_play === 1){
                    if (running == true  && platformInterface.status_vi.a < 5) {settingsControl.play()}
                    else{settingsControl.stop()}
                }
                else{settingsControl.stop()}
            }
        }

        IconButton {
            id: dcLinkButton
            enabled: dpt
            opacity: dpt ? 1 : .0
            toolTipText: "Set DC Link Voltage"
            value: dcLinkPop.value
            unit: "DC Link (V)"
            source: "qrc:/image/tach.svg"
            iconOpacity: dcLinkPop.visible ? .5 : 1

            onClicked:  {
                dcLinkPop.visible = !dcLinkPop.visible
                pulseControl.dcLink = dcLinkPop.value
            }

            SliderPopup {
                id: dcLinkPop
                enabled: dpt
                opacity: dpt ? 1 : .0
                x: parent.width + sideBarColumn.anchors.margins
                title: "Target DC Link Voltage"
                unit: "Volts"
                from: 0
                to: 600
                value: 0
            }
        }

        IconButton {
            id: inductorButton
            enabled: dpt
            opacity: dpt ? 1 : .0
            toolTipText: "Set Load Inductance"
            value: inductorPop.value
            unit: "Load (µH)"
            source: "qrc:/image/tach.svg"
            iconOpacity: inductorPop.visible ? .5 : 1

            onClicked:  {
                inductorPop.visible = !inductorPop.visible
                pulseControl.inductor = inductorPop.value
            }

            SliderPopup {
                id: inductorPop
                enabled: dpt
                opacity: dpt ? 1 : .0
                x: parent.width + sideBarColumn.anchors.margins
                title: "Target Load Inductance "
                unit: "µH"
                from: 0
                to: 1000
                value: 0
            }
        }

        Item {
            // filler
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ColumnLayout {
            spacing: 8
            enabled: !dpt
            opacity: !dpt ? 1 : .0

            FaultLight {
                text: "ERROR"
                toolTipText: "ERROR MESSAGES"
                status: (error_status === 0) ? SGStatusLight.Green : SGStatusLight.Red
            }

            FaultLight {
                text: "ADC"
                toolTipText: "ADC THRESHOLD OUTSIDE RANGE"
                status: (error_status === 1) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "SCI"
                toolTipText: "STARTUP CURRENT INJECTION ERROR"
                status: (error_status === 2) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "SCI2"
                toolTipText: "STARTUP CURRENT INJECTION2 ERROR"
                status: (error_status === 3) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "UV"
                toolTipText: "UNDERVOLTAGE"
                status: (error_status === 4) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "OV"
                toolTipText: "OVERVOLTAGE"
                status: (error_status === 5) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "OT"
                toolTipText: "OVER TEMPERATURE"
                status: (error_status === 6) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "OCP"
                toolTipText: "OVERCURRENT PROTECTION ACTIVE"
                status: (error_status === 7) ? SGStatusLight.Red : SGStatusLight.Off
            }

            FaultLight {
                text: "WDR"
                toolTipText: "WATCHDOG RESET"
                status: (error_status === 8) ? SGStatusLight.Red : SGStatusLight.Off
            }

            // add or remove more as needed
        }

        Item {
            // filler
            Layout.fillHeight: true
            Layout.fillWidth: true
            }
        }
    }

