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
    Layout.fillHeight: true

    Component.onCompleted: {
        Help.registerTarget(runningButton, "Place holder for Basic control view help messages", 0, "BasicControlHelp")
    }


    ColumnLayout {
        id: sideBarColumn
        anchors {
            fill: parent
            margins: 10
        }
        spacing: 10

        IconButton {
            id: logoOnButton
            toolTipText: "ON Semiconductor"
            source: "qrc:/image/on-logo-green.svg"
            iconOpacity: 1
            onClicked:  {
            }
        }

        SGText {
            text: "Quick Start Controls:"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            fontSizeMultiplier: .8
            color: "white"
        }

        IconButton {
            id: speedButton
            toolTipText: "Set motor target speed"
            value: speedPop.value
            unit: "RPM"
            source: "qrc:/image/tach.svg"
            iconOpacity: speedPop.visible ? .5 : 1

            onClicked:  {
                speedPop.visible = !speedPop.visible
            }

            SliderPopup {
                id: speedPop
                x: parent.width + sideBarColumn.anchors.margins
                title: "Target Speed"
                unit: "RPM"
                from: 0
                to: 1000
            }
        }

        IconButton {
            id: accelButton
            toolTipText: "Set motor acceleration speed"
            value: accelPop.value
            unit: "RPM/s"
            source: "qrc:/image/tach.svg"
            iconOpacity: accelPop.visible ? .5 : 1

            onClicked:  {
                accelPop.visible = !accelPop.visible
            }

            SliderPopup {
                id: accelPop
                x: parent.width + sideBarColumn.anchors.margins
                title: "Acceleration"
                unit: "RPM/s"
                from: 0
                to: 1000
            }
        }

        IconButton {
            id: runningButton
            source: running ? "qrc:/image/stop-solid.svg" : "qrc:/image/play-solid.svg"
            iconColor: running ? "#db0909" : "#45e03a"
            toolTipText: "Start/stop motor"

            property bool running: false

            onClicked:  {
                running = !running
                // start/stop logic here
            }
        }

        IconButton {
            id: brakeButton
            source: "qrc:/image/brake.svg"
            toolTipText: "Set brake"

            onClicked:  {
                // braking logic here
            }
        }

        IconButton {
            id: forwardReverseButton
            enabled: runningButton.running === false //  direction control disabled when motor running
            opacity: enabled ? 1 : .5
            source: forward ? "qrc:/image/redo-alt-solid.svg" : "qrc:/image/undo.svg"
            toolTipText: "Set motor direction"
            animationRunning: runningButton.running
            animationDirection: forward ? RotationAnimator.Clockwise : RotationAnimator.Counterclockwise

            property bool forward: true

            onClicked:  {
                forward = !forward
                // directional logic here
            }
        }

        Item {
            // filler
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ColumnLayout {
            spacing: 8

            FaultLight {
                text: "OCP"
                toolTipText: "Over Current Protection"
                status: SGStatusLight.Off
            }

            FaultLight {
                text: "OVP"
                toolTipText: "Over Voltage Protection"
                status: SGStatusLight.Yellow
            }

            FaultLight {
                text: "OTP"
                toolTipText: "Over Temp Protection"
                status: SGStatusLight.Red
            }

            // add or remove more as needed
        }

        Item {
            // filler
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        IconButton {
            id: helpIcon
            source: "qrc:/sgimages/question-circle.svg" // generic icon from SGWidgets

            onClicked:  {
                if(basicControl.visible === true) {Help.startHelpTour("basicHelp")}
                else if(advancedControl.visible === true) {Help.startHelpTour("advanceHelp")}
                else if(settingsControl.visible === true) {Help.startHelpTour("settingsHelp")}
                else if(exportControl.visible === true) {Help.startHelpTour("exportControlHelp")}
                else console.log("help not available")
                }
            }
        }
    }

