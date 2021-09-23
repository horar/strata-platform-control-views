/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Layouts 1.12

import tech.strata.sgwidgets 1.0
import tech.strata.sgwidgets 0.9 as Widget09

import "qrc:/js/help_layout_manager.js" as Help

Widget09.SGResponsiveScrollView {
    id: root

    minimumHeight: 800
    minimumWidth: 1000

    Rectangle {
        id: container
        parent: root.contentItem
        anchors {
            fill: parent
        }
        color: "#ADD"

        Text {
            id: name
            text: "Advanced Control View"
            font {
                pixelSize: 60
            }
            color:"white"
            anchors {
                centerIn: parent
            }
        }

        SGAlignedLabel {
            id: motorSwitchLabel
            target: motorSwitch
            text: "Motor On/Off"
            anchors {
                top: name.bottom
                horizontalCenter: name.horizontalCenter
            }
            alignment: SGAlignedLabel.SideTopCenter

            SGSwitch {
                id: motorSwitch
                width: 50

                // 'checked' state is bound to and sets the
                // _motor_running_control property in PlatformInterface
                //checked: platformInterface._motor_running_control
                //onCheckedChanged: platformInterface._motor_running_control = checked
            }
        }

        SGCircularGauge {
            id: speedGauge
            anchors {
                top: motorSwitchLabel.bottom
                horizontalCenter: name.horizontalCenter
            }
            height: 200
            width: 200

            //value: platformInterface._motor_speed
        }
    }
}



