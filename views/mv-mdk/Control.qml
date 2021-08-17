import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import tech.strata.sgwidgets 1.0
import "control-views"

Item {
    id: controlViewRoot
    property string class_id

    RowLayout {
        
        anchors.fill: parent
        spacing: 0

        PlatformInterface {
            id: platformInterface
        }

        SideBar {
            id: sideBar
        }

        ColumnLayout {
            spacing: 0

            TabBar {
                id: tabBar
                Layout.fillWidth: true

                TabButton {
                    text: "Basic"
                }

                TabButton {
                    text: "Controls and Parameters"
                }

            }

            StackLayout {
                currentIndex: tabBar.currentIndex

                Basic {
                    id: basic
                }

                ControlsParameters {
                    id: controlsParameters
                }
            }
        }        
    }

    // Large rectange around only the user interface
    Rectangle {
        color: "black"
        anchors.fill: parent
        opacity: 0.5
        visible: startup_fault.visible
        MouseArea {
            anchors.fill: parent
        }
    }

    // Rectange to hold popup message requiring user to restart Strata
    Rectangle {
        id: startup_fault
        width: parent.width / 3
        height: warningText.height + 20
        anchors.centerIn: parent
        focus: true
        radius: 10
        visible: false

        Text {
            id: warningText
            anchors.centerIn: startup_fault
            width: parent.width - 20
            text: "The connected device has been previously configured in another Strata session. Please follow the important startup and shutdown process to continue.\n\nShutdown\n1) disconnect USB cable\n2) remove main power supply input\n\nStartup\n1) apply main power supply input\n2) connect USB cable"
            font.pixelSize: 16
            color: "black"
            font.bold: false
            wrapMode: Text.Wrap
            
        }
        
    }

    // Startup fault error notification from firmware
    // {"notification":{"value":"startup_fault"}}
    Connections {
        target: platformInterface.notifications.startup_fault
        onNotificationFinished: {
            startup_fault.visible = true
        }
    }

}