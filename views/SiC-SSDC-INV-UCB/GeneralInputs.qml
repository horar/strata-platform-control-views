import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls 2.3
import tech.strata.sgwidgets 0.9 as Widget09
import tech.strata.sgwidgets 1.0
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help
import "qrc:/image"

Item {
    id: root
    height: 500
    width: parent.width

    property var gainVolt: platformInterface.gainVolt
    property var offsetVolt: platformInterface.offsetVolt

    property var gainCurrent: platformInterface.gainCurrent
    property var offsetCurrent: platformInterface.offsetCurrent

    property var r25: platformInterface.r25
    property var r2550: platformInterface.r2550
    property var r2580: platformInterface.r2580
    property var r25120: platformInterface.r25120

    property var overTemperatureFault: platformInterface.overTemperatureFault
    property var overTemperatureWarning: platformInterface.overTemperatureWarning

    property var voutOVlimitFault: platformInterface.voutOVlimitFault
    property var voutOVlimitWarning: platformInterface.voutOVlimitWarning

    property var voutUVlimitFault: platformInterface.voutUVlimitFault
    property var voutUVlimitWarning: platformInterface.voutUVlimitWarning

    property var ioutOClimitFault: platformInterface.ioutOClimitFault
    property var ioutOClimitWarning: platformInterface.ioutOClimitWarning


    Rectangle {
        id: gainOffset
        property bool debugLayout: false
        anchors.fill: parent

        Text{
            id: voltText
            text: "<b>Voltage Measurements:<b>"
            font.pixelSize: (parent.width + parent.height)/120
            color: "black"
            anchors {
                top : parent.top
                topMargin : parent.height/20
                left: parent.left
                leftMargin: parent.width/20
                }
            }

            SGAlignedLabel{
                id: gainVoltLabel
                target: gainVoltSlider
                text:"Gain"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/4
                anchors {
                    top: voltText.top
                    topMargin: parent.height/20
                    left: voltText.left
                    }
                SGSlider {
                    id: gainVoltSlider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainVolt
                    stepSize: 0.1
                    onValueChanged: gainVolt = value
                    onUserSet: platformInterface.gainVolt = gainVoltSlider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetVoltLabel
                target: offsetVoltSlider
                text:"Offset"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/4
                anchors {
                    top: gainVoltLabel.bottom
                    topMargin: parent.height/50
                    left: voltText.left
                    }
                SGSlider {
                    id: offsetVoltSlider
                    width: parent.width
                    from: -multiplePlatform.nominalVin
                    to: multiplePlatform.nominalVin
                    value: platformInterface.offsetVolt
                    stepSize: 1
                    onValueChanged: offsetVolt = value
                    onUserSet: platformInterface.offsetVolt = offsetVoltSlider.value
                    live: false
                }
                Text{
                    id: offsetVoltSliderUnit
                    text:"V"
                    font.pixelSize: (parent.width + parent.height)/40
                    color: "black"
                    anchors.left: offsetVoltSlider.right
                    anchors.verticalCenter: offsetVoltSlider.top
                    }
            }

            Text{
                id: currentText
                text: "<b>Current Measurements:<b>"
                font.pixelSize: (parent.width + parent.height)/120
                color: "black"
                anchors {
                    top : parent.top
                    topMargin : parent.height/20
                    left: offsetVoltLabel.right
                    leftMargin: parent.width/20
                    }
                }

                SGAlignedLabel{
                    id: gainCurrentLabel
                    target: gainCurrentSlider
                    text:"Gain"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: currentText.top
                        topMargin: parent.height/20
                        left: currentText.left
                        }
                    SGSlider {
                        id: gainCurrentSlider
                        width: parent.width
                        from: 0
                        to: 100
                        value: platformInterface.gainCurrent
                        stepSize: 0.1
                        onValueChanged: gainCurrent = value
                        onUserSet: platformInterface.gainCurrent = gainCurrentSlider.value
                        live: false
                    }
                }

                SGAlignedLabel{
                    id: offsetCurrentLabel
                    target: offsetCurrentSlider
                    text:"Offset"
                    font.pixelSize: (parent.width + parent.height)/ 150
                    width: parent.width/4
                    anchors {
                        top: gainCurrentLabel.bottom
                        topMargin: parent.height/50
                        left: currentText.left
                        }
                    SGSlider {
                        id: offsetCurrentSlider
                        width: parent.width
                        from: -1500
                        to: 1500
                        value: platformInterface.offsetCurrent
                        stepSize: 1
                        onValueChanged: offsetCurrent = value
                        onUserSet: platformInterface.offsetCurrent = offsetCurrentSlider.value
                        live: false
                    }
                    Text{
                        id: offsetCurrentSliderUnit
                        text:"V"
                        font.pixelSize: (parent.width + parent.height)/40
                        color: "black"
                        anchors.left: offsetCurrentSlider.right
                        anchors.verticalCenter: offsetCurrentSlider.top
                        }
                }


                Text{
                    id: tempText
                    text: "<b>Temperature Measurements:<b>"
                    font.pixelSize: (parent.width + parent.height)/120
                    color: "black"
                    anchors {
                        top : parent.top
                        topMargin : parent.height/20
                        left: offsetCurrentLabel.right
                        leftMargin: parent.width/20
                        }
                    }

                    SGAlignedLabel{
                        id: r25Label
                        target: r25Slider
                        text:"R25"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: tempText.top
                            topMargin: parent.height/20
                            left: tempText.left
                            }
                        SGSlider {
                            id: r25Slider
                            width: parent.width
                            from: 0
                            to: 10000
                            value: platformInterface.r25
                            stepSize: 1
                            onValueChanged: r25 = value
                            onUserSet: platformInterface.r25 = r25Slider.value
                            live: false
                        }
                        Text{
                            id: r25SliderUnit
                            text:"Ω"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: r25Slider.right
                            anchors.verticalCenter: r25Slider.top
                            }
                    }

                    SGAlignedLabel{
                        id: r2550Label
                        target: r2550Slider
                        text:"R25/50"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: r25Label.bottom
                            topMargin: parent.height/50
                            left: tempText.left
                            }
                        SGSlider {
                            id: r2550Slider
                            width: parent.width
                            from: 0
                            to: 10000
                            value: platformInterface.r2550
                            stepSize: 1
                            onValueChanged: r2550 = value
                            onUserSet: platformInterface.r2550 = r2550Slider.value
                            live: false
                        }
                        Text{
                            id: r2550SliderUnit
                            text:"Ω"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: r2550Slider.right
                            anchors.verticalCenter: r2550Slider.top
                            }
                    }

                    SGAlignedLabel{
                        id: r2580Label
                        target: r2580Slider
                        text:"R25/80"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: r2550Label.bottom
                            topMargin: parent.height/50
                            left: tempText.left
                            }
                        SGSlider {
                            id: r2580Slider
                            width: parent.width
                            from: 0
                            to: 10000
                            value: platformInterface.r2580
                            stepSize: 1
                            onValueChanged: r2580 = value
                            onUserSet: platformInterface.r2580 = r2580Slider.value
                            live: false
                        }
                        Text{
                            id: r2580SliderUnit
                            text:"Ω"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: r2580Slider.right
                            anchors.verticalCenter: r2580Slider.top
                            }
                    }

                    SGAlignedLabel{
                        id: r25120Label
                        target: r25120Slider
                        text:"R25/120"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: r2580Label.bottom
                            topMargin: parent.height/50
                            left: tempText.left
                            }
                        SGSlider {
                            id: r25120Slider
                            width: parent.width
                            from: 0
                            to: 10000
                            value: platformInterface.r25120
                            stepSize: 1
                            onValueChanged: r25120 = value
                            onUserSet: platformInterface.r25120 = r25120Slider.value
                            live: false
                        }
                        Text{
                            id: r25120SliderUnit
                            text:"Ω"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: r25120Slider.right
                            anchors.verticalCenter: r25120Slider.top
                            }
                    }

                    Text{
                        id: alarmText
                        text: "<b>Fault / Warning Alarm Settings:<b>"
                        font.pixelSize: (parent.width + parent.height)/120
                        color: "black"
                        anchors {
                            top : r25120Label.top
                            topMargin : parent.height/10
                            left: parent.left
                            leftMargin: parent.width/20
                            }
                        }

                    SGAlignedLabel{
                        id: overTemperatureFaultLabel
                        target: overTemperatureFaultSlider
                        text:"Over Temperature Fault:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: alarmText.top
                            topMargin: parent.height/20
                            left: alarmText.left
                            }
                        SGSlider {
                            id: overTemperatureFaultSlider
                            width: parent.width
                            from: 115
                            to: 135
                            value: platformInterface.status_predefined_values.OT_fault
                            stepSize: 1
                            onValueChanged: overTemperatureFault = value
                            onUserSet: platformInterface.overTemperatureFault = overTemperatureFaultSlider.value
                            live: false
                        }
                        Text{
                            id: overTemperatureFaultSliderUnit
                            text:"°C"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: overTemperatureFaultSlider.right
                            anchors.verticalCenter: overTemperatureFaultSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: voutOVlimitFaultLabel
                        target: voutOVlimitFaultSlider
                        text:"Over Voltage Fault Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: overTemperatureFaultLabel.bottom
                            topMargin: parent.height/50
                            left: alarmText.left
                            }
                        SGSlider {
                            id: voutOVlimitFaultSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.nominalVin
                            value: platformInterface.status_predefined_values.OV_fault
                            stepSize: 1
                            onValueChanged: voutOVlimitFault = value
                            onUserSet: platformInterface.voutOVlimitFault = voutOVlimitFaultSlider.value
                            live: false
                        }
                        Text{
                            id: voutOVlimitFaultSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: voutOVlimitFaultSlider.right
                            anchors.verticalCenter: voutOVlimitFaultSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: voutUVlimitFaultLabel
                        target: voutUVlimitFaultSlider
                        text:"Under Voltage Fault Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: voutOVlimitFaultLabel.bottom
                            topMargin: parent.height/50
                            left: alarmText.left
                            }
                        SGSlider {
                            id: voutUVlimitFaultSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.nominalVin
                            value: platformInterface.status_predefined_values.UV_fault
                            stepSize: 1
                            onValueChanged: voutUVlimitFault = value
                            onUserSet: platformInterface.voutUVlimitFault = voutUVlimitFaultSlider.value
                            live: false
                        }
                        Text{
                            id: voutUVlimitFaultSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: voutUVlimitFaultSlider.right
                            anchors.verticalCenter: voutUVlimitFaultSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: ioutOClimitFaultLabel
                        target: ioutOClimitFaultSlider
                        text:"Over Current Fault Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: voutUVlimitFaultLabel.bottom
                            topMargin: parent.height/50
                            left: alarmText.left
                            }
                        SGSlider {
                            id: ioutOClimitFaultSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.ioutScale
                            value: platformInterface.status_predefined_values.OC_fault
                            stepSize: 1
                            onValueChanged: ioutOClimitFault = value
                            onUserSet: platformInterface.ioutOClimitFault = ioutOClimitFaultSlider.value
                            live: false
                        }
                        Text{
                            id: ioutOClimitFaultSliderUnit
                            text:"A"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: ioutOClimitFaultSlider.right
                            anchors.verticalCenter: ioutOClimitFaultSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: overTemperatureWarningLabel
                        target: overTemperatureWarningSlider
                        text:"Over Temperature Warning:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: alarmText.top
                            topMargin: parent.height/20
                            left: currentText.left
                            }
                        SGSlider {
                            id: overTemperatureWarningSlider
                            width: parent.width
                            from: 85
                            to: 105
                            value: platformInterface.status_predefined_values.OT_warning
                            stepSize: 1
                            onValueChanged: overTemperatureWarning = value
                            onUserSet: platformInterface.overTemperatureWarning = overTemperatureWarningSlider.value
                            live: false
                        }
                        Text{
                            id: overTemperatureWarningSliderUnit
                            text:"°C"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: overTemperatureWarningSlider.right
                            anchors.verticalCenter: overTemperatureWarningSlider.top
                            }
                        }

                    SGAlignedLabel{
                        id: voutOVlimitWarningLabel
                        target: voutOVlimitWarningSlider
                        text:"Over Voltage Warning Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: overTemperatureWarningLabel.bottom
                            topMargin: parent.height/50
                            left: currentText.left
                            }
                        SGSlider {
                            id: voutOVlimitWarningSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.nominalVin
                            value: platformInterface.status_predefined_values.OV_warning
                            stepSize: 1
                            onValueChanged: voutOVlimitWarning = value
                            onUserSet: platformInterface.voutOVlimitWarning = voutOVlimitWarningSlider.value
                            live: false
                        }
                        Text{
                            id: voutOVlimitWarningSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: voutOVlimitWarningSlider.right
                            anchors.verticalCenter: voutOVlimitWarningSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: voutUVlimitWarningLabel
                        target: voutUVlimitWarningSlider
                        text:"Under Voltage Warning Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: voutOVlimitWarningLabel.bottom
                            topMargin: parent.height/50
                            left: currentText.left
                            }
                        SGSlider {
                            id: voutUVlimitWarningSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.nominalVin
                            value: platformInterface.status_predefined_values.UV_warning
                            stepSize: 1
                            onValueChanged: voutUVlimitWarning = value
                            onUserSet: platformInterface.voutUVlimitWarning = voutUVlimitWarningSlider.value
                            live: false
                        }
                        Text{
                            id: voutUVlimitWarningSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: voutUVlimitWarningSlider.right
                            anchors.verticalCenter: voutUVlimitWarningSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: ioutOClimitWarningLabel
                        target: ioutOClimitWarningSlider
                        text:"Over Current Warning Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: voutUVlimitWarningLabel.bottom
                            topMargin: parent.height/50
                            left: currentText.left
                            }
                        SGSlider {
                            id: ioutOClimitWarningSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.ioutScale
                            value: platformInterface.status_predefined_values.OC_warning
                            stepSize: 1
                            onValueChanged: ioutOClimitWarning = value
                            onUserSet: platformInterface.ioutOClimitWarning = ioutOClimitWarningSlider.value
                            live: false
                        }
                        Text{
                            id: ioutOClimitWarningSliderUnit
                            text:"A"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: ioutOClimitWarningSlider.right
                            anchors.verticalCenter: ioutOClimitWarningSlider.top
                            }
                    }
        }
}

