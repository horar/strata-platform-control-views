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
import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0
import "qrc:/js/navigation_control.js" as NavigationControl
import "control-views"
import "qrc:/js/help_layout_manager.js" as Help


Item {
    id: controlNavigation
    anchors {
        fill: parent
    }
    property alias class_id: basicControl.class_id

    PlatformInterface {
        id: platformInterface
    }

    BasicControl {
        id: basicControl
        visible: true
    }


    SGIcon {
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
                if(basicControl.visible === true) {
                    Help.startHelpTour("basicFan65Help")
                }

                else console.log("help not available")
            }
            hoverEnabled: true
        }
    }
}
