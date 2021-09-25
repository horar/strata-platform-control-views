/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
//import "qrc:/fonts"

Rectangle {
    id: root

    property real value: 0
    property real maximumValue: 100
    property real minimumValue: 0
    property color gaugeRearColor: "#ddd"
    property color centerColor: "black"
    property color outerColor: "#bbb"
    property color gaugeFrontColor1: Qt.rgba(0,.75,1,1)
    property color gaugeFrontColor2: gaugeFrontColor1
    property real tickmarkStepSize : 10
    property string unitLabel: "RPM"
    property string gaugeTitle: "speed"
    property int decimal: 0


    implicitWidth: 256
    implicitHeight: 256

    CircularGauge {
        id: gauge
        value: (root.value-root.minimumValue)/(root.maximumValue-root.minimumValue)*200 // Normalize incoming values against 200 tickmarks
        width: root.width > root.height ? root.height *.7 : root.width *.7
        height: root.height > root.width ? root.width *.7 : root.height *.7
        anchors {
            centerIn: parent
        }

        maximumValue: 200
        minimumValue: 0

        style : CircularGaugeStyle {
            id: gaugeStyle
            needle: null
            foreground: null
            tickmarkLabel: null
            tickmarkStepSize: 1
            minorTickmark: null
            tickmark: Rectangle {
                id: tickmarks
//                color: styleData.value > gauge.value ? root.gaugeRearColor : (styleData.value > gauge.value-1 ? "red" : "root.gaugeFrontColor")
                color: styleData.value >= gauge.value ? root.gaugeRearColor : lerpColor(root.gaugeFrontColor1, root.gaugeFrontColor2, styleData.value/gauge.maximumValue)
                width: gauge.width / 68.26
                height: gauge.width / 4.26
                antialiasing: true
            }
        }

        Text {
            id: gaugeValue
            text: root.value.toFixed(decimal)
            color: root.centerColor
            anchors { centerIn: parent }
            font.family: digital.name
            font.pixelSize: Math.min(gauge.width / 3, gauge.width/Math.max((root.maximumValue+ "").length, (root.minimumValue + "").length)) // Scale the gauge font based on what the largest or smallest number that might be displayed
            renderType: Text.NativeRendering
        }
        Text {
            id: gaugeLabel
            text: unitLabel
            color: root.centerColor
            anchors {
                top: gaugeValue.bottom
                topMargin: - gauge.width / 25.6
                horizontalCenter: gaugeValue.horizontalCenter

            }
            font.pixelSize: gauge.width / 10
        }

        Text {
            id: title
            text: gaugeTitle
            color: root.centerColor
            anchors {
                top:parent.bottom
                horizontalCenter: parent.horizontalCenter

            }
            horizontalAlignment: Text.AlignHCenter
            font.bold : true
        }

        CircularGauge {
            id: ticksBackground
            z: -1
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            minimumValue: root.minimumValue
            maximumValue: root.maximumValue

            style : CircularGaugeStyle {
                tickmarkStepSize: root.tickmarkStepSize
                id: gaugeStyle2
                needle: null
                foreground: null
                minorTickmark: null
                tickmarkInset: -ticksBackground.width / 34
                labelInset: -ticksBackground.width / (12.8 - Math.max((root.maximumValue+ "").length, (root.minimumValue + "").length))  // Base label distance from gauge center on max/minValue
                minimumValueAngle: -145.25
                maximumValueAngle: 145.25
                tickmarkLabel:  Text {
                    font.pixelSize: Math.max(1, outerRadius * 0.125)
                    text: styleData.value
                    color: root.outerColor
                    antialiasing: true
                }
                tickmark: Rectangle {
                    color: root.outerColor
                    width: gauge.width / 100
                    height: gauge.width / 30
                    antialiasing: true
                }
            }
        }
    }

    FontLoader {
        id: digital
        source: "fonts/digitalseven.ttf"
    }

    function lerpColor (color1, color2, x){
        if (Qt.colorEqual(color1, color2)){
            return color1;
        } else {
            return Qt.hsva(
                color1.hsvHue * (1 +  x) + color2.hsvHue * x,
                color1.hsvSaturation * (1 + x) + color2.hsvSaturation * x,
                color1.hsvValue * (1 + x) + color2.hsvValue * x, 1
                );
        }
    }
}

