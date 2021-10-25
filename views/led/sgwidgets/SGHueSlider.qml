/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Controls 2.3

Item {
    id: root

    signal moved()
    signal userSet()

    property alias value: hueSlider.value
    property string color1: "green"
    property string color2: "blue"
    property int color_value1: 128
    property int color_value2: 128
    property string label: ""
    property bool labelLeft: true
    property color textColor : "black"
    property real sliderHeight: 28
    property var rgbArray: [0,0,0]
    property bool powerSave: true
    property string hexvalue: "#ffffff"

    property alias pressed: hueSlider.pressed



    implicitHeight: labelLeft ? Math.max(labelText.height, sliderHeight) : labelText.height + sliderHeight + hueSlider.anchors.topMargin
    implicitWidth: 450

    Text {
        id: labelText
        text: root.label
        width: contentWidth
        height: root.label === "" ? 0 : root.labelLeft ? hueSlider.height : contentHeight
        topPadding: root.label === "" ? 0 : root.labelLeft ? (hueSlider.height-contentHeight)/2 : 0
        bottomPadding: topPadding
        color: root.textColor
    }

    Slider {
        id: hueSlider
        padding: 0
        value: 128
        height: root.sliderHeight
        anchors {
            left: root.labelLeft ? labelText.right : labelText.left
            top: root.labelLeft ? labelText.top : labelText.bottom
            leftMargin: root.label === "" ? 0 : root.labelLeft ? 10 : 0
            topMargin: root.label === "" ? 0 : root.labelLeft ? 0 : 5
            right: root.right
        }
        live: false
        from: 0
        to: 255
        onMoved: root.moved()
        onPressedChanged: {
            if (!pressed) {
                root.userSet()
            }
        }

        Rectangle{
            id:focusRing
            anchors.left:parent.left
            anchors.top:parent.top
            anchors.topMargin:4
            anchors.right:parent.right
            anchors.bottom:parent.bottom
            anchors.bottomMargin:4
            border.width: hueSlider.activeFocus ? 2 : 0
            border.color:"green"
            radius:5
            color:"transparent"
        }

        Keys.onRightPressed:{
            //we've seen a bug caused by holding down the arrow key, so for the time being we're
            //throttling the rate this feature can send commands by turning off autorepeat.
            if (event.isAutoRepeat)
                return
            if (value < 255){
                value = value+1;
                updateColorValues();
                root.userSet()
            }
        }

        Keys.onLeftPressed:{
            //we've seen a bug caused by holding down the arrow key, so for the time being we're
            //throttling the rate this feature can send commands by turning off autorepeat.
            if (event.isAutoRepeat)
                return
            if (value > 0){
                value = value-1;
                updateColorValues();
                root.userSet()
            }
        }

        onActiveFocusChanged:{
            if (activeFocus)
                console.log("slider is now in focus");
            else
                console.log("slider is out of focus");
        }

        background: Rectangle {
            id:backgroundRectangle
            y: 4
            width: hueSlider.width
            height: hueSlider.height-8

            radius: 5
            gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.hsva(0.0,1,1,1) }
                    GradientStop { position: 0.1667; color: Qt.hsva(0.1667,1,1,1) }
                    GradientStop { position: 0.3333; color: Qt.hsva(0.3333,1,1,1) }
                    GradientStop { position: 0.5; color: Qt.hsva(0.5,1,1,1) }
                    GradientStop { position: 0.6667; color: Qt.hsva(0.6667,1,1,1) }
                    GradientStop { position: 0.8333; color: Qt.hsva(0.8333,1,1,1) }
                    GradientStop { position: 1.0; color: Qt.hsva(1.0,1,1,1) }
                }
            }

        handle: Item {
            x: hueSlider.leftPadding + hueSlider.visualPosition * (hueSlider.availableWidth - width)
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

        updateColorValues();
    }

    function updateColorValues(){

        if (powerSave) {
            rgbArray = hueToRgbPowerSave(value/255)
        } else {
            rgbArray = hsvToRgb(value/255, 1, 1)
        }

        if (rgbArray[0] === '0') {
            color1 = "green"
            color_value1 = rgbArray[1]
            color2 = "blue"
            color_value2 = rgbArray[2]
        } else if (rgbArray[1] === '0') {
            color1 = "blue"
            color_value1 = rgbArray[2]
            color2 = "red"
            color_value2 = rgbArray[0]
        } else {
            color1 = "red"
            color_value1 = rgbArray[0]
            color2 = "green"
            color_value2 = rgbArray[1]
        }

        //build the hex value for the color
        hexvalue ="#"

        var redColor = parseInt(rgbArray[0])
        var redhex = redColor.toString(16).toUpperCase();
        if (redhex.length % 2) {
          redhex = '0' + redhex;
        }
        hexvalue += redhex;     //concatanate

        var greenColor = parseInt(rgbArray[1])
        var greenhex = greenColor.toString(16).toUpperCase();
        if (greenhex.length % 2) {
          greenhex = '0' + greenhex;
        }
        hexvalue += greenhex;     //concatanate

        var blueColor = parseInt(rgbArray[2])
        var bluehex = blueColor.toString(16).toUpperCase();
        if (bluehex.length % 2) {
          bluehex = '0' + bluehex;
        }
        hexvalue += bluehex;     //concatanate
    }

    function hueToRgbPowerSave (h) {  // PowerSave mode for mixing 2 colors (max 255 value between 2 colors)
        var r, g, b;

        var i = Math.floor(h * 3);
        var f = h * 3 - i;

        switch(i % 3){
            case 0: r = 1-f; g = f; b = 0; break;
            case 1: r = 0; g = 1-f; b = f; break;
            case 2: r = f; g = 0; b = 1-f; break;
        }

        return [(r * 255).toFixed(0), (g * 255).toFixed(0), (b * 255).toFixed(0)];
    }

    function hsvToRgb(h, s, v){  // Regular RGB color mixing mode
        var r, g, b;

        var i = Math.floor(h * 6);
        var f = h * 6 - i;
        var p = v * (1 - s);
        var q = v * (1 - f * s);
        var t = v * (1 - (1 - f) * s);

        switch(i % 6){
            case 0: r = v; g = t; b = p; break;
            case 1: r = q; g = v; b = p; break;
            case 2: r = p; g = v; b = t; break;
            case 3: r = p; g = q; b = v; break;
            case 4: r = t; g = p; b = v; break;
            case 5: r = v; g = p; b = q; break;
        }

        return [(r * 255).toFixed(0), (g * 255).toFixed(0), (b * 255).toFixed(0)];
    }

}
