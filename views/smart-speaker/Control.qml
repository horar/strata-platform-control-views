/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
//import QtQuick.Window 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "views"

Item {
    id: controlView
    objectName: "control"
    anchors { fill: parent }

    PlatformInterface {
        id: platformInterface
    }

    TabBar {
        id: navTabs
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        TabButton {
            id: basicButton
            text: qsTr("Basic")
            onClicked: {
                controlContainer.currentIndex = 0
            }
        }

        TabButton {
            id: advancedButton
            text: qsTr("Advanced")
            onClicked: {
                controlContainer.currentIndex = 1
            }
        }
    }

    StackLayout {
        id: controlContainer
        anchors {
            top: navTabs.bottom
            bottom: controlView.bottom
            right: controlView.right
            left: controlView.left
        }

        BasicControl {
            id: basic
        }

        AdvancedControl {
            id: advanced
        }
    }


    Component.onCompleted: {

        console.log("Requesting platform Refresh")
        platformInterface.refresh.send() //ask the platform for all the current values

        console.log("Enabling periodic notifications")
        platformInterface.enable_power_telemetry.update(true);

    }

        DebugMenu {
            // See description in control-views/DebugMenu.qml
            anchors {
                right: controlContainer.right
                bottom: controlContainer.bottom
            }
        }


}
