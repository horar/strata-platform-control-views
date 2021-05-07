﻿import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/sgwidgets"
import "qrc:/images"
import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.sgwidgets 0.9 as Widget09

Item {
    id: root
    property bool state: false
    property string warningVin: multiplePlatform.warningHVVinLable
    property string vinlable: ""
    property string labelTest: ""
    property real ratioCalc: root.width / 1200

    // property that reads the initial notification
    property var temp_calc: platformInterface.status_temperature_sensor.temperature
    property var vin_calc: platformInterface.status_voltage_current.vin/1000
    property var iin_calc: platformInterface.status_voltage_current.iin
    property var vout_calc: platformInterface.status_voltage_current.vout/1000
    property var iout_calc: platformInterface.status_voltage_current.iout

    property var pin_calc: vin_calc * iin_calc * 1000
    property var pout_calc: vout_calc * iout_calc * 1000
    property var effi_calc: ((pout_calc * 100) / pin_calc).toFixed(3)

    // property that reads the initial notification
    property string read_enable_state: platformInterface.initial_status.enable_status
    onRead_enable_stateChanged: {
        if(read_enable_state === "on") {
            platformInterface.enabled = true
            platformInterface.pause_periodic = false
        }
        else  {
            platformInterface.enabled = false
            platformInterface.pause_periodic = true
        }
    }

    property string read_vin_mon: {platformInterface.status_voltage_current.vin}
    onRead_vin_monChanged: {

        platformInterface.enabled = true

        if(multiplePlatform.minVin > ((platformInterface.status_voltage_current.vin)/1000)) {
            ledLight.status = "red"
            vinlable = "under"
            ledLight.label = "VIN NOT Ready < "+ multiplePlatform.minVin +"V"

            dio12Switch.enabled  = true
            dio12Switch.opacity = 1.0
        }

        else if(multiplePlatform.nominalVin < ((platformInterface.status_voltage_current.vin)/1000)) {
            dio12Switch.checked = false
            ledLight.status = "red"
            vinlable = "under"
            ledLight.label = "VIN NOT Ready > "+ multiplePlatform.nominalVin +"V"
            dio12Switch.enabled  = false
            dio12Switch.opacity = 0.2
            platformInterface.set_dio12.update("off")
        }

        else {
            ledLight.status = "green"
            vinlable = "over"
            ledLight.label = "VIN Ready"

            dio12Switch.enabled  = true
            dio12Switch.opacity = 1.0
        }
    }

    Component.onCompleted:  {
        multiplePlatform.check_class_id()
        Help.registerTarget(navTabs, "These tabs switch between Basic, Advanced, Settings/Control and Data Logger/Export views.", 0, "basicHelp")
        Help.registerTarget(ledLight, "The LED will light up green when input voltage is ready and lower than" + " "+ multiplePlatform.nominalVin +"V.It will light up red when greater than "+ " "+ multiplePlatform.nominalVin + "V to warn the user that input voltage is too high.", 1, "basicHelp")
        Help.registerTarget(inputVoltage,"Input voltage is shown here in Volts.", 2 , "basicHelp")
        Help.registerTarget(inputCurrent,"Input current is shown here in milliamps.", 3 , "basicHelp")
        Help.registerTarget(basicImage, "The center image shows the board configuration.", 4, "basicHelp")
        Help.registerTarget(dimmensionalModeSpace, "Dimmensional space mode for the center image.", 5, "basicHelp")
        Help.registerTarget(dio12Switch, "This switch enables or disables DIO12.", 6, "basicHelp")
        Help.registerTarget(outputCurrent,"Output current is shown here in milliamps.", 7, "basicHelp")
        Help.registerTarget(outputVoltage,"Output voltage is shown here in Volts.", 8, "basicHelp")
        Help.registerTarget(operationModeControl, "These are two modes to control the system. In Load Transient mode, PWM signal will be set by the slider above. In Normal mode, the system will go through a particular PWM signal profile.", 9 , "basicHelp")

    }

    FontLoader {
        id: icons
        source: "sgwidgets/fonts/sgicons.ttf"
    }

    Rectangle{
        anchors.fill: parent
        width : parent.width
        height: parent.height


        Rectangle {
            id: pageLable
            width: parent.width/2
            height: parent.height/ 12
            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: pageText
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                text:  multiplePlatform.partNumber
                font.pixelSize: (parent.width + parent.height)/ 25
                color: "black"
            }

            Text {
                id: pageText2
                anchors {
                    top: pageText.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: multiplePlatform.title
                font.pixelSize: (parent.width + parent.height)/ 25
                color: "grey"
            }

            Text {
                id: pageText3
                anchors {
                    top: pageText2.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: "Digital Universal Intermediate Bus Controller with PMBus"
                font.pixelSize: (parent.width + parent.height)/ 25
                color: "grey"
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height - parent.height/12
            anchors{
                top: pageLable.bottom
                topMargin: 100
                left: parent.left
                leftMargin: 20
                right: parent.right
                rightMargin: 20
            }

            Rectangle {
                id:left
                width: parent.width/5
                height: parent.height - parent.height/3
                anchors {
                    top:parent.top
                    topMargin: -parent.height/10
                    left: parent.left
                    leftMargin: 0
                }
                color: "transparent"
                border.color: "transparent"
                border.width: 5
                radius: 10

                Rectangle {
                    id: textContainer2
                    width: parent.width/3
                    height: parent.height/10

                    anchors {
                        top: parent.top
                        topMargin: 20
                        horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: containerLabel2
                        text: "Input"
                        anchors{
                            fill: parent
                            centerIn: parent
                        }
                        font.pixelSize: height/1.5
                        font.bold: true
                    }

                }
                Rectangle {
                    id: line
                    height: 2
                    width: parent.width

                    anchors {
                        top: textContainer2.bottom
                        topMargin: 2
                        left: parent.left
                        leftMargin: 5
                    }
                    border.color: "grey"
                    radius: 2
                }
                SGStatusLight {
                    id: ledLight
                    label: "VIN Ready < "+ multiplePlatform.nominalVin +"V"
                    anchors {
                        top : line.bottom
                        topMargin : 40
                        horizontalCenter: parent.horizontalLeft
                    }
                    width: parent.width
                    height: parent.height/10
                    lightSize: (parent.width + parent.height)/23
                    fontSize:  (parent.width + parent.height)/40

                    property string vinMonitor: {platformInterface.status_voltage_current.vin}
                    onVinMonitorChanged:  {
                        if(multiplePlatform.minVin > ((platformInterface.status_voltage_current.vin)/1000)) {
                            ledLight.status = "red"
                            vinlable = "under"
                            ledLight.label = "VIN NOT Ready < "+ multiplePlatform.minVin +"V"
                        }
                        else if(multiplePlatform.nominalVin < ((platformInterface.status_voltage_current.vin)/1000)) {
                            ledLight.status = "red"
                            vinlable = "under"
                            ledLight.label = "VIN NOT Ready > "+ multiplePlatform.nominalVin +"V"
                        }
                        else {
                            ledLight.status = "green"
                            vinlable = "over"
                            ledLight.label = "VIN Ready"
                        }
                    }
                }

                SGLabelledInfoBox {
                    id: inputVoltage
                    label: ""
                    info: ((platformInterface.status_voltage_current.vin)/1000).toFixed(3)

                    infoBoxColor: if (multiplePlatform.nominalVin < ((platformInterface.status_voltage_current.vin)/1000)) {"red"}
                                  else{"lightgrey"}
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: "V"
                    infoBoxWidth: parent.width/1.5
                    infoBoxHeight : parent.height/12
                    fontSize :  (parent.width + parent.height)/37
                    unitSize: (parent.width + parent.height)/35
                    anchors {
                        top : ledLight.bottom
                        topMargin : parent.height/15
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  (width - inputCurrent.width)/2
                    }
                }

                SGLabelledInfoBox {
                    id: inputCurrent
                    label: ""
                    info: ((platformInterface.status_voltage_current.iin)/1000).toFixed(3)

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: "A"
                    infoBoxWidth: parent.width/1.5
                    infoBoxHeight :  parent.height/12
                    fontSize :   (parent.width + parent.height)/37
                    unitSize: (parent.width + parent.height)/35
                    anchors {
                        top : inputVoltage.bottom
                        topMargin : parent.height/15
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                SGCircularGauge {
                    id: tempGauge
                    anchors {
                        top: inputCurrent.bottom
                        topMargin: parent.height/50
                        horizontalCenter: parent.center
                    }

                    width: (parent.width + parent.height)/3
                    height: (parent.width + parent.height)/3
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: -55
                    maximumValue: 150
                    tickmarkStepSize: 20
                    outerColor: "#999"
                    unitLabel: "°C"
                    gaugeTitle: "Temperature"
                    value: temp_calc
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                Rectangle {
                    id: warningBox2
                    color: "red"
                    radius: 10
                    anchors {
                        top: tempGauge.bottom
                        topMargin: parent.height/20
                        horizontalCenter: parent.horizontalLeft
                        horizontalCenterOffset: parent.width/20
                    }
                    width: parent.width
                    height: parent.height/10

                    Text {
                        id: warningText2
                        anchors {
                            centerIn: warningBox2
                        }
                        text: "<b>Max. input voltage "+ multiplePlatform.nominalVin +"V</b>"
                        font.pixelSize: ratioCalc * 12
                        color: "white"
                    }

                    Text {
                        id: warningIconleft
                        anchors {
                            right: warningText2.left
                            verticalCenter: warningText2.verticalCenter
                            rightMargin: 5
                        }
                        text: "\ue80e"
                        font.family: icons.name
                        font.pixelSize: (parent.width + parent.height)/19
                        color: "white"
                    }

                    Text {
                        id: warningIconright
                        anchors {
                            left: warningText2.right
                            verticalCenter: warningText2.verticalCenter
                            leftMargin: 5
                        }
                        text: "\ue80e"
                        font.family: icons.name
                        font.pixelSize: (parent.width + parent.height)/19
                        color: "white"
                    }
                }
            }

            Rectangle {
                id: gauge
                width: (3*parent.width/5)
                height: parent.height - parent.height/3
                anchors{
                    left: left.right
                    top:parent.top
                    topMargin: parent.height/20
                }

                Image {
                    id:basicImage
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.width
                    source:{
                        if(multiplePlatform.eeprom_ID === "d4937f24-219a-4648-a711-2f6e902b6f1c" && platformInterface.dimmensionalMode === true) {"images/quarter_brick_3D.gif"}
                        else if(multiplePlatform.eeprom_ID === "d4937f24-219a-4648-a711-2f6e902b6f1c" && platformInterface.dimmensionalMode === false) {"images/quarter_brick_2D.gif"}
                    }
                    width: parent.width - parent.width/20
                    height: parent.height + (parent.height/6)
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    mipmap:true
                    opacity:1
                }

                Image {
                    id:basicImageLed
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.width
                    source: "images/led_3d.gif"
                    width: parent.width - parent.width/20
                    height: parent.height - 20
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    mipmap:true
                    visible: platformInterface.pause_periodic === false && platformInterface.dimmensionalMode === true ? true : false
                }

                SGRadioButtonContainer {
                    id: dimmensionalModeSpace
                    anchors {
                        top: basicImage.top
                        topMargin: -parent.height/10
                        horizontalCenter: basicImage.horizontalCenter
                    }
                    labelLeft: false
                    exclusive: true

                    radioGroup: GridLayout {
                        columnSpacing: 10
                        rowSpacing: 10
                        // Optional properties to access specific buttons cleanly from outside
                        property alias twoDimmensional : twoDimmensional
                        property alias threeDimmensional: threeDimmensional

                        SGRadioButton {
                            id: threeDimmensional
                            text: "3D"
                            checked: platformInterface.dimmensionalMode
                            onCheckedChanged: {
                                if (checked) {
                                    console.log("3D")
                                    platformInterface.dimmensionalMode = true
                                }
                                else {
                                    console.log("Top")
                                    platformInterface.dimmensionalMode = false
                                }
                            }
                        }

                        SGRadioButton {
                            id: twoDimmensional
                            text: "Top"
                            checked : !threeDimmensional.checked
                        }
                    }
                }

            }

            Rectangle {
                id:right
                width: parent.width/5
                height: parent.height - parent.height/3
                anchors {
                    top:parent.top
                    topMargin: -parent.height/10
                    left: gauge.right
                    right: parent.right
                    rightMargin: 0
                }
                color: "transparent"
                border.color: "transparent"
                border.width: 5
                radius: 10

                Rectangle {
                    id: textContainer
                    width: parent.width/3
                    height: parent.height/10
                    anchors {
                        top: parent.top
                        topMargin: 20
                        horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: containerLabel
                        text: "Output"
                        anchors{
                            fill: parent
                            centerIn: parent
                        }
                        font.pixelSize: height/1.5
                        font.bold: true
                    }
                }

                Rectangle {
                    id: line2
                    height: 2
                    width: parent.width - 9

                    anchors {
                        top: textContainer.bottom
                        topMargin: 2
                        left: parent.left
                        leftMargin: 5
                    }
                    border.color: "grey"
                    radius: 2
                }

                SGSwitch {
                    id: dio12Switch
                    anchors {
                        top: line2.bottom
                        topMargin :  parent.height/10
                        horizontalCenter: parent.horizontalCenter
                    }
                    label : "Enable"
                    switchWidth: parent.width/4
                    switchHeight: parent.height/15
                    textColor: "black"
                    handleColor: "white"
                    grooveColor: "#ccc"
                    grooveFillColor: "green"
                    fontSizeLabel: (parent.width + parent.height)/37
                    checked: if (multiplePlatform.vinScale > ((platformInterface.status_voltage_current.vin)/1000)) {dio12Switch.checked}
                             else{platformInterface.set_dio12.update("off")}
                    onToggled: if (multiplePlatform.vinScale > ((platformInterface.status_voltage_current.vin)/1000)) {
                                   platformInterface.dio12_enabled = checked
                                   if(checked){
                                       platformInterface.set_dio12.update("on")
                                   }
                                   else{
                                       platformInterface.set_dio12.update("off")
                                   }
                               }
                               else{platformInterface.set_dio12.update("off")}
                            }

                SGLabelledInfoBox {
                    id: outputVoltage
                    label: ""
                    info: ((platformInterface.status_voltage_current.vout)/1000).toFixed(3)

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: "V"
                    infoBoxWidth: parent.width/1.5
                    infoBoxHeight : parent.height/12
                    fontSize :  (parent.width + parent.height)/37
                    unitSize: (parent.width + parent.height)/35

                    anchors {
                        top : dio12Switch.bottom
                        topMargin : parent.height/15
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  10
                    }
                }

                SGLabelledInfoBox {
                    id: outputCurrent
                    label: ""
                    info: ((platformInterface.status_voltage_current.iout)/1000).toFixed(3)

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: "A"
                    infoBoxWidth: parent.width/1.5
                    infoBoxHeight :  parent.height/12
                    fontSize :   (parent.width + parent.height)/37
                    unitSize: (parent.width + parent.height)/35
                    anchors {
                        top : outputVoltage.bottom
                        topMargin : parent.height/15
                        horizontalCenter: outputVoltage.horizontalCenter
                        horizontalCenterOffset:  0
                    }
                }

                SGCircularGauge {
                    id: effiGauge
                    anchors {
                        top: outputCurrent.bottom
                        topMargin: parent.height/50
                        horizontalCenter: parent.center
                    }

                    width: (parent.width + parent.height)/3
                    height: (parent.width + parent.height)/3
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: 100
                    tickmarkStepSize: 10
                    outerColor: "#999"
                    unitLabel: "%"
                    gaugeTitle: "Efficiency"
                    value: effi_calc
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                SGRadioButtonContainer {
                    id: operationModeControl
                    anchors {
                        top: effiGauge.bottom
                        topMargin: parent.height/50
                        left: parent.left
                        leftMargin: parent.height/100
                    }

                    label: "<b>Operation Mode:</b>"
                    labelLeft: false
                    exclusive: true

                    radioGroup: GridLayout {
                        columnSpacing: 5
                        rowSpacing: 5
                        // Optional properties to access specific buttons cleanly from outside
                        property alias manual : manual
                        property alias automatic: automatic

                        SGRadioButton {
                            id: manual
                            text: "Normal"
                            checked: platformInterface.systemMode
                            onCheckedChanged: {
                                if (checked) {
                                    console.log("manual")
                                    platformInterface.systemMode = true
                                }
                                else {
                                    console.log("automatic")
                                    platformInterface.systemMode = false
                                    platformInterface.frequency = 0
                                    platformInterface.duty = 0
                                }
                            }
                        }

                        SGRadioButton {
                            id: automatic
                            text: "Transient"
                            checked : !manual.checked
                        }
                    }
                }
            }
        }
    }
}


