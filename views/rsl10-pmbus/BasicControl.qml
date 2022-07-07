/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3
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
    property bool dimmensionalMode: true

    property int maxVin: 70
    property int minVin: 36

    property string read_vin_mon: {platformInterface.vin}
    onRead_vin_monChanged: {

        platformInterface.enabled = true

        if(minVin > ((platformInterface.vin))) {
            ledLight.status = "red"
            vinlable = "under"
            ledLight.label = "Vin < "+ minVin +"V"

            dio12Switch.enabled  = true
            dio12Switch.opacity = 1.0
        }

        else if(maxVin < ((platformInterface.vin))) {
            dio12Switch.checked = false
            ledLight.status = "red"
            vinlable = "under"
            ledLight.label = "Vin > "+ maxVin +"V"
            dio12Switch.enabled  = false
            dio12Switch.opacity = 0.2
            platformInterface.set_dio12.update("off")
        }

        else {
            ledLight.status = "green"
            vinlable = "over"
            ledLight.label = "Vin OK"

            dio12Switch.enabled  = true
            dio12Switch.opacity = 1.0
        }
    }

    Timer {
        id: getPwmTimer

        repeat: false
        interval: 10
        onTriggered: platformInterface.get_pwm.update()
    }

    Timer {
        id: startPeriodicTelemetryTimer

        repeat: false
        interval: 200
        onTriggered: platformInterface.start_periodic_telemetry.update()
    }

    Timer {
        id: startPeriodicStatusTimer

        repeat: false
        interval: 500
        onTriggered: platformInterface.start_periodic_status.update()

    }

    Timer {
        id: startGetFaultTimer
        repeat: false
        interval: 4000
        onTriggered: platformInterface.get_fault_config.update()
    }



    Component.onCompleted:  {
        multiplePlatform.check_class_id()
        platformInterface.get_output.update()
        getPwmTimer.start()
        startPeriodicTelemetryTimer.start()
        startPeriodicStatusTimer.start()
        startGetFaultTimer.start()
        Help.registerTarget(navTabs, "These tabs switch between Basic, Advanced and Data Logger/Export views.", 0, "basicHelp")
        Help.registerTarget(ledLight, "The LED will light up green when input voltage is ready and lower than" + " "+ multiplePlatform.nominalVin +"V.It will light up red when greater than "+ " "+ multiplePlatform.nominalVin + "V to warn the user that input voltage is too high.", 1, "basicHelp")
        Help.registerTarget(inputVoltage,"Input voltage is shown here.", 2 , "basicHelp")
        Help.registerTarget(basicImage, "The center image shows the board configuration.", 5, "basicHelp")
        Help.registerTarget(dimmensionalModeSpace, "Dimmensional space mode for the center image.", 6, "basicHelp")
        Help.registerTarget(dio12Switch, "This switch enables or disables the DUT.", 7, "basicHelp")
        Help.registerTarget(outputVoltage,"Output voltage is shown here.", 8, "basicHelp")
        Help.registerTarget(outputCurrent,"Output current is shown here.", 9, "basicHelp")
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
            height: parent.height/ 30

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
                    label: "Vin OK"
                    anchors {
                        top : line.bottom
                        topMargin : 40
                        horizontalCenter: parent.horizontalLeft
                    }
                    width: parent.width
                    height: parent.height/10
                    lightSize: (parent.width + parent.height)/23
                    fontSize:  (parent.width + parent.height)/40
                }

                SGLabelledInfoBox {
                    id: inputVoltage
                    label: ""
                    info: ((platformInterface.vin)).toFixed(3)

                    infoBoxColor: if (maxVin < (platformInterface.vin)) {"red"}
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
                        horizontalCenterOffset:  (width - parent.width)/2
                    }
                }

                Rectangle {
                    id: warningBox2
                    color: "red"
                    radius: 10
                    anchors {
                        top: inputVoltage.bottom
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
                        text: "<b>Max. input voltage "+ maxVin +"V</b>"
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
                        if(dimmensionalMode === true) {"images/quarter_brick_3D.gif"}
                        else {"images/quarter_brick_2D.gif"}
                    }
                    width: parent.width*0.8
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
                    width: parent.width * 0.8
                    height: parent.height - 20
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    mipmap:true
                    visible: dimmensionalMode === true ? true : false
                }

                SGRadioButtonContainer {
                    id: dimmensionalModeSpace
                    anchors {
                        top: basicImage.bottom
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
                            checked: dimmensionalMode
                            onCheckedChanged: {
                                if (checked) {
                                    console.log("3D")
                                    dimmensionalMode = true
                                }
                                else {
                                    console.log("Top")
                                    dimmensionalMode = false
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
                    checked: platformInterface.output_enabled


                    onToggled:
                        if(checked)
                        {
                            platformInterface.set_output1.update(checked)
                        }
                        else
                        {
                            platformInterface.set_output1.update(checked)
                        }
                }

                SGLabelledInfoBox {
                    id: outputVoltage
                    label: ""
                    info: ((platformInterface.vout)).toFixed(3)

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
                        right: parent.right
                        rightMargin: parent.width/20
                    }
                }

                SGLabelledInfoBox {
                    id: outputCurrent
                    label: ""
                    info: ((platformInterface.iout)).toFixed(3)

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
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  10
                        right: parent.right
                        rightMargin: parent.width/20
                    }
                }

                SGLabelledInfoBox {
                    id: outputPower
                    label: ""
                    info: ((platformInterface.pout)).toFixed(3)

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: "W"
                    infoBoxWidth: parent.width/1.5
                    infoBoxHeight :  parent.height/12
                    fontSize :   (parent.width + parent.height)/37
                    unitSize: (parent.width + parent.height)/35
                    anchors {
                        top : outputCurrent.bottom
                        topMargin : parent.height/15
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  10
                        right: parent.right
                        rightMargin: parent.width/20
                    }
                }

                Rectangle {
                    id: textTempContainer
                    width: parent.width/3
                    height: parent.height/10
                    anchors {
                        top: outputPower.bottom
                        topMargin : parent.height/15
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  10
                        right: parent.right
                        rightMargin: parent.width/20
                    }
                    Text {
                        id: containerTempLabel
                        text: "Chip temperature"
                        anchors{
                            fill: parent
                            centerIn: parent
                        }
                        font.pixelSize: height/2
                        font.bold: false
                    }
                }

                SGLabelledInfoBox {
                    id: chipTemp
                    info: ((platformInterface.ctemp)).toFixed(3)

                    infoBoxColor: "lightgrey"
                    infoBoxBorderColor: "grey"
                    infoBoxBorderWidth: 3

                    unit: "°C"
                    infoBoxWidth: parent.width/1.5
                    infoBoxHeight :  parent.height/12
                    fontSize :   (parent.width + parent.height)/37
                    unitSize: (parent.width + parent.height)/35
                    anchors {
                        top : textTempContainer.bottom
                        topMargin : parent.height/15
                        horizontalCenter: parent.horizontalCenter
                        horizontalCenterOffset:  10
                        right: parent.right
                        rightMargin: parent.width/20
                    }
                }
            }
        }
    }
}
