/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias value: rgbSlider.value
    property var rgbArray: hToRgb(value)
    property string color: "red"
    property int color_value: 255
    property string label: ""
    property bool labelLeft: true
    property color textColor : "black"
    property real sliderHeight: 28

    implicitHeight: labelLeft ? Math.max(labelText.height, sliderHeight) : labelText.height + sliderHeight + rgbSlider.anchors.topMargin
    implicitWidth: 450

    Text {
        id: labelText
        text: root.label
        width: contentWidth
        height: root.label === "" ? 0 : root.labelLeft ? rgbSlider.height : contentHeight
        topPadding: root.label === "" ? 0 : root.labelLeft ? (rgbSlider.height-contentHeight)/2 : 0
        bottomPadding: topPadding
        color: root.textColor
    }

    Slider {
        id: rgbSlider
        padding: 0
        value: 0
        height: root.sliderHeight
        anchors {
            left: root.labelLeft ? labelText.right : labelText.left
            top: root.labelLeft ? labelText.top : labelText.bottom
            leftMargin: root.label === "" ? 0 : root.labelLeft ? 10 : 0
            topMargin: root.label === "" ? 0 : root.labelLeft ? 0 : 5
            right: root.right
        }
        live: false

        background: Rectangle {
            y: 4
            x: 5
            width: rgbSlider.width-10
            height: rgbSlider.height-8
            radius: 5
            layer.enabled: true
            layer.effect: LinearGradient {
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.hsva(0.0,1,1,1) }
                    GradientStop { position: 0.3333; color: Qt.hsva(0.0,1,0,1) }
                    GradientStop { position: 0.3334; color: Qt.hsva(0.3333,1,1,1) }
                    GradientStop { position: 0.6667; color: Qt.hsva(0.3333,1,0,1) }
                    GradientStop { position: 0.6668; color: Qt.hsva(0.6667,1,1,1) }
                    GradientStop { position: 1.0; color: Qt.hsva(0.6667,1,0,1) }
                }
            }
        }

        handle: Item {
            x: rgbSlider.leftPadding + rgbSlider.visualPosition * (rgbSlider.availableWidth - width)
            y: 0
            width: 12
            height: sliderHeight

            Canvas {
                z:50
                visible: true
                implicitWidth: parent.width
                implicitHeight: parent.height
                contextType: "2d"

                onPaint: {
                    context.reset();
                    context.lineWidth = 1
                    context.strokeStyle = "#888"
                    context.fillStyle = "#eee";

                    context.beginPath();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width, 7);
                    context.lineTo(width/2, 12);
                    context.lineTo(0, 7);
                    context.lineTo(0, 0);

                    context.moveTo(0, height);
                    context.lineTo(width, height);
                    context.lineTo(width, height-7);
                    context.lineTo(width/2, height-12);
                    context.lineTo(0, height-7);
                    context.closePath();
                    context.fill();
                    context.stroke();
                }
            }
        }
    }

    onValueChanged: {
        root.rgbArray = hToRgb(root.value)
        if (rgbArray[0] !== '0') {
            color = "red"
            color_value = rgbArray[0]
        } else if (rgbArray[1] !== '0') {
            color = "green"
            color_value = rgbArray[1]
        } else {
            color = "blue"
            color_value = rgbArray[2]
        }
   }

    // Dumbed down version of hsvToRgb function to match simpler RGB gradient slider
    function hToRgb(h){
        var r, g, b;

        var i = Math.floor(h * 3);
        var f = h * 3 - i;
        var q = 1 - f;
        if (i < 3){
            switch(i % 3){
                case 0: r = q; g = 0; b = 0; break;
                case 1: r = 0; g = q; b = 0; break;
                case 2: r = 0; g = 0; b = q; break;
            }
        } else {
            r = 0; g = 0; b = 0;
        }

        return [(r * 255).toFixed(0), (g * 255).toFixed(0), (b * 255).toFixed(0)];
    }

}
