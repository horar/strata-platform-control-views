/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

import tech.strata.sgwidgets 0.9
import "control-views"

SGResponsiveScrollView {
    id: root

    property alias currentTab: tabs.currentIndex
    property real factor: Math.max(1,Math.min(root.height/root.minimumHeight,root.width/root.minimumWidth))

    onCurrentTabChanged: {
        tabBar.index = currentTab
    }

    Rectangle {
        id: container
        anchors.fill: parent

        parent: root.contentItem

        MouseArea { // to remove focus in input box when click outside
            anchors.fill: parent

            preventStealing: true

            onClicked: focus = true
        }

        SGSegmentedButtonStrip {
            id: tabBar
            anchors.horizontalCenter: parent.horizontalCenter

            radius: 4
            buttonHeight: 30*factor
            visible: true

            segmentedButtons: GridLayout {
                columnSpacing: 1
                SGSegmentedButton {
                    id: tab0
                    text: qsTr("Pot to ADC")
                    checked: true
                    onClicked: {
                        tabs.currentIndex = 0
                    }
                }
                SGSegmentedButton {
                    id: tab1
                    text: qsTr("DAC and PWM to LED")
                    onClicked: {
                        tabs.currentIndex = 1
                    }
                }
                SGSegmentedButton {
                    id: tab2
                    text: qsTr("PWM Motor Control")
                    onClicked: {
                        tabs.currentIndex = 2
                    }
                }
                SGSegmentedButton {
                    id: tab3
                    text: qsTr("Temp Sensor")
                    onClicked: {
                        tabs.currentIndex = 3
                    }
                }
                SGSegmentedButton {
                    id: tab4
                    text: qsTr("Light Sensor")
                    onClicked: {
                        tabs.currentIndex = 4
                    }
                }
                SGSegmentedButton {
                    id: tab5
                    text: qsTr("PWM to Filters")
                    onClicked: {
                        tabs.currentIndex = 5
                    }
                }
                SGSegmentedButton {
                    id: tab6
                    text: qsTr("LED Driver")
                    onClicked: {
                        tabs.currentIndex = 6
                    }
                }
                SGSegmentedButton {
                    id: tab7
                    text: qsTr("Buttons/Interrupts")
                    onClicked: {
                        tabs.currentIndex = 7
                    }
                }
            }
        }

        Item {
            id: content
            height: parent.height - tabBar.height
            width: parent.width
            anchors {
                top: tabBar.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            StackLayout {
                id: tabs
                anchors.fill: parent

                PotentiometerToADCControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }

                DACAndPWMToLEDControl {
                    minimumHeight: (root.minimumHeight - 50)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }

                PWMMotorControlControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }

                PWMHeatGeneratorAndTempSensorControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }

                LightSensorControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }

                PWMToFiltersControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true

                }

                LEDDriverControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }

                MechanicalButtonsToInterruptsControl {
                    minimumHeight: (root.minimumHeight - 30)/2
                    minimumWidth: root.minimumWidth/2
                    Layout.preferredHeight: Math.min(parent.height, this.minimumHeight/this.minimumWidth*parent.width)
                    Layout.preferredWidth: Math.min(parent.width, parent.height/(this.minimumHeight/this.minimumWidth))

                    hideHeader: true
                }
            }
        }
    }
}
