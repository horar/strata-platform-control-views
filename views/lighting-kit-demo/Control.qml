import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import tech.strata.sgwidgets 1.0 as SGWidgets
import tech.strata.commoncpp 1.0 as CommonCPP

Item {
    id: controlRoot
    anchors {
        fill: parent
    }

    readonly property string lightControlService: "00000001-0001-0362-b5da-012dd27485f8"
    readonly property string telemetryService:    "00000002-0001-0362-b5da-012dd27485f8"
    readonly property string aggregateCharacteristic: "2a5a"

    property int sliderMaxValue: 100
    property real channel1Current: 0.0
    property real channel2Current: 0.0
    property real powerVoltage: 0.0
    property int channel1Pwm: 0
    property int channel2Pwm: 0

    Component.onCompleted: {
        startLightNotifications()
        startTelemetryNotifications()
    }

    PlatformInterface {
        id: platformInterface
    }

    Connections {
        target: platformInterface.notifications.notify
        onNotificationFinished: {
            if (platformInterface.notifications.notify.service === telemetryService
                && platformInterface.notifications.notify.characteristic === aggregateCharacteristic)
                {
                    channel1Current = extractFloat(platformInterface.notifications.notify.data, 0,4)
                    channel2Current = extractFloat(platformInterface.notifications.notify.data, 4,4)
                    powerVoltage = extractFloat(platformInterface.notifications.notify.data, 8,4)

                     console.log("telemetry data updated",
                        platformInterface.notifications.notify.data,
                        "->",
                        channel1Current,
                        channel2Current,
                        powerVoltage)

            } else if (platformInterface.notifications.notify.service === lightControlService
                && platformInterface.notifications.notify.characteristic === aggregateCharacteristic)
                {
                    channel1Pwm = extractInteger(platformInterface.notifications.notify.data, 0, 2)
                    channel2Pwm = extractInteger(platformInterface.notifications.notify.data, 2, 2)

                    console.log("led data updated",
                        platformInterface.notifications.notify.data,
                        "->",
                        channel1Pwm,
                        channel2Pwm)

                    channel1Slider.value = channel1Pwm
                    channel2Slider.value = channel2Pwm
                }
        }
    }

    SGWidgets.SGText {
        id: title
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        text: "LIGHTING-LED-GEVK"
        font.bold: true
        fontSizeMultiplier: 5.0
        color: "green"
    }

    Column {
        id: content
        anchors {
            top: title.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 20

        Column {
            spacing: 4

            SGWidgets.SGText {
                text: "Light control service"
                fontSizeMultiplier: 1.3
                font.bold: true
            }

            Column {
                SGWidgets.SGText {
                    text: "Channel 1 PWN"
                }

                SGWidgets.SGSlider {
                    id: channel1Slider
                    width: 700

                    from: 0
                    to: sliderMaxValue
                    stepSize: 1
                    value: 0

                    onPressedChanged: {
                        if (pressed === false && value != channel1Pwm) {
                            Qt.callLater(writeLedData)
                        }
                    }
                }
            }

            Item {
                height: 4
                width: 1
            }

            Column {
                SGWidgets.SGText {
                    text: "Channel 2 PWN"
                }

                SGWidgets.SGSlider {
                    id: channel2Slider
                    width: channel1Slider.width

                    from: channel1Slider.from
                    to: channel1Slider.to
                    stepSize: channel1Slider.stepSize
                    value: 0

                    onPressedChanged: {
                        if (pressed === false && value != channel2Pwm) {
                            Qt.callLater(writeLedData)
                        }
                    }
                }
            }
        }

         Column {
            spacing: 4

            SGWidgets.SGText {
                text: "Telemetry service"
                fontSizeMultiplier: 1.3
                font.bold: true
            }

            GridLayout {
                columns: 2
                columnSpacing: 6

                SGWidgets.SGText {
                    text: "LED Channel 1:"
                }

                SGWidgets.SGText {
                    text: channel1Current.toFixed(3) + " mA"
                }


                SGWidgets.SGText {
                    text: "LED Channel 2:"
                }

                SGWidgets.SGText {
                    text: channel2Current.toFixed(3) + " mA"
                }

                SGWidgets.SGText {
                    text: "System Voltage:"
                }

                SGWidgets.SGText {
                    text:powerVoltage.toFixed(3) + " V"
                }
            }

            SGWidgets.SGSwitch {
                id: telemetrySwitch
                checkedLabel: "ON"
                uncheckedLabel: "OFF"
                grooveFillColor: "green"
                onCheckedChanged: {
                    if (checked) {
                        startTelemetryNotifications()
                    } else {
                        stopTelemetryNotifications()
                    }
                }
            }
        }
    }

    function extractInteger(hexData, byteStart, length) {
        var hexString = hexData.substr(byteStart*2, length*2)
        return CommonCPP.SGUtilsCpp.hexStringToInt16(hexString)
    }

    function extractFloat(hexData, byteStart, length) {
        var hexString = hexData.substr(byteStart*2, length*2)
        return CommonCPP.SGUtilsCpp.hexStringToFloat32(hexString)
    }

    function writeLedData() {
        var data1 = CommonCPP.SGUtilsCpp.uint16ToHexString(channel1Slider.value)
        var data2 = CommonCPP.SGUtilsCpp.uint16ToHexString(channel2Slider.value)

        var data = data1+data2

        platformInterface.commands.write.update(
            aggregateCharacteristic,
            data,
            lightControlService)
    }

    function startTelemetryNotifications() {
        platformInterface.commands.write_descriptor.update(
            aggregateCharacteristic,
            "0100",
            "2902",
            telemetryService)

        telemetrySwitch.checked = true
    }

    function startLightNotifications() {
        platformInterface.commands.write_descriptor.update(
                    aggregateCharacteristic,
                    "0100",
                    "2902",
                    lightControlService)
    }

    function stopTelemetryNotifications() {
        platformInterface.commands.write_descriptor.update(
            aggregateCharacteristic,
            "0000",
            "2902",
            telemetryService)

        telemetrySwitch.checked = false
    }

    function stopLightNotifications() {
        platformInterface.commands.write_descriptor.update(
            aggregateCharacteristic,
            "0000",
            "2902",
            lightControlService)
    }
}
