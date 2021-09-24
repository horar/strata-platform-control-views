/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import "sgwidgets"
import "./views"

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
            top: controlView.top
            left: controlView.left
            right: controlView.right
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

    Item {
        id: controlContainer
        anchors {
            top: navTabs.bottom
            bottom: controlView.bottom
            right: controlView.right
            left: controlView.left
        }

        BasicControl {
            id: basicControl
            visible: true
            property real initialAspectRatio
        }

        AdvancedControl {
            id: advancedControl
            visible: false
            property real initialAspectRatio
        }
    }

    Component.onCompleted: {
        advancedControl.initialAspectRatio = basicControl.initialAspectRatio = controlContainer.width / controlContainer.height

        console.log("Requesting platform Refresh")
        platformInterface.refresh.send() //ask the platform for all the current values

    }
}
