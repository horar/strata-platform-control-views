/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    id: root
    property alias content: content.sourceComponent

    property bool showOn: false
    property bool reverseDirection: false
    property real radius: 5
    property color color: "#00ccee"

    onShowOnChanged: {
        showOn ? showAnimation.start() : hideAnimation.start()
    }
    opacity: 0
    visible: false

    implicitHeight: canvas.implicitHeight
    implicitWidth: canvas.implicitWidth

    z:50

    Canvas {
        id: canvas

        implicitWidth: content.childrenRect.width + 20
        implicitHeight: content.childrenRect.height + 30  // 30 because 10 padding*2 and 10 for pointer
        contextType: "2d"

        onPaint: {
            var context = getContext("2d")
            context.reset();
            context.beginPath();
            //        context.shadowColor = "#000"  // Broken in qml 5.x according to https://qmlbook.github.io/ch07/index.html
            //        context.shadowBlur = 3

            if (reverseDirection) {
                context.moveTo(radius, 10);
                context.lineTo(width / 2 + 5, 10);
                context.lineTo(width / 2 - 5, 0);
                context.lineTo(width / 2 - 5, 10);
                context.lineTo(width - radius, 10);
                context.arcTo(width, 10, width, height - radius, radius);
                context.lineTo(width, height - radius);
                context.arcTo(width, height, width - radius, height, radius);
                context.lineTo(radius, height);
                context.arcTo(0, height, 0, height - radius, radius);
                context.lineTo(0, radius + 10);
                context.arcTo(0, 10, radius, 10, radius);
            } else {
                context.moveTo(radius, 0);
                context.lineTo(width - radius, 0);
                context.arcTo(width, 0, width, height - radius, radius);
                context.lineTo(width, height - 10 - radius);
                context.arcTo(width, height - 10, width - radius, height - 10, radius);
                context.lineTo(width / 2 + 5, height - 10);
                context.lineTo(width / 2 - 5, height);
                context.lineTo(width / 2 - 5, height - 10);
                context.lineTo(radius, height - 10);
                context.arcTo(0, height - 10, 0, height - 10 -radius, radius);
                context.lineTo(0, radius);
                context.arcTo(0, 0, radius, 0, radius);
            }
            context.closePath();
            context.fillStyle = root.color;
            context.fill();
        }

        Loader {
            id: content
            anchors {
                centerIn: canvas
                verticalCenterOffset: reverseDirection ? 5 : -5  // To compensate for pointer
            }
        }
    }

    PropertyAnimation {
        id: showAnimation
        onStarted: root.visible = true
        target: root; properties: "opacity"; from: root.opacity; to: 1; duration: 200
    }

    PropertyAnimation {
        id: hideAnimation
        onStopped: root.visible = false
        target: root; properties: "opacity"; from: root.opacity; to: 0; duration: 100
    }

    DropShadow {
        anchors.fill: canvas
        horizontalOffset: 1.5
        verticalOffset: 1.5
        radius: 6.0
        samples: 13
        color: "#88000000"
        source: canvas
        visible: root.visible
        opacity: root.opacity
    }
}

