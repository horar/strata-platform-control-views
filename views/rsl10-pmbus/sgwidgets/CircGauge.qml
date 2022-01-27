/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import tech.strata.sgwidgets 1.0

// custom implementation of SGCircularGauge that includes some title text under it

SGCircularGauge {
    id: circGauge
    property alias text: text.text
    property alias pixelSize: text.font.pixelSize

    SGText {
        id: text
        font.pixelSize: Math.min(parent.height *.085, parent.width *.085)
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        parent: circGauge.gaugeObject
        width: parent.width
        wrapMode: Text.Wrap

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.bottom
            topMargin: parent.height * .07
        }
    }
}
