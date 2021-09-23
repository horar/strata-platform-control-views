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
//import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help

RadioButton{
    id: radioButton
    style: RadioButtonStyle {
        indicator: Rectangle {
            implicitWidth: 16
            implicitHeight: 16
            radius: 9
            width: 20
            height: 20
            border.color: control.activeFocus ? "darkblue" : "gray"
            border.width: 1

            Rectangle {
                anchors.fill: parent
                visible: control.checked
                color: "#555"
                radius: 9
                anchors.margins: 4
            }
        }
    }
}

