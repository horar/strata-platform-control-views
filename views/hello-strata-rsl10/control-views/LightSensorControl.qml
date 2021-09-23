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
import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.sgwidgets 1.0

CustomControl {
    id: root
    title: qsTr("I2C Light Sensor")

    // UI state & notification
    property bool start: platformInterface.i2c_light_ui_start //Manual Integration
    property bool active: platformInterface.i2c_light_ui_active //status
    property string time: platformInterface.i2c_light_ui_time  //integ_time
    property string gain: platformInterface.i2c_light_ui_gain //Gain
    property real sensitivity: platformInterface.i2c_light_ui_sensitivity //Sensitivity
    property var lux: platformInterface.light_lux.value

    Component.onCompleted: {
        if (hideHeader) {
            Help.registerTarget(activeswLabel, "This switch will activate the light sensor or put it to sleep mode.", 0, "helloStrata_LightSensor_Help")
            Help.registerTarget(startswLabel, "When integration time is set to \"Manual\", start the integration by switching from stop to start and stop the integration by switching from start to stop. The lux value will be updated only when manual integration is stopped.", 1, "helloStrata_LightSensor_Help")
            Help.registerTarget(gainboxLabel, "This combobox will set the gain factor.", 2, "helloStrata_LightSensor_Help")
            Help.registerTarget(timeboxLabel, "This combobox will set the integration time. While \"Manual\" is selected, toggle the \"Manual Integration\" switch to set the integration time.", 3, "helloStrata_LightSensor_Help")
            Help.registerTarget(sgsliderLabel, "This slider will set the sensitivity of the sensor.", 4, "helloStrata_LightSensor_Help")
        }
    }

    onStartChanged: {
        startsw.checked = start
    }

    onActiveChanged: {
        activesw.checked = active
    }

    onTimeChanged: {
        timebox.currentIndex = timebox.model.indexOf(time)
    }

    onGainChanged: {
        gainbox.currentIndex = gainbox.model.indexOf(gain)
    }

    onSensitivityChanged: {
        sgslider.value = sensitivity
    }

    onLuxChanged: {
        gauge.value = lux
    }


    //Control enable

    property var light_sensor_enable: platformInterface.light_sensor.available
    onLight_sensor_enableChanged: {
        if(light_sensor_enable === true) {
            lightSensorEnablePopUp.visible = false
            content.enabled = true
        }
        else {
            lightSensorEnablePopUp.visible = true
            content.enabled = false
        }
    }
    property var light_ctl_enable_status: platformInterface.light_ctl_enable.status
    onLight_ctl_enable_statusChanged: {
        if(light_ctl_enable_status === true) {
            startsw.enabled = true
            startsw.opacity = 1.0
        }
        else  {

            startsw.enabled = false
            startsw.opacity = 0.5
        }
    }

    property var light_ctl_enable_sensitivity: platformInterface.light_ctl_enable.sensitivity
    onLight_ctl_enable_sensitivityChanged: {
        if(light_ctl_enable_sensitivity === true) {
            sgslider.enabled = true
            sgslider.opacity = 1.0
        }
        else  {
            sgslider.enabled = false
            sgslider.opacity = 0.5
        }
    }


    property var light_ctl_enable_gain: platformInterface.light_ctl_enable.gain
    onLight_ctl_enable_gainChanged: {
        if(light_ctl_enable_gain === true) {
            gainbox.enabled = true
            gainbox.opacity = 1.0
        }
        else  {
            gainbox.enabled = false
            gainbox.opacity = 0.5
        }
    }


    property var light_ctl_enable_integ_time: platformInterface.light_ctl_enable.integ_time
    onLight_ctl_enable_integ_timeChanged: {
        if(light_ctl_enable_integ_time === true) {
            timebox.enabled = true
            timebox.opacity = 1.0
        }
        else  {
            timebox.enabled = false
            timebox.opacity = 0.5
        }
    }

    property var light_ctl_enable_manual_integ: platformInterface.light_ctl_enable.manual_integ
    onLight_ctl_enable_manual_integChanged: {
        if(light_ctl_enable_manual_integ === true) {
            startswLabel.enabled = true
            startswLabel.opacity = 1.0
        }
        else  {
            startswLabel.enabled = false
            startswLabel.opacity = 0.5
        }
    }

    Rectangle {
        id: lightSensorEnablePopUp
        width: parent.width
        height: parent.height
        color: "#a9a9a9"
        opacity: 0.8
        visible: false
        z: 3

        Rectangle {
            width: enablePopUpText.contentWidth
            height: enablePopUpText.contentHeight
            z: 4
            anchors.centerIn: parent
            color: "transparent"
            Text {
                id: enablePopUpText
                z:5
                anchors.fill:parent
                font.family: "Helvetica"
                font.pixelSize: {
                    if(lightSensorEnablePopUp.width < 500)
                        return lightSensorEnablePopUp.width/10
                    else {
                        return lightSensorEnablePopUp.width/17
                    }
                }
                text:  qsTr("Not Available")
                color: "white"
            }
        }
    }

    contentItem: RowLayout {
        id: content
        anchors.fill:parent

        GridLayout {
            columns: 2
            rows: 3
            rowSpacing: 10 * factor
            columnSpacing: 10 * factor

            SGAlignedLabel {
                id: sgsliderLabel
                Layout.columnSpan: 2

                target: sgslider
                text:"<b>" + qsTr("Sensitivity (%)") + "</b>"
                fontSizeMultiplier: factor
                CustomSlider {
                    id: sgslider
                    width: content.parent.maximumWidth * 0.5
                    textColor: "black"
                    stepSize: 0.1
                    from: 66.7
                    to: 150
                    live: false
                    fromText.text: "66.7%"
                    toText.text: "150%"
                    inputBox.validator: DoubleValidator { top: 150; bottom: 66.7 }
                    fontSizeMultiplier: factor
                    onUserSet: {
                        platformInterface.i2c_light_ui_sensitivity = value
                        platformInterface.i2c_light_set_sensitivity.update(value)
                    }
                }
            }

            SGAlignedLabel {
                id: gainboxLabel
                target: gainbox
                text: "<b>" + qsTr("Gain") + "</b>"
                fontSizeMultiplier: factor
                SGComboBox {
                    id:gainbox
                    height: 30 * factor
                    width: 80 * factor
                    model: ["0.25", "1", "2", "8"]
                    fontSizeMultiplier: factor
                    onActivated: {
                        platformInterface.i2c_light_ui_gain = parseFloat(currentText)
                        platformInterface.i2c_light_set_gain.update(parseFloat(currentText))
                    }
                }
            }

            SGAlignedLabel {
                id: timeboxLabel
                target: timebox
                text: "<b>" + qsTr("Integration Time") + "</b>"
                fontSizeMultiplier: factor
                SGComboBox {
                    id:timebox
                    height: 30 * factor
                    width: 90 * factor
                    model: ["12.5ms", "100ms", "200ms", "Manual"]
                    fontSizeMultiplier: factor
                    onActivated: {
                        if (currentText !== "Manual") {
                            if (platformInterface.i2c_light_ui_start) {
                                platformInterface.i2c_light_ui_start = false
                                platformInterface.i2c_light_start.update(false)
                            }
                        }
                        platformInterface.i2c_light_ui_time = currentText
                        platformInterface.i2c_light_set_integration_time.update(currentText)
                    }
                }
            }

            SGAlignedLabel {
                id: activeswLabel
                target: activesw
                text: "<b>" + qsTr("Status") + "</b>"
                fontSizeMultiplier: factor
                SGSwitch {
                    id:activesw
                    height: 30 * factor
                    width: 80 * factor
                    fontSizeMultiplier: factor
                    checkedLabel: qsTr("Active")
                    uncheckedLabel: qsTr("Sleep")
                    onClicked: {
                        if (!checked) {
                            if (platformInterface.i2c_light_ui_start) {
                                platformInterface.i2c_light_ui_start = false
                            }
                        }
                        platformInterface.i2c_light_ui_active = checked
                        platformInterface.i2c_light_active.update(checked)
                    }
                }
            }

            SGAlignedLabel {
                id: startswLabel
                target: startsw
                text: "<b>" + qsTr("Manual Integration") + "</b>"
                fontSizeMultiplier: factor
                SGSwitch {
                    id:startsw
                    height: 30 * factor
                    width: 90 * factor
                    fontSizeMultiplier: factor
                    checkedLabel: qsTr("Start")
                    uncheckedLabel: qsTr("Stop")
                    onClicked: {
                        platformInterface.i2c_light_ui_start = checked
                        platformInterface.i2c_light_start.update(checked)
                    }
                }
            }
        }

        Item {
            Layout.minimumHeight: 20
            Layout.minimumWidth: 20
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(width,content.height)
            Layout.alignment: Qt.AlignCenter

            SGCircularGauge {
                id: gauge
                height: Math.min(parent.height, parent.width)
                width: Math.min(parent.height, parent.width)
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                unitText: "Lux\n(lx)"
                unitTextFontSizeMultiplier: factor + 1
                value: 0
                tickmarkStepSize: 5000
                minimumValue: 0
                maximumValue: 65536
            }
        }
    }
}
