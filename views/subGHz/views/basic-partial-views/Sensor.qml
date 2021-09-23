/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.1
import QtQuick.Controls 2.5

Button{
    id:transmitter

    height:300
    width:250
    checkable:true

    property string sensorNumber:"0x001"

    //have the sensor cache the values for the main display, so we can update the main display when the
    //sensor is changed
    property int soilMoisture:{
        //console.log("sensor#=",platformInterface.receive_notification.sensor_id,"type=",platformInterface.receive_notification.sensor_type,"value=",platformInterface.receive_notification.data.soil.toFixed(0));
        if (platformInterface.receive_notification.sensor_id === sensorNumber){
            if (platformInterface.receive_notification.sensor_type === "multi_soil"){
                return platformInterface.receive_notification.data.soil.toFixed(0)
            }
            else{
                //return "N/A"      //what we want, but it causes a problem assigning a string to an IntValidator
                return 0
            }
        }
        else return soilMoisture;
    }

    property int pressure:{
        if (platformInterface.receive_notification.sensor_id === sensorNumber){
            return platformInterface.receive_notification.data.pressure.toFixed(0)
        }
        else{
            return pressure;       //keep the same number
        }
    }

    property int rssi:{
        if (platformInterface.receive_notification.sensor_id === sensorNumber){
            return platformInterface.receive_notification.rssi.toFixed(0)
        }
        else{
            return rssi;       //keep the same number
        }
    }

    property int temperature:{
        if (platformInterface.receive_notification.sensor_id === sensorNumber){
            return  platformInterface.receive_notification.data.temperature.toFixed(1)
        }
        else{
            return temperature;       //keep the same number
        }
    }

    property int humidity:{
        if (platformInterface.receive_notification.sensor_id === sensorNumber){
            return platformInterface.receive_notification.data.humidity.toFixed(0)
        }
        else{
            return humidity;       //keep the same number
        }
    }

    property alias title: transmitterName.text

    property alias color: backgroundRect.color
    signal transmitterNameChanged
    signal selected

    background: Rectangle {
        id:backgroundRect
            implicitHeight: 300
            implicitWidth: 250
            color:"slateGrey"
            border.color:"goldenrod"
            border.width:3
            radius: 30
            clip:true


            Rectangle{
                id:statsDivider
                height:1
                anchors.left: parent.left
                anchors.leftMargin:3
                anchors.right:parent.right
                anchors.rightMargin:3
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                color:"white"
            }

        }

    onCheckedChanged: {
        if (checked){
            backgroundRect.color = "green"
            transmitter.selected();
        }
         else{
            backgroundRect.color = "slateGrey"
        }
    }
    onDoubleClicked: {
        editor.visible = true;
    }

    Text{
        id:transmitterName
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -30
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 25
        text:"sensor 1"
        font.pixelSize:42
        color:"lightgrey"
    }

    Rectangle {
        id: editor
        anchors.fill: transmitterName
        visible: false
        color: "#0cf"


        TextInput {
            anchors.centerIn: editor
            text: transmitterName.text
            font.pixelSize:transmitterName.font.pixelSize
            onAccepted: {
                transmitterName.text = text;
                editor.visible = false;
                //send a signal with the new text
                transmitter.transmitterNameChanged();
            }
            onVisibleChanged: {
                if (visible) {
                    forceActiveFocus();
                    selectAll();
                }
            }
        }
    }

    SignalStrengthIndicator{
        id:bars
        height:45
        width: 45
        anchors.right: transmitter.right
        anchors.rightMargin:15
        anchors.bottom: transmitterName.bottom
        anchors.bottomMargin: 5
        sensorNumber: transmitter.sensorNumber
    }

    Row{
        id:telemetryRow
        height:25
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.right:parent.right
        anchors.rightMargin: 15
        anchors.bottom:parent.bottom

        //together each label and telemetry item should be .25 of the overall width
        property real labelWidth: .06*telemetryRow.width
        property real textWidth: .19*telemetryRow.width
        property int labelPixelSize: 12
        property int textPixelSize:17

        Label{
            id:temperatureLabel
            anchors.bottom:parent.bottom
            anchors.bottomMargin:5
            text:"T:"
            font.pixelSize: telemetryRow.labelPixelSize
            color:"white"
            opacity:.5
            width:telemetryRow.labelWidth
            }

        Label{
            id:temperatureText
            text:transmitter.temperature
            font.pixelSize:telemetryRow.textPixelSize
            color:"white"
            opacity:.5
            font.bold:true
            anchors.bottom:parent.bottom
            anchors.bottomMargin:3
            width:telemetryRow.textWidth
        }

        Label{
            id:rssiLabel
            anchors.bottom:parent.bottom
            anchors.bottomMargin:5
            width:telemetryRow.labelWidth
            text:"R:"
            font.pixelSize: telemetryRow.labelPixelSize
            color:"white"
            opacity:.5
            }

        Label{
            id:rssiText
            text:transmitter.rssi
            font.pixelSize:telemetryRow.textPixelSize
            color:"white"
            opacity:.5
            font.bold:true
            anchors.bottom:parent.bottom
            anchors.bottomMargin:3
            width:telemetryRow.textWidth
        }

        Label{
            id:pressureLabel
            anchors.bottom:parent.bottom
            anchors.bottomMargin:5
            width:telemetryRow.labelWidth
            text:"P:"
            font.pixelSize: telemetryRow.labelPixelSize
            color:"white"
            opacity:.5
            }

        Label{
            id:pressureText
            text:transmitter.pressure
            font.pixelSize:telemetryRow.textPixelSize
            color:"white"
            opacity:.5
            font.bold:true
            anchors.bottom:parent.bottom
            anchors.bottomMargin:3
            width:telemetryRow.textWidth
        }

        Label{
            id:humidityLabel
            anchors.bottom:parent.bottom
            anchors.bottomMargin:5
            text:"H:"
            font.pixelSize: telemetryRow.labelPixelSize
            color:"white"
            opacity:.5
            width:telemetryRow.labelWidth
            }

        Label{
            id:humidityText
            text:transmitter.humidity
            font.pixelSize:telemetryRow.textPixelSize
            color:"white"
            opacity:.5
            font.bold:true
            anchors.bottom:parent.bottom
            anchors.bottomMargin:3
            width:telemetryRow.textWidth
        }
    }




}
