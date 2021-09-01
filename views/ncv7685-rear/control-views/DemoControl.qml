import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import tech.strata.sgwidgets 1.0
//import tech.strata.sgwidgets 0.9 as Widget09
import "images"
import "qrc:/js/help_layout_manager.js" as Help

Item {
    id: demoPage
    Layout.fillHeight: true
    Layout.fillWidth: true

    property real ratioCalc: demoPage.width / 1200
    property real initialAspectRatio: 0.6
    height:  parent.height
    width:   (parent.width / parent.height) > initialAspectRatio ?  parent.width :  (parent.width * initialAspectRatio)

    property bool gauges_swtich_control: true

    property bool button_active: false
    property bool welcome_no_button_active: true
    property bool welcome_has_button_clicked: false

    property bool brake_no_button_active: true
    property bool brake_has_button_clicked: false

    property bool fading_no_button_active: true
    property bool fading_has_button_clicked: false

    property bool leftturn_no_button_active: true
    property bool leftturn_has_button_clicked: false

    property bool rightturn_no_button_active: true
    property bool rightturn_has_button_clicked: false

    property bool warning_no_button_active: true
    property bool warning_has_button_clicked: false

    property bool setting_no_button_active: true
    property bool setting_has_button_clicked: false

    property bool goodbye_no_button_active: true
    property bool goodbye_has_button_clicked: false

    Component.onCompleted: {


        leftturnPeriodSet.value = 1
        leftturnCycleSet.value  = 4
        rightturnPeriodSet.value = 1
        rightturnCycleSet.value  = 4
        warningPeriodSet.value = 1
        warningCycleSet.value  = 4
        fadingPeriodSet.value = 1
        fadingCycleSet.value  = 4
        brakeStrengthSet.value = 127

        Help.registerTarget(navTabs, "    These tabs contain different user interface functionality of the \"Strata Multiple NCV7685 Chips for Rear Lighting Demo\" board. \n\n    \"Animation Demo\" page demonstrate seven kinds of animations and each one has configurable parameters. \n\n    \"Customized Test\" page shows one frame, which contains seventy-two LEDs. Each LED\'s intensity can be set individually to implement one pattern. The useful features of NCV7685 also can be enable or disable in this page.", 0, "AnimationPageHelp")
        Help.registerTarget(gauge1Container, "    The voltage gauge shows the input voltage of the LED bus in real time.", 1, "AnimationPageHelp")
        Help.registerTarget(gauge2Container, "    The current gauge shows the input current of the LED bus  in real time.", 2, "AnimationPageHelp")
        Help.registerTarget(gaugeSwitchcontainer, "    Enable or disable both of voltage and current gauges by switch.", 3, "AnimationPageHelp")
        Help.registerTarget(dashboardcontainer, "    Control buttons for showing seven kinds of animation, configurable parameters can be set in the popup setting windows  according to every animation . \n\n    Just hover and click on the button.", 4, "AnimationPageHelp")
        Help.registerTarget(welcome_button, "    It shows \"Welcome\" animation, can be used as \"Leaving Home\" in the automotive lighting. \n\n    Configurable settings: One shot    Default: ON", 5, "AnimationPageHelp")
        Help.registerTarget(brake_button, "    It shows \"Brake\" function. Intensity (PWM duty) can changed by drag the slider.\n\n    Configurable settings: PWM_DUTY    Default: 100 ", 6, "AnimationPageHelp")
        Help.registerTarget(fading_button, "    It shows \"Fading\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 7, "AnimationPageHelp")
        Help.registerTarget(leftturn_button, "    It shows \"Left Turn\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 8, "AnimationPageHelp")
        Help.registerTarget(rightturn_button, "    It shows \"Right Turn\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 9, "AnimationPageHelp")
        Help.registerTarget(warning_button, "    It shows \"Warning\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 10, "AnimationPageHelp")
        Help.registerTarget(goodbye_button, "    It shows \"Goodbye\" animation, can be used as \"Going Home\" in the automotive lighting. \n\n    Configurable settings: One shot    Default: ON", 11, "AnimationPageHelp")
        Help.registerTarget(setting_button, "    It shows \"Setting\" popup window to enable or disable the features of NCV7685.\n\nConfigurable settings: PWM Frequency: 300Hz \n                                PWM Mode: Logarithmic      \n                                Auto Recovery:  Off", 12, "AnimationPageHelp")
        Help.registerTarget(pwmSettingContainer, "    Setting popup window, each control button has own paramets to configure. \n\nSend: send out commands according to the setting.\nExit:   exit the setting wiondow.", 13, "AnimationPageHelp")

    }


    Rectangle {
        id: sky
        width: parent.width
        height: parent.height*0.55
        anchors.top: parent.top
        anchors.bottom: car.top
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#66CCFF"  }
            GradientStop { position: 1.0; color: "#ADD8E6" }
            //  "#66CCFF"   B0E0E6   C0C0C0  #E6E6FA #FFF5EE #B0C4DE  #ADD8E6 #7FFFD4  #F0F8FF
        }
    }

    Rectangle {
        id: ground
        width: parent.width
        height: parent.height*0.45
        anchors.top: sky.bottom
        anchors.bottom: parent.bottom
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "slategray" }
        }
    }

    Image {
        id: car
        width: parent.width
        //height: width*1500/428
        anchors.bottom: parent.bottom
        source: "images/dashboard.png"
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: gaugeSwitchcontainer
        anchors.top:  car.top
        anchors.topMargin: 10
        anchors.horizontalCenter: car.horizontalCenter
        anchors.horizontalCenterOffset: -10
        width: car.width / 5
        height: width / 3

        Rectangle {
            id: gaugeSwitch
            color: "transparent"
            //                                    color: "#0000FF"
            anchors.fill: parent
            SGSwitch {
                id: gauges
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width/1.4
                height:  width/4
                handleColor: "#F0F8FF"
                grooveColor: "#E6E6FA"
                grooveFillColor: "#0cf"
                fontSizeMultiplier:  ratioCalc * 1.2
                checked: true
                checkedLabel: "<b>Gauges On</b>"
                uncheckedLabel: "<b>Gauges Off</b>"
                textColor: "black"
                onToggled:  {
                    if (checked){
                        gauges_swtich_control = true
                        gauge1Container.visible = true
                        gauge2Container.visible = true
                    }
                    else{
                        gauges_swtich_control = false
                        gauge1Container.visible = false
                        gauge2Container.visible = false
                    }
                }
            }
        }
    }

    Item {
        id: gauge1Container
        anchors.bottom: car.top
        anchors.bottomMargin:  20
        anchors.left: car.left
//        anchors.left: sky.left
        anchors.leftMargin: 10
        width: car.width / 3.5
        height: width
        Rectangle {
            id: voltageContainer
            color: "transparent"
            //            color: "#0000FF"
            anchors.fill: parent
            SGAlignedLabel {
                id:voltageLabel
                target: voltageGauge
                anchors.centerIn: parent
                alignment: SGAlignedLabel.SideBottomCenter
                text: "LED Bus Voltage"
                fontSizeMultiplier: ratioCalc * 2
                font.bold : true
                horizontalAlignment: voltageContainer.AlignHCenter
                SGCircularGauge {
                    id: voltageGauge
                    width: voltageContainer.width
                    height: voltageContainer.height -voltageLabel.contentHeight
                    gaugeFillColor1: "#00CD66"
                    gaugeFillColor2: "#BCEE68"
                    unitText: "<b>V</b>"
                    unitTextFontSizeMultiplier: ratioCalc * 2.5
                    valueDecimalPlaces: 2
                    minimumValue:  0
                    maximumValue: 5
                    tickmarkStepSize: 1
                    value: 3.65

                    property var demo_voltage_value: platformInterface.notifications.input_voltage_current.v_in
                    onDemo_voltage_valueChanged: {
                        voltageGauge.value = (demo_voltage_value/1000).toFixed(2)
                    }
                }
            }
        }
    }

    Item {
        id: gauge2Container
        anchors.bottom: car.top
        anchors.bottomMargin:  20
        anchors.right: car.right
//        anchors.right: sky.right

        anchors.rightMargin: 10
        width: car.width / 3.5
        height: width
        Rectangle {
            id: currentContainer
            color: "transparent"
            //            color: "#00ffFF"
            anchors.fill: parent
            SGAlignedLabel {
                id:currentLabel
                target: currentGauge
                anchors.centerIn: parent
                alignment: SGAlignedLabel.SideBottomCenter
                text: "LED Bus Current"
                fontSizeMultiplier: ratioCalc * 2
                font.bold : true
                horizontalAlignment: Text.AlignHCenter
                SGCircularGauge {
                    id: currentGauge
                    width: currentContainer.width
                    height: currentContainer.height -currentLabel.contentHeight
                    gaugeFillColor1: "#00CD66"
                    gaugeFillColor2: "#BCEE68"
                    unitText: "<b>A</b>"
                    unitTextFontSizeMultiplier: ratioCalc * 2.5
                    valueDecimalPlaces: 2
                    minimumValue:   0
                    maximumValue:  4
                    tickmarkStepSize: 1
                    value: 2.00

                    property var demo_current_value: platformInterface.notifications.input_voltage_current.i_in
                    onDemo_current_valueChanged: {
                        currentGauge.value = (demo_current_value/1000).toFixed(2)
                    }
                }
            }
        }
    }

    Item {
        id: welcomeSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/3
//        visible: true
               visible: false
        Rectangle {
            id: welcomeSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: welcomeSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent
//                opacity: 0.1

                Rectangle {
                    id: welcomeSwitchContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.6
                    height: parent.height * 0.4
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1
                    SGSwitch {
                        id: welcomeSettingOneshot
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width/1.4
                        height:  width/5
                        handleColor: "#F0F8FF"
                        grooveColor: "#E6E6FA"
                        grooveFillColor: "#0cf"
                        fontSizeMultiplier:  ratioCalc * 1.5
                        checked: true
                        checkedLabel: "<b>One Shot</b>"
                        uncheckedLabel: "<b>Consecutive</b>"
                        textColor: "black"
                   }
                }

                Rectangle {
                    id: welcomeSwitchExitContainer
                    //                    color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: welcomeSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            welcome_has_button_clicked = false
                            welcome_no_button_active = true

                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                      }
                    }
                }


                Rectangle {
                    id: welcomeSwitchSendContainer
                    //                    color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: welcomeSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            if (welcomeSettingOneshot.checked)
                                 platformInterface.commands.demo_welcome.update(true)
                            else
                                 platformInterface.commands.demo_welcome.update(false)
                        }
                    }
                }

            }
        }

    }

    Item {
        id: goodbyeSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/3
//        visible: true
               visible: false
        Rectangle {
            id: goodbyeSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: goodbyeSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent
//                opacity: 0.1

                Rectangle {
                    id: goodbyeSwitchContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.6
                    height: parent.height * 0.4
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1
                    SGSwitch {
                        id: goodbyeSettingOneshot
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width/1.4
                        height:  width/5
                        handleColor: "#F0F8FF"
                        grooveColor: "#E6E6FA"
                        grooveFillColor: "#0cf"
                        fontSizeMultiplier:  ratioCalc * 1.5
                        checked: true
                        checkedLabel: "<b>One Shot</b>"
                        uncheckedLabel: "<b>Consecutive</b>"
                        textColor: "black"
                   }
                }

                Rectangle {
                    id: goodbyeSwitchExitContainer
                    //                    color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: goodbyeSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            goodbye_has_button_clicked = false
                            goodbye_no_button_active = true
                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                      }
                    }
                }


                Rectangle {
                    id:goodbyeSwitchSendContainer
                    //                    color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: goodbyeSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            if (goodbyeSettingOneshot.checked)
                                 platformInterface.commands.demo_byebye.update(true)
                            else
                                 platformInterface.commands.demo_byebye.update(false)
                        }
                    }
                }

            }
        }
    }


    Item {
        id: leftturnSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/2.4
//        visible: true
        visible: false
        Rectangle {
            id: leftturnSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: leftturnSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent

                Rectangle {
                    id: leftturnColumnContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1

                    Column{
                        id:leftturnSettingColumn

                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.left:parent.left
                        anchors.leftMargin: 4
                        anchors.fill: parent
                        spacing: 20

                        SGAlignedLabel {
                            id: leftturnPeriodSetting
                            target: leftturnPeriodSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Period Setting(S):"
                            color:  "#000000"
                            SGSlider {
                                id: leftturnPeriodSet
                                width: leftturnColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 0.5
                                to: 16
                                stepSize: 0.1
                           }
                        }

                        SGAlignedLabel {
                            id: leftturnCycleSetting
                            target: leftturnCycleSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Cycle Setting:"
                            color:  "#000000"
                            SGSlider {
                                id: leftturnCycleSet
                                width: leftturnColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 1
                                to: 32
                                stepSize: 1
                            }
                        }
                    }

                }

                Rectangle {
                    id: leftturnSwitchExitContainer
                    //                                        color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: leftturnSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            leftturn_has_button_clicked = false
                            leftturn_no_button_active = true
                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                        }
                    }
                }

                Rectangle {
                    id:leftturnSwitchSendContainer
                    //                                        color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: leftturnSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            if (leftturnSettingOneshot.checked)
                                platformInterface.commands.demo_left_turn.update( Number(  (leftturnCycleSet.value).toFixed(0)     ),true,  Number(  ((leftturnPeriodSet.value)*1000).toFixed(0))  )
                            else
                                platformInterface.commands.demo_left_turn.update( Number(  (leftturnCycleSet.value).toFixed(0)     ),false, Number(  ((leftturnPeriodSet.value)*1000).toFixed(0))  )
                        }
                    }
                }

                SGSwitch {
                    id: leftturnSettingOneshot
                    width: leftturnSwitchSendContainer.width + 20
                    height:  width/3.5
                    anchors.horizontalCenter: leftturnSwitchSendContainer.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    handleColor: "#F0F8FF"
                    grooveColor: "#E6E6FA"
                    grooveFillColor: "#0cf"
                    //                    fontSizeMultiplier:  ratioCalc * 1.5
                    checked: true
                    checkedLabel: "<b>One Shot</b>"
                    uncheckedLabel: "<b>Off</b>"
                    textColor: "black"
                }

            }
        }
    }


    Item {
        id: rightturnSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/2.4
//        visible: true
        visible: false
        Rectangle {
            id: rightturnSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: rightturnSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent

                Rectangle {
                    id: rightturnColumnContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1

                    Column{
                        id:rightturnSettingColumn

                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.left:parent.left
                        anchors.leftMargin: 4
                        anchors.fill: parent
                        spacing: 20

                        SGAlignedLabel {
                            id: rightturnPeriodSetting
                            target: rightturnPeriodSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Period Setting(S):"
                            color:  "#000000"
                            SGSlider {
                                id: rightturnPeriodSet
                                width: rightturnColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 0.5
                                to: 16
                                stepSize: 0.1
                                //                                position: 1
                                //                                fromText: "0.5S"
                                //                                toText: "32S"
                            }
                        }

                        SGAlignedLabel {
                            id: rightturnCycleSetting
                            target: rightturnCycleSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Cycle Setting:"
                            color:  "#000000"
                            SGSlider {
                                id: rightturnCycleSet
                                width: rightturnColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 1
                                to: 32
                                stepSize: 1
                            }
                        }
                    }

                }

                Rectangle {
                    id: rightturnSwitchExitContainer
                    //                                        color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: rightturnSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            rightturn_has_button_clicked = false
                            rightturn_no_button_active = true
                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                        }
                    }
                }

                Rectangle {
                    id:rightturnSwitchSendContainer
                    //                                        color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: rightturnSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            if (rightturnSettingOneshot.checked)
                                platformInterface.commands.demo_right_turn.update( Number(  (rightturnCycleSet.value).toFixed(0) ),true, Number(   ((rightturnPeriodSet.value)*1000).toFixed(0)))
                            else
                                platformInterface.commands.demo_right_turn.update( Number(  (rightturnCycleSet.value).toFixed(0) ),false, Number(   ((rightturnPeriodSet.value)*1000).toFixed(0)))
                        }
                    }
                }

                SGSwitch {
                    id: rightturnSettingOneshot
                    width: rightturnSwitchSendContainer.width + 20
                    height:  width/3.5
                    anchors.horizontalCenter: rightturnSwitchSendContainer.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    handleColor: "#F0F8FF"
                    grooveColor: "#E6E6FA"
                    grooveFillColor: "#0cf"
                    //                    fontSizeMultiplier:  ratioCalc * 1.5
                    checked: true
                    checkedLabel: "<b>One Shot</b>"
                    uncheckedLabel: "<b>Off</b>"
                    textColor: "black"
                }

            }
        }
    }

    Item {
        id: warningSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/2.4
//        visible: true
        visible: false
        Rectangle {
            id: warningSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: warningSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent

                Rectangle {
                    id: warningColumnContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1

                    Column{
                        id:warningSettingColumn

                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.left:parent.left
                        anchors.leftMargin: 4
                        anchors.fill: parent
                        spacing: 20

                        SGAlignedLabel {
                            id: warningPeriodSetting
                            target: warningPeriodSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Period Setting(S):"
                            color:  "#000000"
                            SGSlider {
                                id: warningPeriodSet
                                width: warningColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 0.5
                                to: 16
                                stepSize: 0.1
                                //                                position: 1
                                //                                fromText: "0.5S"
                                //                                toText: "32S"
                            }
                        }

                        SGAlignedLabel {
                            id: warningCycleSetting
                            target: warningCycleSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Cycle Setting:"
                            color:  "#000000"
                            SGSlider {
                                id: warningCycleSet
                                width: warningColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 1
                                to: 32
                                stepSize: 1
                            }
                        }
                    }

                }

                Rectangle {
                    id: warningSwitchExitContainer
                    //                                        color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: warningSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            warning_has_button_clicked = false
                            warning_no_button_active = true
                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                        }
                    }
                }

                Rectangle {
                    id:warningSwitchSendContainer
                    //                                        color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: warningSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            if (warningSettingOneshot.checked)
                                platformInterface.commands.demo_warning.update( Number( (warningCycleSet.value).toFixed(0)),true, Number(  ((warningPeriodSet.value)*10).toFixed(0)))
                            else
                                platformInterface.commands.demo_warning.update( Number((warningCycleSet.value).toFixed(0)),false, Number( ((warningPeriodSet.value)*10).toFixed(0)))
                        }
                    }
                }

                SGSwitch {
                    id: warningSettingOneshot
                    width: warningSwitchSendContainer.width + 20
                    height:  width/3.5
                    anchors.horizontalCenter: warningSwitchSendContainer.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    handleColor: "#F0F8FF"
                    grooveColor: "#E6E6FA"
                    grooveFillColor: "#0cf"
                    //                    fontSizeMultiplier:  ratioCalc * 1.5
                    checked: true
                    checkedLabel: "<b>One Shot</b>"
                    uncheckedLabel: "<b>Off</b>"
                    textColor: "black"
                }

            }
        }
    }

    Item {
        id: fadingSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/2.4
//        visible: true
        visible: false
        Rectangle {
            id: fadingSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: fadingSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent

                Rectangle {
                    id: fadingColumnContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1

                    Column{
                        id:fadingSettingColumn

                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.left:parent.left
                        anchors.leftMargin: 4
                        anchors.fill: parent
                        spacing: 20

                        SGAlignedLabel {
                            id: fadingPeriodSetting
                            target: fadingPeriodSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Period Setting(S):"
                            color:  "#000000"
                            SGSlider {
                                id: fadingPeriodSet
                                width: fadingColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 0.5
                                to: 16
                                stepSize: 0.1
                          }
                        }

                        SGAlignedLabel {
                            id: fadingCycleSetting
                            target: fadingCycleSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0

                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "Cycle Setting:"
                            color:  "#000000"
                            SGSlider {
                                id: fadingCycleSet
                                width: fadingColumnContainer.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 1
                                to: 32
                                stepSize: 1
                            }
                        }
                    }

                }

                Rectangle {
                    id: fadingSwitchExitContainer
                    //                                        color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: fadingSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            fading_has_button_clicked = false
                            fading_no_button_active = true
                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                        }
                    }
                }

                Rectangle {
                    id:fadingSwitchSendContainer
                    //                                        color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: fadingSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            if (fadingSettingOneshot.checked)
                                platformInterface.commands.demo_fading.update( Number( (fadingCycleSet.value).toFixed(0)),true, Number( ((fadingPeriodSet.value)*10).toFixed(0)))
                            else
                                platformInterface.commands.demo_fading.update( Number( (fadingCycleSet.value).toFixed(0)),false,Number( ((fadingPeriodSet.value)*10).toFixed(0)))
                        }
                    }
                }

                SGSwitch {
                    id: fadingSettingOneshot
                    width: fadingSwitchSendContainer.width + 20
                    height:  width/3.5
                    anchors.horizontalCenter: fadingSwitchSendContainer.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    handleColor: "#F0F8FF"
                    grooveColor: "#E6E6FA"
                    grooveFillColor: "#0cf"
                    //                    fontSizeMultiplier:  ratioCalc * 1.5
                    checked: true
                    checkedLabel: "<b>One Shot</b>"
                    uncheckedLabel: "<b>Off</b>"
                    textColor: "black"
                }

            }
        }
    }

    Item {
        id: brakeSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/3
//        visible: true
               visible: false
        Rectangle {
            id: brakeSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: brakeSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent
//                opacity: 0.1

                Rectangle {
                    id: brakeSwitchContainer
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1
                    SGAlignedLabel {
                        id: brakePWMSetting
                        target: brakeStrengthSet
                        anchors.verticalCenter:  parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: 6

                        fontSizeMultiplier: ratioCalc * 1.2
                        font.bold : true
                        alignment: SGAlignedLabel.SideTopLeft
                        text: "PWM_DUTY:"
                        color:  "#000000"
                        SGSlider {
                            id: brakeStrengthSet
                            width: brakeSwitchContainer.width
                            fontSizeMultiplier: ratioCalc * 1.2
                            from: 0
                            to: 127
                            stepSize: 1
                      }
                    }
                }


                Rectangle {
                    id: brakeSwitchExitContainer
                    //                    color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: brakeSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            brake_has_button_clicked = false
                            brake_no_button_active = true

                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            fadingSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                      }
                    }
                }


                Rectangle {
                    id: brakeSwitchSendContainer
                    //                    color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: brakeSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                                 platformInterface.commands.demo_brake.update( Number( brakeStrengthSet.value.toFixed(0)))
                        }
                    }
                }

            }
        }

    }

    /**********************************************************************************************
    *                                Coding Debugging Here
    **********************************************************************************************/
    Item {
        id: pwmSettingContainer
        anchors.bottom: car.top
        anchors.bottomMargin:  25
        anchors.horizontalCenter: car.horizontalCenter
        width: car.width / 2.5
        height: width/2.4
//        visible: true
        visible: false
        Rectangle {
            id: pwmSettingBG
            color: "#F0FFFF"
            radius: 10
            anchors.fill: parent
            Rectangle {
                id: pwmSetting
                color: "#BCEE68"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent

                Rectangle {
                    id: pwmColumnContainer
//                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1

                    Rectangle{
                        id: line1
                        width: parent.width
                        height: (parent.height)/4
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top:  parent.top
                        //                        anchors.topMargin: 8
                        color: "transparent"
                        SGText {
                            id: pwmFrequencyText
                            text:" PWM Frequency(Hz):"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
//                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }

                    }


                    Rectangle{
                        id: line2
                        width: parent.width - 10
                        height: (parent.height)/5
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line1.bottom
                        anchors.topMargin: -6
                        color: "transparent"
                        ButttonStrip {
                            id: pwmSettingButtonStrip
                            width: parent.width
                            height: parent.height
//                            buttonColor: "#0cf"
                            buttonColor: "#E6E6FA"
//                            buttonColor: "#B0E2FF"
                            anchors.centerIn: parent.Center
                            model: ["150","300","600","1200"]
                            checkedIndices: 2
                            property int  cmd_pwm_freq:  300
                            onClicked: {
                                if(index === 0) {
                                    cmd_pwm_freq =  150
                                }
                                else if (index === 1){
                                    cmd_pwm_freq =  300
                                }
                                else if (index === 2){
                                    cmd_pwm_freq =  600
                                }
                                else  {
                                    cmd_pwm_freq =  1200
                                }
                            }

                        }

                    }

                    Rectangle{
                        id: line3
                        width: parent.width
                        height: (parent.height)/4
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line2.bottom
                        anchors.topMargin: 10
                        color: "transparent"

                        SGText {
                            id: pwmFrequencyMode
                            text:" PWM Mode:"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
//                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }

                        SGSwitch {
                            id:  pwmFrequencyModeSet
                            width: (parent.width -  pwmFrequencyMode.width)/1.6
                            height:  parent.height/1.4
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            handleColor: "#F0F8FF"
                            grooveColor: "#E6E6FA"
                            grooveFillColor: "#0cf"
                            checked: true
                            checkedLabel: "<b> Logarithmic </b>"
                            uncheckedLabel: "<b> Linear </b>"
                            textColor: "black"
                            property bool cmd_pwm_linear:  false
                            onToggled:  {
                                if (checked){
                                    cmd_pwm_linear =  false
                                }
                                else{
                                    cmd_pwm_linear = true
                                }
                            }
                        }

                    }

                    Rectangle{
                        id: line4
                        width: parent.width
                        height: (parent.height)/4
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line3.bottom
                        anchors.topMargin: 8
                        color: "transparent"

                        SGText {
                            id: pwmRecovery
                            text:" Auto Recovery:"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
//                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }

                        SGSwitch {
                            id:  pwmRecoverySet
//                            width: (parent.width -  pwmRecovery.width)/1.6
                            width: pwmFrequencyModeSet.width
                            height:  parent.height/1.4
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            handleColor: "#F0F8FF"
                            grooveColor: "#E6E6FA"
                            grooveFillColor: "#0cf"
                            //                    fontSizeMultiplier:  ratioCalc * 1.5
                            checked: false
                            checkedLabel: "<b> ON </b>"
                            uncheckedLabel: "<b> Off </b>"
                            textColor: "black"
                            property bool cmd_autor:  false
                            onToggled:  {
                                if (checked){
                                    cmd_autor = true
                                }
                                else{
                                    cmd_autor = false
                                }
                            }
                        }

                    }

                }


                Rectangle {
                    id: pwmSwitchExitContainer
                    //                                        color: "#00FF00"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.top:  parent.top
                    anchors.topMargin:  4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1

                    SGButton {
                        id: pwmSwitchExitButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Exit</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        //                        color: "#E0EEEE"
                        onClicked: {
                            setting_has_button_clicked = false
                            setting_no_button_active = true
                            button_active = false

                            welcomeSettingContainer.visible = false
                            brakeSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            leftturnSettingContainer.visible = false
                            rightturnSettingContainer.visible = false
                            warningSettingContainer.visible = false
                            pwmSettingContainer.visible = false
                            goodbyeSettingContainer.visible = false

                            welcome_mouse_area.enabled  = true
                            brake_mouse_area.enabled = true
                            fading_mouse_area.enabled  = true
                            leftturn_mouse_area.enabled  = true
                            rightturn_mouse_area.enabled  = true
                            warning_mouse_area.enabled  = true
                            setting_mouse_area.enabled  = true
                            goodbye_mouse_area.enabled  = true
                        }
                    }
                }

                Rectangle {
                    id:pwmSwitchSendContainer
                    //                                        color: "#0000FF"
                    color: "transparent"
                    width: parent.width/4
                    height:  width/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    opacity: 1
                    SGButton {
                        id: pwmSwitchSentButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        alternativeColorEnabled: true
                        text: "<b>Send</b>"
                        fontSizeMultiplier: ratioCalc * 2
                        color: "#00CD66"
                        onClicked: {
                            platformInterface.commands.pwm_setting.update(pwmRecoverySet.cmd_autor,pwmSettingButtonStrip.cmd_pwm_freq,pwmFrequencyModeSet.cmd_pwm_linear)
                        }
                    }
                }



            }
        }

    }


    Item {
        id: dashboardcontainer
        x: parent.width* 0.1; y : parent.height - car.height * 0.635
        width: car.width * 0.78
        height: car.height * 0.47
        Rectangle {
            id: dashboard
            color: "transparent"
            //            color: "#0000FF"
            anchors.fill: parent

            Image {
                id: welcome_button
                width: welcome_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: welcome_no_button_active? "images/welcome.png" :(welcome_has_button_clicked ? "images/welcome_clicked.png" : "images/welcome_hovered.png")
                //                border.color: Qt.lighter(parent.color)
                fillMode: Image.PreserveAspectFit
                focus: true
                smooth: true

                MouseArea {
                    id: welcome_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {
                        welcome_no_button_active = false ;
                        button_active = true
//                        welcomeSettingContainer.visible = true
                    }
                    onExited: {
                        welcome_no_button_active = (welcome_has_button_clicked ? false : true)
                        button_active = false
//                        welcomeSettingContainer.visible = false
                    }
                    onClicked: {
                        button_active = true
                        welcome_no_button_active = false
                        welcome_has_button_clicked = true

                        welcomeSettingContainer.visible = true    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = false

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false

//                        welcome_timer.start();
                    }
                }

//                Timer {
//                    id: welcome_timer;
//                    interval: 6000;
//                    repeat: false;
//                    //                    triggeredOnStart: true;
//                    onTriggered:{
//                        welcome_timer.stop();
//                        welcome_has_button_clicked = false
//                        welcome_no_button_active = true

//                        button_active = false
//                        welcome_mouse_area.hoverEnabled = true
//                        brake_mouse_area.hoverEnabled = true
//                        fading_mouse_area.hoverEnabled = true
//                        leftturn_mouse_area.hoverEnabled = true
//                        rightturn_mouse_area.hoverEnabled = true
//                        warning_mouse_area.hoverEnabled = true
//                        setting_mouse_area.hoverEnabled = true
//                        goodbye_mouse_area.hoverEnabled = true
//                    }
//                }
            }

            Image {
                id: brake_button
                width: brake_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.left: welcome_button.right
                anchors.leftMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: brake_no_button_active? "images/brake.png" :(brake_has_button_clicked ? "images/brake_clicked.png" : "images/brake_hovered.png")
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: brake_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  brake_no_button_active = false ; button_active = true }
                    onExited: { brake_no_button_active = (brake_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        button_active = true
                        brake_no_button_active = false
                        brake_has_button_clicked = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = true
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = false

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }
            }


            Image {
                id: fading_button
                width: fading_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.left: brake_button.right
                anchors.leftMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: fading_no_button_active? "images/fading.png" :(fading_has_button_clicked ? "images/fading_clicked.png" : "images/fading_hovered.png")
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: fading_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  fading_no_button_active = false ; button_active = true  }
                    onExited: { fading_no_button_active = (fading_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        button_active = true
                        fading_no_button_active = false
                        fading_has_button_clicked = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = true
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = false

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }
            }

            Image {
                id: leftturn_button
                width: leftturn_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.left: fading_button.right
                anchors.leftMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: leftturn_no_button_active? "images/leftturn.png" : (leftturn_has_button_clicked ? "images/leftturn_clicked.png" : "images/leftturn_hovered.png" )
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: leftturn_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  leftturn_no_button_active = false ;  button_active = true  }
                    onExited: { leftturn_no_button_active = (leftturn_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        leftturn_no_button_active = false
                        leftturn_has_button_clicked = true
                        button_active = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = true
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = false

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }
           }

            Image {
                id: rightturn_button
                width: rightturn_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.right:  warning_button.left
                anchors.rightMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: rightturn_no_button_active? "images/rightturn.png" :(rightturn_has_button_clicked ? "images/rightturn_clicked.png" : "images/rightturn_hovered.png")
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: rightturn_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  rightturn_no_button_active = false  ; button_active = true }
                    onExited: { rightturn_no_button_active = (rightturn_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        button_active = true
                        rightturn_no_button_active = false
                        rightturn_has_button_clicked = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = true
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = false

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }

            }

            Image {
                id: warning_button
                width: warning_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.right:  setting_button.left
                anchors.rightMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: warning_no_button_active? "images/warning.png" :(warning_has_button_clicked ? "images/warning_clicked.png" : "images/warning_hovered.png")
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: warning_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  warning_no_button_active = false ;button_active = true }
                    onExited: { warning_no_button_active = (warning_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        button_active = true
                        warning_no_button_active = false
                        warning_has_button_clicked = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = true
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = false

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }
            }

            Image {
                id: setting_button
                width: setting_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.right:  goodbye_button.left
                anchors.rightMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: setting_no_button_active? "images/setting.png" :(setting_has_button_clicked ? "images/setting_clicked.png" : "images/setting_hovered.png")
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: setting_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  setting_no_button_active = false ;button_active = true }
                    onExited: { setting_no_button_active = (setting_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        button_active = true
                        setting_no_button_active = false
                        setting_has_button_clicked = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = true
                        goodbyeSettingContainer.visible = true

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }

            }

            Image {
                id: goodbye_button
                width: goodbye_no_button_active ? (parent.width-36)/9  :  (parent.width-36)/4.5
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                source: goodbye_no_button_active? "images/goodbye.png" :(goodbye_has_button_clicked ? "images/goodbye_clicked.png" : "images/goodbye_hovered.png")
                fillMode: Image.PreserveAspectFit
                focus: true

                MouseArea {
                    id: goodbye_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true;
                    onEntered: {  goodbye_no_button_active = false ;  button_active = true }
                    onExited: { goodbye_no_button_active = (goodbye_has_button_clicked ? false : true)
                        button_active = false
                    }
                    onClicked: {
                        button_active = true
                        goodbye_no_button_active = false
                        goodbye_has_button_clicked = true

                        welcomeSettingContainer.visible = false    //To be Done
                        brakeSettingContainer.visible = false
                        fadingSettingContainer.visible = false
                        leftturnSettingContainer.visible = false
                        rightturnSettingContainer.visible = false
                        warningSettingContainer.visible = false
                        pwmSettingContainer.visible = false
                        goodbyeSettingContainer.visible = true

                        welcome_mouse_area.enabled  = false
                        brake_mouse_area.enabled = false
                        fading_mouse_area.enabled  = false
                        leftturn_mouse_area.enabled  = false
                        rightturn_mouse_area.enabled  = false
                        warning_mouse_area.enabled  = false
                        setting_mouse_area.enabled  = false
                        goodbye_mouse_area.enabled  = false
                    }
                }
            }

        }

    }  // END dashboardcontainer

} //END


