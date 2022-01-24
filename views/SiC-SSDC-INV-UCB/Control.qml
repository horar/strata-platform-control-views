/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import "qrc:/sgwidgets"
import "qrc:/image"
import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.fonts 1.0
import tech.strata.sgwidgets 0.9
import tech.strata.sgwidgets 1.0 as Widget10

Rectangle {
    id: controlNavigation
    objectName: "control"
    width: parent.width - 70
    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 70
    anchors.top:parent.top

    anchors.fill: parent

    property alias class_id: multiplePlatform.class_id
    property bool dpt: sideBar.dpt
    property var motor_play: basicControl.motor_play

    PlatformInterface {
        id: platformInterface
    }

    MultiplePlatform{
        id: multiplePlatform
    }

    Component.onCompleted: {
        helpIcon.visible = true
        platformInterface.pause_periodic.update(false)
    }

    Component.onDestruction:  {
        platformInterface.pause_periodic.update(true)
    }

    ApplicationWindow {
        id: window
        width: 500
        height: 100
        visible: true

        SGButton {
            text: "Please check settings before enable"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            font.pixelSize: 20
            onClicked: window.close()
        }
    }

    TabBar {
        id: navTabs
        anchors {
            top: controlNavigation.top
            left: controlNavigation.left
            right: controlNavigation.right
        }

        //position : dpt ? TabBar.Footer : TabBar.Header

        TabButton {
            id: basicButton
            enabled: dpt ? false : true
            opacity: !dpt ? 1 : 0
            text: if (dpt === false){qsTr("Basic MDK")} else {}
        }

        TabButton {
            id: advancedButton
            enabled: dpt ? false : true
            opacity: !dpt ? 1 : 0
            text: if (dpt === false){qsTr("Advanced MDK")} else {}
        }

        TabButton {
            id: settingsButton
            enabled: dpt ? false : true
            opacity: !dpt ? 1 : 0
            text: if (dpt === false){qsTr("MDK Settings")} else {}
        }

        TabButton {
            id: exportButton
            enabled: dpt ? false : true
            opacity: !dpt ? 1 : 0
            text: if (dpt === false){qsTr("MDK Data Logger / Export")} else {}
        }

        TabButton {
            id: generalButton
            enabled: true
            opacity: 1
            text: "Default settings"
        }

        TabButton {
            id: pulseButton
            enabled: (dpt === false || motor_play === 1 ) ? false : true
            opacity: dpt ? 1 : 0
            text: if (dpt === true && motor_play === 0 ){qsTr("Pulse Testing")} else {}
        }
    }

    StackLayout {
        id: controlContainer
        anchors {
            top: navTabs.bottom
            bottom: controlNavigation.bottom
            right: controlNavigation.right
            left: controlNavigation.left

        }

        currentIndex: navTabs.currentIndex

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"

            BasicControl {
                id: basicControl
                visible: dpt ? false : true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"

            AdvancedControl {
                id: advancedControl
                visible: dpt ? false : true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"

            SettingsControl {
                id: settingsControl
                visible: dpt ? false : true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"

            ExportControl {
                id: exportControl
                visible: dpt ? false : true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"

            GeneralInputs {
                id: generalControl
                visible: true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "white"

            PulseControl {
                id: pulseControl
                visible: (dpt === false || motor_play === 1 ) ? false : true
                width: parent.width
                height: parent.height
            }
        }

    }

    Widget10.SGIcon {
        id: helpIcon
        anchors {
            right: parent.right
            rightMargin: parent.width/300
            top: parent.top
            topMargin: 50
        }
        source: "qrc:/sgimages/question-circle.svg"
        iconColor: helpMouse.containsMouse ? "lightgrey" : "grey"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: helpMouse
            anchors {
                fill: helpIcon
            }
            onClicked: {
                if(basicControl.visible === true) {Help.startHelpTour("basicHelp")}
                else if(advancedControl.visible === true) {Help.startHelpTour("advanceHelp")}
                else if(settingsControl.visible === true) {Help.startHelpTour("settingsHelp")}
                else if(exportControl.visible === true) {Help.startHelpTour("exportControlHelp")}
                else if(generalControl.visible === true) {Help.startHelpTour("generalControlHelp")}
                else if(pulseControl.visible === true) {Help.startHelpTour("pulseControlHelp")}
                else console.log("help not available")
            }
            hoverEnabled: true
        }
    }

    Rectangle{
        id: drawer
        width: 70
        height: parent.height
        anchors {
            left: parent.left
            leftMargin: -70
            top: parent.top
        }
        color: "#454545"
    }

        SideBar {
        id: sideBar
        anchors {
            left: parent.left
            leftMargin: -70
            top: parent.top
        }
    }
}


