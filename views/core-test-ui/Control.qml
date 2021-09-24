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
import QtQuick.Controls 2.12
import "control-views"

Item {
    id: controlNavigation
    anchors.fill: parent

    property alias class_id: basic.class_id
    property alias user_id : basic.user_id
    property alias first_name : basic.first_name
    property alias last_name : basic.last_name

    BasicControl {
        id: basic
    }
}
