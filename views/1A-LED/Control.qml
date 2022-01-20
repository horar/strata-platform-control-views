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
import "control-views"
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.sgwidgets 0.9
import tech.strata.fonts 1.0

Item {
    id: controlNavigation
    anchors.fill: parent

    PlatformInterface {
        id: platformInterface
    }

    BasicControl {
        id: basic
        anchors.fill: parent
    }

    SGIcon {
        id: helpIcon
        anchors {
            right: basic.right
            top: parent.top
            margins: 10
        }
        source: "control-views/question-circle-solid.svg"
        iconColor: helpMouse.containsMouse ? "lightgrey" : "grey"
        height: 40
        width: 40

        MouseArea {
            id: helpMouse
            anchors {
                fill: helpIcon
            }
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if (basic.visible === true) {
                    Help.startHelpTour("1A-LEDHelp")
                } else console.log("help not available")
            }
            hoverEnabled: true
        }
    }
}
