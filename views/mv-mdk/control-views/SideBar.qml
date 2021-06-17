import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml 2.12

import "qrc:/js/help_layout_manager.js" as Help
import "../widgets"

import tech.strata.sgwidgets 1.0

Rectangle {

    // ======================== General Settings ======================== //

    id: sideBar
    color: "#454545"
    implicitWidth: 70
    Layout.fillHeight: true

    // ======================== Default Notification Values ======================== //
    // Do this here instead of in PlatformInterface.qml because PIG overwrites values

    Component.onCompleted: {
        Help.registerTarget(runButton, "Place holder for Basic control view help messages", 0, "BasicControlHelp")

        // target_speed
        platformInterface.notifications.target_speed.caption = ""
        platformInterface.notifications.target_speed.scales.index_0 = 0
        platformInterface.notifications.target_speed.scales.index_1 = 0
        platformInterface.notifications.target_speed.scales.index_2 = 0
        platformInterface.notifications.target_speed.states = [0]
        platformInterface.notifications.target_speed.value = 0.0
        platformInterface.notifications.target_speed.values = []
        platformInterface.notifications.target_speed.unit = ""
        // target_speed
        platformInterface.notifications.acceleration.caption = ""
        platformInterface.notifications.acceleration.scales.index_0 = 0
        platformInterface.notifications.acceleration.scales.index_1 = 0
        platformInterface.notifications.acceleration.scales.index_2 = 0
        platformInterface.notifications.acceleration.states = [0]
        platformInterface.notifications.acceleration.value = 0.0
        platformInterface.notifications.acceleration.values = []
        platformInterface.notifications.acceleration.unit = ""
        // warnings
        platformInterface.notifications.warning_1.caption = ""
        platformInterface.notifications.warning_1.value = false
        platformInterface.notifications.warning_2.caption = ""
        platformInterface.notifications.warning_2.value = false
        platformInterface.notifications.warning_3.caption = ""
        platformInterface.notifications.warning_3.value = false 
    }

    // ======================== UI Objects ======================== //

    ColumnLayout {
        id: sideBarColumn
        anchors {
            fill: parent
            margins: 10
        }
        spacing: 10

        SGText {
            text: "Quick Start Controls"
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            fontSizeMultiplier: .8
            color: "white"
        }

        // ------------------------ Target Speed ------------------------ //

        IconButton {
            id: speedButton
            toolTipText: "Set " + platformInterface.notifications.target_speed.caption.toLowerCase()
            value: platformInterface.notifications.target_speed.value
            unit: platformInterface.notifications.target_speed.unit
            source: "qrc:/images/tach.svg"
            iconOpacity: speedPop.visible ? .5 : 1

            onClicked:  {
                speedPop.visible = !speedPop.visible                
            }

            SliderPopup {
                id: speedPop
                x: parent.width + sideBarColumn.anchors.margins

                value: platformInterface.notifications.target_speed.value
                title: platformInterface.notifications.target_speed.caption
                unit: platformInterface.notifications.target_speed.unit
                to: platformInterface.notifications.target_speed.scales.index_0
                from: platformInterface.notifications.target_speed.scales.index_1
                stepSize: platformInterface.notifications.target_speed.scales.index_2
                // states
                // enabled: runButton.running === false //  direction control disabled when motor running
                // opacity: enabled ? 1 : .5

                onUserSet: {
                    console.log("onUserSet:", value)
                    platformInterface.commands.target_speed.update(
                        speedPop.value
                    )
                }

            }
        }

        // ------------------------ Acceleration ------------------------ //

        IconButton {
            id: accelButton
            toolTipText: "Set " + platformInterface.notifications.target_speed.caption.toLowerCase()
            value: platformInterface.notifications.acceleration.value
            unit: platformInterface.notifications.acceleration.unit
            source: "qrc:/images/tach.svg"
            iconOpacity: accelPop.visible ? .5 : 1

            onClicked:  {
                accelPop.visible = !accelPop.visible
            }
                
            SliderPopup {
                id: accelPop
                x: parent.width + sideBarColumn.anchors.margins

                value: platformInterface.notifications.acceleration.value
                title: platformInterface.notifications.acceleration.caption
                unit: platformInterface.notifications.acceleration.unit
                to: platformInterface.notifications.acceleration.scales.index_0
                from: platformInterface.notifications.acceleration.scales.index_1
                stepSize: platformInterface.notifications.acceleration.scales.index_2
                // states
                // enabled: runButton.running === false //  direction control disabled when motor running
                // opacity: enabled ? 1 : .5

                onUserSet: {
                    console.log("onUserSet:", value)
                    platformInterface.commands.acceleration.update(
                        accelPop.value
                    )
                }
                
            }
        }

        // ------------------------ Motor Run, Brake, and Direction Buttons ------------------------ //

        // Run
        IconButton {
            id: runButton
            source: running ? "qrc:/images/stop-solid.svg" : "qrc:/images/play-solid.svg"
            iconColor: running ? "#db0909" : "#45e03a"
            toolTipText: "Start/stop motor"

            property bool running: false

            onClicked:  {
                running = !running
                console.log("onClicked:", running)
                platformInterface.commands.run.update(
                    Number(running)
                )
            }
        }

        // Brake
        IconButton {
            // TODO: test and enable brake
            id: brakeButton
            source: "qrc:/images/brake.svg"
            toolTipText: "Set brake"
        
            onClicked:  {
                // braking logic here
           }
        }

        // Direction
        IconButton {
            id: directionButton
            enabled: runButton.running === false //  direction control disabled when motor running
            opacity: enabled ? 1 : .5
            source: direction ? "qrc:/images/redo-alt-solid.svg" : "qrc:/images/undo.svg"
            toolTipText: "Set motor direction"
            animationRunning: runButton.running
            animationDirection: direction ? RotationAnimator.Clockwise : RotationAnimator.Counterclockwise

            property bool direction: true

            onClicked:  {
                direction = !direction
                console.log("onClicked:", direction)
                platformInterface.commands.direction.update(
                    Number(direction)
                )
            }
        }

        // ------------------------ Column Sidebar Filler ------------------------ //

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        // ------------------------ Warnings ------------------------ //

        ColumnLayout {
            spacing: 8

            FaultLight {
                text: platformInterface.notifications.warning_1.caption
                toolTipText: platformInterface.notifications.warning_1.caption
                status: {
                    if (platformInterface.notifications.warning_1.value) {
                        status: SGStatusLight.Red
                    } else {
                        SGStatusLight.Off
                    }
                }
            }

            FaultLight {
                text: platformInterface.notifications.warning_2.caption
                toolTipText: platformInterface.notifications.warning_2.caption
                status: {
                    if (platformInterface.notifications.warning_2.value) {
                        status: SGStatusLight.Red
                    } else {
                        SGStatusLight.Off
                    }
                }
            }

            FaultLight {
                text: platformInterface.notifications.warning_3.caption
                toolTipText: platformInterface.notifications.warning_3.caption
                status: {
                    if (platformInterface.notifications.warning_3.value) {
                        status: SGStatusLight.Red
                    } else {
                        SGStatusLight.Off
                    }
                }
            }
        }

        // ------------------------ Column Sidebar Filler ------------------------ //

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        // ------------------------ Help Messages ------------------------ //

        // TODO: test and enable help messages

        IconButton {
            id: helpIcon
            source: "qrc:/sgimages/question-circle.svg" // generic icon from SGWidgets

            onClicked:  {
                // start different help tours depending on which view is visible
                switch (navTabs.currentIndex) {
                case 0:
                    Help.startHelpTour("BasicControlHelp")
                    return
                case 1:
                    Help.startHelpTour("AdvancedControlHelp")
                    return
                }
            }
        }
    }
}
