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
    //Layout.fillHeight: true

    property var error_status: platformInterface.error.value
    property var dc_link_vin_calc: platformInterface.status_vi.l/1000
    property var temp_calc: platformInterface.status_temperature_sensor.temperature

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
                to: settingsControl.max_motor_speed
                value: 0
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
                to: settingsControl.max_motor_speed
                value: 0
            }
        }

        IconButton {
            id: brakeButton
            source: "qrc:/image/brake.svg"
            toolTipText: "Set motor brake de-acceleration"
            value: brakePop.value
            unit: "RPM/s"
            onClicked:  {
                // braking logic here
                brakePop.visible = !brakePop.visible
            }
            SliderPopup {
                id: brakePop
                x: parent.width + sideBarColumn.anchors.margins
                title: "Brake"
                unit: "RPM/s"
                from: 0
                to: settingsControl.max_motor_speed
                value: 0
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
                if (forward == true) {platformInterface.set_direction.update("clockwise")}
                else{platformInterface.set_direction.update("counterClockwise")}
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
                if (basicControl.motor_play === 1){
                    if (running == true) {settingsControl.play()}
                    else{settingsControl.stop()}
                }
                else{settingsControl.stop()}
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
                text: "ERROR"
                toolTipText: "ERROR MESSAGES"
                status: {
                    if(error_status === 0){SGStatusLight.Green}
                    else {SGStatusLight.Off}
                }
            }
/*
            FaultLight {
                text: "ADC THR"
                toolTipText: "ADC THRESHOLD OUTSIDERANGE"
                status: {
                    if(error_status === 1){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            FaultLight {
                text: "SCI 1"
                toolTipText: "STARTUP CURRENT INJECTION ERROR"
                status: {
                    if(error_status === 2){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            FaultLight {
                text: "SCI 2"
                toolTipText: "STARTUP CURRENT INJECTION2 ERROR"
                status: {
                    if(error_status === 3){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            FaultLight {
                text: "ADC INT"
                toolTipText: "ADC INTERRUPT LOOP"
                status: {
                    if(error_status === 4){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }
*/
            FaultLight {
                text: "OCP"
                toolTipText: "OVERCURRENT PROTECTION ACTIVE"
                status: {
                    if(error_status === 5){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            FaultLight {
                text: "OVP"
                toolTipText: "OVER VOLTAGE PROTECTION"
                status: {
                    if(multiplePlatform.nominalVin < dc_link_vin_calc){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            FaultLight {
                text: "UVP"
                toolTipText: "UNDER VOLTAGE PROTECTION"
                status: {
                    if(multiplePlatform.minVin > dc_link_vin_calc){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            FaultLight {
                text: "OTP"
                toolTipText: "OVER TEMPERATURE PROTECTION"
                status: {
                    if(temp_calc > 100){SGStatusLight.Red}
                    else {SGStatusLight.Off}
                }
            }

            // add or remove more as needed
        }

        Item {
            // filler
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
/*
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
*/
        }
    }

