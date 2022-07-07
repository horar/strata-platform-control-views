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
import "qrc:/images"
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

    PlatformInterface {
        id: platformInterface
    }

    MultiplePlatform{
        id: multiplePlatform
    }

    Component.onCompleted: {
        helpIcon.visible = true
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

        TabButton {
            id: basicButton
            text: qsTr("Basic")
            onClicked: {
                basicControl.visible = true
                advancedControl.visible = false
                exportControl.visible = false
            }
        }

        TabButton {
            id: advancedButton
            text: qsTr("Advanced")
            onClicked: {
                basicControl.visible = false
                advancedControl.visible = true
                exportControl.visible = false
            }
        }

        TabButton {
            id: exportButton
            text: qsTr("Data Logger / Export")
            onClicked: {
                basicControl.visible = false
                advancedControl.visible = false
                exportControl.visible = true
            }
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

            BasicControl {
                id: basicControl
                visible: true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "light gray"

            AdvancedControl {
                id: advancedControl
                visible: false
                width: parent.width
                height: parent.height

            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "light gray"

            ExportControl {
                id: exportControl
                visible: false
                width: parent.width
                height: parent.height
            }
        }

    }

    Widget10.SGIcon {
        id: helpIcon
        anchors {
            right: parent.right
            rightMargin: 20
            top: parent.top
            topMargin: 50
        }
        source: "qrc:/sgimages/question-circle.svg"
        iconColor: helpMouse.containsMouse ? "lightgrey" : "grey"
        height: 40
        width: 40
        visible: true

        MouseArea {
            id: helpMouse
            anchors {
                fill: helpIcon
            }
            onClicked: {
                if(basicControl.visible === true) {Help.startHelpTour("basicHelp")}
                else if(advancedControl.visible === true) {Help.startHelpTour("advanceHelp")}
                else if(exportControl.visible === true) {Help.startHelpTour("exportControlHelp")}
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
        id: sideBarLeft
        anchors {
            left: parent.left
            leftMargin: -70
            top: parent.top
        }
    }
}
