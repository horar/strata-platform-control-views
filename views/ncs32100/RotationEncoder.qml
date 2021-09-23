/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help

Image {
    id: rotatingBox
    fillMode: Image.PreserveAspectFit
    source: "RotaryEncoder.svg"
    property var angle: 0
    property var previousAngle: 0
    property alias rotation :  rotation
    z: -1

    RotationAnimator {
        id: rotation
        target: rotatingBox;
        from: previousAngle;
        to: angle;
        duration: 10
        running: false
        direction: RotationAnimator.Clockwise
    }
}
