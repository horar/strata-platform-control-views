/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.10
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import tech.strata.sgwidgets 0.9 as Widget09
import "../views/advanced views"

Widget09.SGResponsiveScrollView {
    id: root

    minimumHeight: 900
    minimumWidth: 1300
    scrollBarColor: hightlightColor

    property string borderColor: "#002C74"
    property string backgroundColor: "white"
    property string hightlightColor: "#F8BB2C"

    Rectangle {
        id: container
        parent: root.contentItem
        color:borderColor
        anchors {
            fill: parent
        }

        Rectangle{
            id:deviceBackground
            color:backgroundColor
            radius:10
            height:(7*parent.height)/16
            anchors.left:parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.top:parent.top
            anchors.topMargin: 12
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 12
        }

        Row{
            id:topRow
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20


            TelemetryView{
                id:telemetryView
                width:400
                height:400
            }
            BatteryView{
                id:batteryView
                width:300
                height:400
            }
            AudioPowerView{
                id:audioPowerView
                width:400
                height:400
            }

        }
        Row{
            id:bottomRow
            anchors.top: topRow.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            ChargerView{
                id:chargerView
                width:500
                height:350
            }
            LEDView{
                id:ledView
                width:400
                height:350
            }




        }
    }
}

