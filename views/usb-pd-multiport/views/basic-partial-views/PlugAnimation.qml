/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9

AnimatedImage {
    id: root
    property bool pluggedIn: false
    source: "../images/USBCAnim.gif"
    height: 81 * ratioCalc
    width: 319 * ratioCalc
    playing: false
    onCurrentFrameChanged: {
        if (currentFrame === frameCount-1) {
            playing = false
        }
    }

    Image {
        source: "../images/cordTermination.png"
        height: 19 * ratioCalc
        width: height
        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
            verticalCenterOffset: 17 * ratioCalc
        }
    }
}
