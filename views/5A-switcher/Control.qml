/*
 * Copyright (c) 2018-2021 onsemi.
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
import "qrc:/js/navigation_control.js" as NavigationControl
import "sgwidgets"
import "qrc:/js/help_layout_manager.js" as Help

Rectangle {
    id: controlNavigation
    objectName: "control"

    anchors {
        fill: parent
    }

    PlatformInterface {
        id: platformInterface
    }

    Component.onCompleted: {
        helpIcon.visible = true
        Help.registerTarget(navTabs, "Using these two tabs you can switch between basic or advance control.", 0,"basic5AHelp")
        //Tejashree: This is a HACK implementation
        // Windows Serial Mouse Issue fix
        platformInterface.pause_periodic.update(false)
    }
    //Tejashree: This is a HACK implementation
    // Windows Serial Mouse Issue fix
    Component.onDestruction:  {
        platformInterface.pause_periodic.update(true)
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
            }
        }

        TabButton {
            id: advancedButton
            text: qsTr("Advanced")
            onClicked: {
                basicControl.visible = false
                advancedControl.visible = true
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
    }

    SGIcon {
        id: helpIcon
        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
            topMargin: 50
        }
        source: "question-circle-solid.svg"
        iconColor: helpMouse.containsMouse ? "lightgrey" : "grey"
        sourceSize.height: 40
        visible: true

        MouseArea {
            id: helpMouse
            anchors {
                fill: helpIcon
            }
            onClicked: {


                if(basicControl.visible === true) {
                    Help.startHelpTour("basic5AHelp")
                }

                else if(advancedControl.visible === true) {
                    Help.startHelpTour("advance5AHelp")
                }
                else console.log("help not available")
            }
            hoverEnabled: true
        }
    }
}
