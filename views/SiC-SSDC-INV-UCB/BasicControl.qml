import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import tech.strata.sgwidgets 0.9 as Widget09
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/sgwidgets"
import "qrc:/image"
import "qrc:/js/help_layout_manager.js" as Help

Item {
    id: root

    property bool state: false
    property string warningVin: multiplePlatform.warningHVVinLable
    property string vinlable: ""
    property string labelTest: ""
    property real ratioCalc: root.width / 1200

    // property that reads the initial notification
    property var target_speed: platformInterface.status_vi.t
    property var actual_speed: platformInterface.status_vi.a
    property var dc_link_vin_calc: platformInterface.status_vi.l
    property var winding_iout_iu_calc: platformInterface.status_vi.u
    property var winding_iout_iv_calc: platformInterface.status_vi.v
    property var winding_iout_iw_calc: platformInterface.status_vi.w
    property var temp_U_calc: platformInterface.status_vi.U
    property var temp_V_calc: platformInterface.status_vi.V
    property var temp_W_calc: platformInterface.status_vi.W

    property var time: settingsControl.time
    property var pointsCount: settingsControl.pointsCount
    property var amperes: settingsControl.amperes
    property var acceleration: settingsControl.acceleration
    property var pole_pairs: settingsControl.pole_pairs
    property var max_motor_vout: settingsControl.max_motor_vout
    property var max_motor_speed: settingsControl.max_motor_speed
    property var resistance: (settingsControl.resistance/100).toFixed(2)
    property var inductance: (settingsControl.inductance/1000).toFixed(3)
    property var target: settingsControl.target.toFixed(0)

    property var error_status: platformInterface.error.value
    property string error_code
    property string status_code

    property var motor_play: 0

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

    property string read_vin_mon: dc_link_vin_calc
    onRead_vin_monChanged: {
        platformInterface.enabled = true

        if(multiplePlatform.minVin > dc_link_vin_calc) {
            status_code = "Vin Low < "+ multiplePlatform.minVin +"V"
            ledLight.status = "red"
            vinlable = "under"
            ledLight.label = "Vin Low < "+ multiplePlatform.minVin +"V"
            motor_ENSwitch.enabled  = false
            motor_ENSwitch.opacity = 0.2
        }

        else if(multiplePlatform.nominalVin < dc_link_vin_calc) {
            status_code = "Vin High > "+ multiplePlatform.nominalVin +"V"
            ledLight.status = "red"
            vinlable = "under"
            ledLight.label = "Vin High > "+ multiplePlatform.nominalVin +"V"
            motor_ENSwitch.enabled  = false
            motor_ENSwitch.opacity = 0.2
        }

        else{
            if (motor_play === 1){
                status_code = "Vin OK"
            }
            motor_ENSwitch.opacity = 1
            motor_ENSwitch.enabled = true
        }
    }

    onMotor_playChanged: {
        if (motor_play === 1){
            status_code = ""
        }
    }

    onError_statusChanged: {
        if(error_status === 0){error_code = "NO ERROR"}
        else if(error_status === 1){error_code = "ADC THRESHOLD OUTSIDE RANGE"}
        //else if(error_status === 2){error_code = "STARTUP CURRENT INJECTION ERROR"}
        //else if(error_status === 3){error_code = "STARTUP CURRENT INJECTION2 ERROR"}
        else if(error_status === 4){error_code = "UNDERVOLTAGE"}
        else if(error_status === 5){error_code = "OVERVOLTAGE"}
        else if(error_status === 6){error_code = "OVER TEMPERATURE"}
        else if(error_status === 7){error_code = "OVERCURRENT PROTECTION ACTIVE"}
        else if(error_status === 8){error_code = "WATCHDOG RESET"}
        else {error_code = ""}
        if (error_status > 0) {status_code = "Reset error to continue"}
    }

    Component.onCompleted:  {
        multiplePlatform.check_class_id()

        Help.registerTarget(navTabs, "These tabs switch between Basic MDK, Advanced MDK, MDK Settings and MDK Data Logger/Export, Default settings and Pulse Testing views.", 0, "basicHelp")

        Help.registerTarget(motor_ENSwitch, "This switch enables or disables motor. The switch will be enabled when input voltage is ready and lower than" + " "+ multiplePlatform.nominalVin +"V. It will be dissabled when input voltage is lower than "+ " "+ multiplePlatform.minVin + "V to warn the user that input voltage is too low.", 1, "basicHelp")
        Help.registerTarget(dc_link_vinVoltage,"DC link voltage is shown here", 2, "basicHelp")
        Help.registerTarget(ledLight, "The LED will light up green when input voltage is ready and lower than" + " "+ multiplePlatform.nominalVin +"V.It will light up red when greater than "+ " "+ multiplePlatform.nominalVin + "V to warn the user that input voltage is too high.", 3, "basicHelp")
        Help.registerTarget(boardTemperature, "Average Temperature of the board is shown here", 4, "basicHelp")

        Help.registerTarget(gauge,"Settings parameters are shown here.", 5, "basicHelp")
        Help.registerTarget(labelledInfoBox,"Error messages are shown here.", 6, "basicHelp")

        Help.registerTarget(actualSpeed,"Actual speed is shown here.", 7, "basicHelp")
        Help.registerTarget(iout_u, "Motor winding current, I1 is plotted in real time", 8, "basicHelp")
        Help.registerTarget(iout_v, "Motor winding current, I2 is plotted in real time", 9, "basicHelp")
        Help.registerTarget(iout_w, "Motor winding current, I3 is plotted in real time", 10, "basicHelp")

        Help.registerTarget(statusInfoBoxWidget,"Status messages are shown here.", 11, "basicHelp")
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
                text:  multiplePlatform.title
                font.pixelSize: (parent.width + parent.height)/ 25
                color: "black"
            }

            Text {
                id: pageText2
                anchors {
                    top: pageText.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: multiplePlatform.partNumber
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
                width: parent.width/4.5
                height: parent.height - parent.height/3
                anchors {
                    top:parent.top
                    topMargin: parent.height/100
                    left: parent.left
                    leftMargin: (parent.width/25)
                }
                color: "transparent"
                border.color: "black"
                border.width: 2
                radius: 10

                Rectangle {
                    id: textContainer2
                    width: parent.width/3
                    height: parent.height/10

                    anchors {
                        top: parent.top
                        topMargin: parent.height/100
                        horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: containerLabel2
                        text: "Input"
                        anchors{
                            fill: parent
                            centerIn: parent
                            horizontalCenter: parent.horizontalCenter
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
                        topMargin: parent.height/200
                        left: parent.left
                    }
                    border.color: "grey"
                    radius: 2
                }

                SGSwitch {
                    id: motor_ENSwitch
                    anchors {
                        top: line.bottom
                        topMargin :  parent.height/30
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  -parent.width/7
                    }

                    label : "Enable"
                    switchWidth: parent.width/5            // Default: 52 (change for long custom checkedLabels when labelsInside)
                    switchHeight: parent.height/20              // Default: 26
                    textColor: "black"              // Default: "black"
                    handleColor: "white"            // Default: "white"
                    grooveColor: "#ccc"             // Default: "#ccc"
                    grooveFillColor: "green"         // Default: "#0cf"
                    fontSizeLabel: (parent.width + parent.height)/37
                    checked: if (multiplePlatform.nominalVin > dc_link_vin_calc) {motor_ENSwitch.checked}
                             else{
                                 platformInterface.set_motor_EN.update("off")
                             }
                    onToggled: {
                        if (multiplePlatform.nominalVin > dc_link_vin_calc) {
                                   platformInterface.motor_EN_enabled = checked
                                   if(checked){
                                       platformInterface.set_motor_EN.update("on")
                                       motor_play = 1
                                   }
                                   else{
                                       platformInterface.set_motor_EN.update("off")
                                       motor_play = 0
                                   }
                               }
                               else{
                                   platformInterface.set_motor_EN.update("off")
                                   motor_play = 0
                               }
                            }
                        }

                SGCircularGauge {
                    id: dc_link_vinVoltage
                    anchors {
                        top : motor_ENSwitch.bottom
                        topMargin : parent.height/60
                        horizontalCenter: parent.horizontalCenter
                    }

                    width: parent.width/1.05
                    height: parent.height/2.8
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: multiplePlatform.vinScale
                    tickmarkStepSize: 50
                    outerColor: "#999"
                    unitLabel: "V"
                    gaugeTitle: "DC Link"
                    value: dc_link_vin_calc
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                SGStatusLight {
                    id: ledLight
                    label: "Vin OK < "+ multiplePlatform.nominalVin +"V"
                    anchors {
                        top : dc_link_vinVoltage.bottom
                        topMargin : -parent.height/40
                        right: parent.right
                        rightMargin: -parent.width/10
                    }
                    width: parent.width
                    height: parent.height/10
                    lightSize: (parent.width + parent.height)/25
                    fontSize:  (parent.width + parent.height)/40

                    property string vinMonitor: {platformInterface.status_vi.l}
                    onVinMonitorChanged:  {
                        if(multiplePlatform.minVin > dc_link_vin_calc) {
                            ledLight.status = "red"
                            vinlable = "under"
                            ledLight.label = "Vin Low < "+ multiplePlatform.minVin +"V"
                        }
                        else if(multiplePlatform.nominalVin < dc_link_vin_calc) {
                            ledLight.status = "red"
                            vinlable = "under"
                            ledLight.label = "Vin High > "+ multiplePlatform.nominalVin +"V"
                        }
                        else {
                            ledLight.status = "green"
                            vinlable = "over"
                            ledLight.label = "Vin OK"
                        }
                    }
                }

                SGCircularGauge {
                    id: boardTemperature
                    anchors {
                        top : ledLight.bottom
                        topMargin : -parent.height/30
                        horizontalCenter: parent.horizontalCenter
                    }

                    width: parent.width/1.05
                    height: parent.height/2.8
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: 200
                    tickmarkStepSize: 10
                    outerColor: "#999"
                    unitLabel: "°C"
                    gaugeTitle: "Average Temperature"
                    value: (temp_U_calc + temp_V_calc + temp_W_calc)/3
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                Rectangle {
                    id: warningBox2
                    color: "red"
                    radius: 10
                    anchors {
                        top: boardTemperature.bottom
                        topMargin: parent.height/15
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
                            rightMargin: parent.width/100
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
                width: (parent.width/3)
                height: parent.height - parent.height/3
                anchors{
                    left: left.right
                    top:parent.top
                    topMargin: parent.height/100
                    leftMargin: (parent.width/15)
                }

                color: "transparent"
                border.color: "black"
                border.width: 2
                radius: 10

                Rectangle {
                    id: textContainerControl
                    width: parent.width/3
                    height: parent.height/10

                    anchors {
                        top: parent.top
                        topMargin: parent.height/100
                        horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        id: containerLabelControl
                        text: "Parameters"
                        anchors{
                            fill: parent
                            horizontalCenter: parent.horizontalCenter
                        }
                        font.pixelSize: height/1.5
                        font.bold: true
                    }
                }

                Rectangle {
                    id: lineControl
                    height: 2
                    width: parent.width

                    anchors {
                        top: textContainerControl.bottom
                        topMargin: parent.height/200
                        left: parent.left
                    }
                    border.color: "grey"
                    radius: 2
                }

                SGLabelledInfoBox {
                    id: targetSpeed
                    label: "Target (RPM)"
                    info: target

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : lineControl.bottom
                        topMargin : parent.height/25
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: laAcceleration
                    label: "Acceleration (RPM/s)"
                    info: acceleration

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : targetSpeed.bottom
                        topMargin : parent.height/20
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: laPole_pairs
                    label: "Pole pairs"
                    info: pole_pairs

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : laAcceleration.bottom
                        topMargin : parent.height/20
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: laMax_motor_vout
                    label: "Max motor Vout (V)"
                    info: max_motor_vout

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : laPole_pairs.bottom
                        topMargin : parent.height/20
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: laMax_motor_speed
                    label: "Max motor speed (RPM)"
                    info: max_motor_speed

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : laMax_motor_vout.bottom
                        topMargin : parent.height/20
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: laResistance
                    label: "Resistance (Ohms)"
                    info: resistance

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : laMax_motor_speed.bottom
                        topMargin : parent.height/20
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: laInductance
                    label: "Inductance (Henry)"
                    info: inductance

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/2.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : laResistance.bottom
                        topMargin : parent.height/20
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                Rectangle {
                    id: logInfoBox
                    color: "transparent"; width: parent.width*0.5; height: parent.height
                    Text {
                        id: nameLogInfoBox
                        text: "Error message"
                        anchors {
                            top : parent.bottom
                            topMargin : parent.height/80
                            left: parent.left
                            leftMargin: 0
                        }
                        font.pixelSize: 20
                        color: "black"
                    }

                    Widget09.SGLabelledInfoBox {
                        id: labelledInfoBox
                        infoBoxWidth: (parent.width*2) -parent.width/4
                        anchors {
                            top : nameLogInfoBox.bottom
                            topMargin : parent.height/80
                            left: parent.left
                            leftMargin: parent.width/4
                        }
                        textPixelSize: (parent.width + parent.height)/50
                        infoBoxHeight:parent.height/15
                        label: ""
                        info: error_code
                        labelLeft: false
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        textColor: "red"
                    }

                    Button {
                        id:resetErrorButton
                        anchors {
                            top : nameLogInfoBox.bottom
                            topMargin : parent.height/80
                            right: labelledInfoBox.left
                            rightMargin: 0
                        }
                        font.pixelSize: (parent.width + parent.height)/60
                        text: "Reset"
                        visible: true
                        width: parent.width/4
                        height: parent.height/15
                        onClicked: {
                            platformInterface.set_system_mode.update(4)
                            error_code = ""
                        }
                    }
                }

            }

            Rectangle {
                id:right
                width: parent.width/4.5
                height: parent.height - parent.height/3
                anchors {
                    top:parent.top
                    topMargin: parent.height/100
                    left: gauge.right
                    leftMargin: (parent.width/15)
                    right: parent.right
                    rightMargin: (parent.width/25)
                }
                color: "transparent"
                border.color: "black"
                border.width: 2
                radius: 10

                Rectangle {
                    id: textContainer
                    width: parent.width/3
                    height: parent.height/10
                    anchors {
                        top: parent.top
                        topMargin: parent.height/100
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
                    width: parent.width

                    anchors {
                        top: textContainer.bottom
                        topMargin: 2
                        left: parent.left
                    }
                    border.color: "grey"
                    radius: 2
                }


                SGCircularGauge {
                    id: actualSpeed
                    anchors {
                        top : line2.bottom
                        topMargin : parent.height/60
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  0
                    }

                    width: parent.width/1.2
                    height: parent.height/1.8
                    gaugeFrontColor1: Qt.rgba(0,0.5,1,1)
                    gaugeFrontColor2: Qt.rgba(1,0,0,1)
                    minimumValue: 0
                    maximumValue: max_motor_speed
                    tickmarkStepSize: {
                        if (max_motor_speed <= 100){5}
                            else {if (max_motor_speed <= 500){25}
                            else if (max_motor_speed <= 1000){50}
                            else if (max_motor_speed <= 2000){100}
                            else if (max_motor_speed <= 3000){200}
                            else if (max_motor_speed >= 4000){500}
                            }
                    }
                    outerColor: "#999"
                    unitLabel: "RPM"
                    gaugeTitle: "Actual Speed"
                    value: platformInterface.status_vi.a
                    Behavior on value { NumberAnimation { duration: 300 } }
                }

                SGLabelledInfoBox {
                    id: iout_u
                    label: "I1 (A)"
                    info: winding_iout_iu_calc

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/1.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : actualSpeed.bottom
                        topMargin : -parent.height/30
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: iout_v
                    label: "I2 (A)"
                    info: winding_iout_iv_calc

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/1.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : iout_u.bottom
                        topMargin : parent.height/30
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                SGLabelledInfoBox {
                    id: iout_w
                    label: "I3 (A)"
                    info: winding_iout_iw_calc

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: ""
                    infoBoxWidth: parent.width/1.8
                    infoBoxHeight : parent.height/14
                    fontSize :  (parent.width + parent.height)/50
                    unitSize: (parent.width + parent.height)/50
                    anchors {
                        top : iout_v.bottom
                        topMargin : parent.height/30
                        right: parent.right
                        rightMargin: (parent.width/25)
                    }
                }

                Rectangle {
                    id: statusInfoBox
                    color: "transparent"; width: parent.width*0.5; height: parent.height
                    Text {
                        id: nameStatusInfoBox
                        text: "Status message"
                        anchors {
                            top : parent.bottom
                            topMargin : parent.height/80
                            left: parent.left
                            leftMargin: 0
                        }
                        font.pixelSize: 20
                        color: "black"
                    }

                    Widget09.SGLabelledInfoBox {
                        id: statusInfoBoxWidget
                        infoBoxWidth: parent.width*2
                        anchors {
                            top : nameStatusInfoBox.bottom
                            topMargin : parent.height/80
                            left: parent.left
                            leftMargin: 0
                        }
                        textPixelSize: (parent.width + parent.height)/50
                        infoBoxHeight:parent.height/15
                        label: ""
                        info: status_code
                        labelLeft: false
                        infoBoxColor: "lightgrey"
                        infoBoxBorderColor: "grey"
                        infoBoxBorderWidth: 3
                        textColor: "black"
                    }
                }

            }

        }

    }
}


