import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "qrc:/js/help_layout_manager.js" as Help

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Rectangle {
    id: controlRoot
    anchors {
        fill: parent
    }
    color: "light gray"

    BasicControl {
        id: basic
    }

    PlatformInterface {
        id: platformInterface
    }

    SGIcon {
        id: helpIcon
        anchors {
            right: basic.right
            top: parent.top
            margins: 10
        }
        source: "qrc:/sgimages/question-circle.svg"
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
                    Help.startHelpTour("ncs322100Help")
                } else {
                    console.log("help not available")
                }
            }
            hoverEnabled: true
        }
    }

    SGButton {
        id: debugButton
        text: "Debug"
        onClicked: {
            debugMenu.visible = !debugMenu.visible
        }
        anchors {
            right: basic.right
            bottom: basic.bottom
            bottomMargin: 10
        }
    }

    DebugMenu {
        id: debugMenu
        visible: false
        // See description in control-views/DebugMenu.qml
        anchors {
            right: debugButton.left
            bottom: basic.bottom
        }
    }


}
