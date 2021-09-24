/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
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

    property var vinOVlimitFault: platformInterface.vinOVlimitFault
    property var vinOVlimitWarning: platformInterface.vinOVlimitWarning

    property var vinUVlimitFault: platformInterface.vinUVlimitFault
    property var vinUVlimitWarning: platformInterface.vinUVlimitWarning

    property var ioutOClimitFault: platformInterface.ioutOClimitFault
    property var ioutOClimitWarning: platformInterface.ioutOClimitWarning

    Component.onCompleted:  {

        Help.registerTarget(navTabs, "Default settings:\n-Loaded automatically.\n-Please check datasheets before changing.\n-Gain and offset for Voltage measurement (Inputs from user based on Gate driver voltage measurement parameters).\n-Gain and offset for phase currents measurements (Inputs from user based on LEM Sensor parameters).\n-Module NTC parameters.\n-Fault / Warning Alarm Settings.", 0, "generalControlHelp")

    }


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
                    to: multiplePlatform.nominalVin
                    value: multiplePlatform.gainVolt
                    stepSize: 0.001
                    onValueChanged: gainVolt = value
                    onUserSet: platformInterface.gainVolt = gainVoltSlider.value*1000
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
                    value: multiplePlatform.offsetVolt
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
                        to: multiplePlatform.ioutScale
                        value: multiplePlatform.gainCurrent
                        stepSize: 0.001
                        onValueChanged: gainCurrent = value
                        onUserSet: platformInterface.gainCurrent = gainCurrentSlider.value*1000
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
                        from: -multiplePlatform.ioutScale
                        to: multiplePlatform.ioutScale
                        value: multiplePlatform.offsetCurrent
                        stepSize: 0.001
                        onValueChanged: offsetCurrent = value
                        onUserSet: platformInterface.offsetCurrent = offsetCurrentSlider.value*1000
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

                Rectangle {
                    id: warningBox
                    color: "red"
                    radius: 10
                    anchors {
                        top: offsetVoltLabel.bottom
                        topMargin: parent.height/15
                        left: voltText.left
                    }
                    width: parent.width/3
                    height: parent.height/20

                    Text {
                        id: warningText
                        anchors {
                            centerIn: warningBox
                        }
                        text: "<b>Please check datasheets before doing changes.</b>"
                        font.pixelSize: (parent.width + parent.height)/30
                        color: "white"
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
                            value: multiplePlatform.r25
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
                        text:"B25/50"
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
                            value: multiplePlatform.r2550
                            stepSize: 1
                            onValueChanged: r2550 = value
                            onUserSet: platformInterface.r2550 = r2550Slider.value
                            live: false
                        }
                        Text{
                            id: r2550SliderUnit
                            text:"K"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: r2550Slider.right
                            anchors.verticalCenter: r2550Slider.top
                            }
                    }

                    SGAlignedLabel{
                        id: r2580Label
                        target: r2580Slider
                        text:"B25/80"
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
                            value: multiplePlatform.r2580
                            stepSize: 1
                            onValueChanged: r2580 = value
                            onUserSet: platformInterface.r2580 = r2580Slider.value
                            live: false
                        }
                        Text{
                            id: r2580SliderUnit
                            text:"K"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: r2580Slider.right
                            anchors.verticalCenter: r2580Slider.top
                            }
                    }

                    SGAlignedLabel{
                        id: r25120Label
                        target: r25120Slider
                        text:"B25/120"
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
                            value: multiplePlatform.r25120
                            stepSize: 1
                            onValueChanged: r25120 = value
                            onUserSet: platformInterface.r25120 = r25120Slider.value
                            live: false
                        }
                        Text{
                            id: r25120SliderUnit
                            text:"K"
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
                            from: 60
                            to: 150
                            value: multiplePlatform.overTemperatureFault
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
                        id: vinOVlimitFaultLabel
                        target: vinOVlimitFaultSlider
                        text:"Over Voltage Fault Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: overTemperatureFaultLabel.bottom
                            topMargin: parent.height/50
                            left: alarmText.left
                            }
                        SGSlider {
                            id: vinOVlimitFaultSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.vinScale
                            value: multiplePlatform.vinOVlimitFault
                            stepSize: 1
                            onValueChanged: vinOVlimitFault = value
                            onUserSet: platformInterface.vinOVlimitFault = vinOVlimitFaultSlider.value
                            live: false
                        }
                        Text{
                            id: vinOVlimitFaultSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: vinOVlimitFaultSlider.right
                            anchors.verticalCenter: vinOVlimitFaultSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: vinUVlimitFaultLabel
                        target: vinUVlimitFaultSlider
                        text:"Under Voltage Fault Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: vinOVlimitFaultLabel.bottom
                            topMargin: parent.height/50
                            left: alarmText.left
                            }
                        SGSlider {
                            id: vinUVlimitFaultSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.vinScale
                            value: multiplePlatform.vinUVlimitFault
                            stepSize: 1
                            onValueChanged: vinUVlimitFault = value
                            onUserSet: platformInterface.vinUVlimitFault = vinUVlimitFaultSlider.value
                            live: false
                        }
                        Text{
                            id: vinUVlimitFaultSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: vinUVlimitFaultSlider.right
                            anchors.verticalCenter: vinUVlimitFaultSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: ioutOClimitFaultLabel
                        target: ioutOClimitFaultSlider
                        text:"Over Current Fault Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: vinUVlimitFaultLabel.bottom
                            topMargin: parent.height/50
                            left: alarmText.left
                            }
                        SGSlider {
                            id: ioutOClimitFaultSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.ioutScale
                            value: multiplePlatform.ioutOClimitFault
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
                            from: 60
                            to: 150
                            value: multiplePlatform.overTemperatureWarning
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
                        id: vinOVlimitWarningLabel
                        target: vinOVlimitWarningSlider
                        text:"Over Voltage Warning Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: overTemperatureWarningLabel.bottom
                            topMargin: parent.height/50
                            left: currentText.left
                            }
                        SGSlider {
                            id: vinOVlimitWarningSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.vinScale
                            value: multiplePlatform.vinOVlimitWarning
                            stepSize: 1
                            onValueChanged: vinOVlimitWarning = value
                            onUserSet: platformInterface.vinOVlimitWarning = vinOVlimitWarningSlider.value
                            live: false
                        }
                        Text{
                            id: vinOVlimitWarningSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: vinOVlimitWarningSlider.right
                            anchors.verticalCenter: vinOVlimitWarningSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: vinUVlimitWarningLabel
                        target: vinUVlimitWarningSlider
                        text:"Under Voltage Warning Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: vinOVlimitWarningLabel.bottom
                            topMargin: parent.height/50
                            left: currentText.left
                            }
                        SGSlider {
                            id: vinUVlimitWarningSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.vinScale
                            value: multiplePlatform.vinUVlimitWarning
                            stepSize: 1
                            onValueChanged: vinUVlimitWarning = value
                            onUserSet: platformInterface.vinUVlimitWarning = vinUVlimitWarningSlider.value
                            live: false
                        }
                        Text{
                            id: vinUVlimitWarningSliderUnit
                            text:"V"
                            font.pixelSize: (parent.width + parent.height)/40
                            color: "black"
                            anchors.left: vinUVlimitWarningSlider.right
                            anchors.verticalCenter: vinUVlimitWarningSlider.top
                            }
                    }

                    SGAlignedLabel{
                        id: ioutOClimitWarningLabel
                        target: ioutOClimitWarningSlider
                        text:"Over Current Warning Limit:"
                        font.pixelSize: (parent.width + parent.height)/ 150
                        width: parent.width/4
                        anchors {
                            top: vinUVlimitWarningLabel.bottom
                            topMargin: parent.height/50
                            left: currentText.left
                            }
                        SGSlider {
                            id: ioutOClimitWarningSlider
                            width: parent.width
                            from: 0
                            to: multiplePlatform.ioutScale
                            value: multiplePlatform.ioutOClimitWarning
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

