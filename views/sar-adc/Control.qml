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
import "qrc:/js/help_layout_manager.js" as Help

Item {
    id: controlNavigation
    anchors.fill: parent
    PlatformInterface {
        id: platformInterface
    }

    StackLayout {
        id: controlContainer
        anchors {
           fill: parent
        }

        BasicControl {
            id: basic
        }
    }
}
