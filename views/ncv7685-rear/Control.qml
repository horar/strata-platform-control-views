import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "control-views"
import "qrc:/js/help_layout_manager.js" as Help

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

/********************************************************************************************************
    This is my first Strata GUI in QML and it's the challenge for me as the firmware AE,
    The project is functional oriented, so maybe looks ugly.
    Your comments and mentoring is appreciated: Austin.Shang@onsemi.com
*********************************************************************************************************/

Item {
    id: controlNavigation
    anchors {
        fill: parent
    }

    PlatformInterface {
        id: platformInterface
    }



    TabBar {
        id: navTabs
        font {
            pixelSize: 30
            bold : true
        }

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        TabButton {
            id: demoButton
            KeyNavigation.right: this
            KeyNavigation.left: this
            text: qsTr("Animation Demo")
            onClicked: {
                controlContainer.currentIndex = 0
            }
        }

        TabButton {
            id: testButton
            KeyNavigation.right: this
            KeyNavigation.left: this
            text: qsTr("Customized Test")
            onClicked: {
                controlContainer.currentIndex = 1
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

        DemoControl {
            id: demo
        }

        TestControl {
            id: test
        }
    }

    SGIcon {
        id: helpIcon
        anchors {
            right: controlContainer.right
            rightMargin: 15
            top: controlContainer.top
            margins: 10
        }
        source: "qrc:/sgimages/question-circle.svg"
        iconColor: helpMouse.containsMouse ? "lightgrey" : "grey"
        height: 60
        width: 60

        MouseArea {
            id: helpMouse
            anchors {
                fill: helpIcon
            }
            onClicked: {
                // Make sure view is set to Basic before starting tour
                if(controlContainer.currentIndex === 0) {
                    Help.startHelpTour("AnimationPageHelp")
                }
                if(controlContainer.currentIndex === 1) {
                    Help.startHelpTour("TestPageHelp")
                }
            }
            hoverEnabled: true
        }
    }
}






