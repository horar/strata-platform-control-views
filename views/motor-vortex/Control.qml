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

import tech.strata.fonts 1.0
import tech.strata.sgwidgets 0.9

Rectangle {
    id: controlNavigation
    anchors {
        fill: parent
    }

    PlatformInterface {
        id: platformInterface
    }

    Component.onCompleted: {
        helpIcon.visible = true
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
                helpIcon.visible = true
                controlContainer.currentIndex = 0
            }
        }

        TabButton {
            id: advancedButton
            text: qsTr("Advanced")
            onClicked: {
                helpIcon.visible = true

                controlContainer.currentIndex = 1
            }
        }

        TabButton {
            id: faeButton
            text: qsTr("FAE Only")
            onClicked: {
                helpIcon.visible = false
                controlContainer.currentIndex = 2
            }
            background: Rectangle {
                color: faeButton.down ? "#eeeeee" : faeButton.checked ? "white" : "tomato"
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors {
            top: navTabs.bottom
            bottom: controlNavigation.bottom
            right: controlNavigation.right
            left: controlNavigation.left
        }

        onWidthChanged: {
            if (width < 1200) {
                ScrollBar.horizontal.policy = ScrollBar.AlwaysOn
            } else {
                ScrollBar.horizontal.policy = ScrollBar.AlwaysOff
            }
        }

        onHeightChanged: {
            if (height < 725) {
                ScrollBar.vertical.policy = ScrollBar.AlwaysOn
            } else {
                ScrollBar.vertical.policy = ScrollBar.AlwaysOff
            }
        }

        Flickable {
            id: controlContainer
            property int currentIndex: 0

            onCurrentIndexChanged: {
                switch (currentIndex){
                case 0:
                    basicView.visible = true
                    advanceView.visible = false
                    faeView.visible = false
                    break;
                case 1:
                    basicView.visible = false
                    advanceView.visible = true
                    faeView.visible = false
                    break;
                case 2:
                    basicView.visible = false
                    advanceView.visible = false
                    faeView.visible = true
                    break;
                }
            }

            boundsBehavior: Flickable.StopAtBounds
            contentWidth: 1200
            contentHeight: 725
            anchors {
                fill: scrollView
            }
            clip: true

            BasicControl {
                id: basicView
                visible: true
            }

            AdvancedControl {
                id: advanceView
                visible: false
                property alias basicView: basicView
            }

            FAEControl {
                id : faeView
                visible: false
                property alias basicView: basicView
            }
        }
    }

    SGIcon {
        id: helpIcon
        anchors {
            right: scrollView.right
            top: scrollView.top
            margins: 20
        }
        source: "images/icons/question-circle-solid.svg"
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
                if(basicView.visible === true) {
                    Help.startHelpTour("basicViewHelp")
                }
                else if(advanceView.visible === true) {
                    Help.startHelpTour("advanceViewHelp")
                }
                else console.log("help not available")
            }
            hoverEnabled: true
        }
    }
}
