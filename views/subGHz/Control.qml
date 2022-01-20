/*
 * Copyright (c) 2018-2022 onsemi.
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
import "views"

Item {
    id: controlView
    objectName: "control"
    anchors { fill: parent }

    PlatformInterface {
        id: platformInterface
    }

    property bool basicControlIsVisible: true
    property bool advancedControlIsVisible: false

    Item {
        id: controlContainer
        anchors {
            top: controlView.top
            bottom: controlView.bottom
            right: controlView.right
            left: controlView.left
        }

        BasicControl {
            id: basicControl
            visible: true
            property real initialAspectRatio
        }


    }

    Component.onCompleted: {
        basicControl.initialAspectRatio = controlContainer.width / controlContainer.height

        //console.log("Requesting platform Refresh")
        //platformInterface.refresh.send() //ask the platform for all the current values

        //console.log("Enabling periodic notifications")
        //platformInterface.enable_power_telemetry.update(true);

    }
}
