import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import tech.strata.sgwidgets 0.9
import "qrc:/sgwidgets"
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help
import "qrc:/image"

Rectangle {
    id: root

    property bool debugLayout: false

    property var dcLink: 0
    property var inductor: 0

    property var temp_U_calc: platformInterface.status_vi.U
    property var temp_V_calc: platformInterface.status_vi.V
    property var temp_W_calc: platformInterface.status_vi.W

    anchors.fill: parent

    Component.onCompleted: {
        platformInterface.read_initial_status.update()
    }

    Image {
        id:moduleImage
        anchors {
            top: parent.top
        }
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.width
        source: "image/Module.png"
        width: parent.width/2.5
        height: parent.height/2.5
        fillMode: Image.PreserveAspectFit
        mipmap:true
        visible: true
    }

    Text{
        id: dcLinkSliderValue
        text:"<b>DC Link Voltage: <b>"+ dcLink +" V"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: parent.top
            topMargin: parent.height/10
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    Text{
        id: inductorSliderValue
        text:"<b>Load Inductance: <b>"+ inductor +" µH"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: dcLinkSliderValue.top
            topMargin: parent.height/20
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    Text{
        id: temperatureUValue
        text:"<b>Temperature 1: <b>"+ temp_U_calc +" °C"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: inductorSliderValue.top
            topMargin: parent.height/20
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    Text{
        id: temperatureVValue
        text:"<b>Temperature 2: <b>"+ temp_V_calc +" °C"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: temperatureUValue.top
            topMargin: parent.height/20
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    Text{
        id: temperatureWValue
        text:"<b>Temperature 3: <b>"+ temp_W_calc +" °C"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: temperatureVValue.top
            topMargin: parent.height/20
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    SGRadioButtonContainer {
        id: switchHighControl
        anchors {
            top: moduleImage.top
            topMargin: moduleImage.height/4
            left: dcLinkSliderValue.right
            leftMargin: moduleImage.width/4
        }

        label: "<b>High Side (Load Inductor / Short Circuit Bridge):</b>"
        labelLeft: false
        exclusive: true

        radioGroup: GridLayout {

            columnSpacing: moduleImage.width/5

            SGRadioButton {
                id: q5
                text: "Q5"
                property bool s5: false
                onCheckedChanged: {
                    if (checked) {
                        platformInterface.q5 = true
                    }
                    else {
                        platformInterface.q5 = false
                    }
                }
                checked: {
                }
            }

            SGRadioButton {
                id: q3
                text: "Q3"
                onCheckedChanged: {
                    if (checked) {
                        platformInterface.q3 = true
                    }
                    else {
                        platformInterface.q3 = false
                    }
                }
                checked: {
                }
            }

            SGRadioButton {
                id: q1
                text: "Q1"
                onCheckedChanged: {
                    if (checked) {
                        platformInterface.q1 = true
                    }
                    else {
                        platformInterface.q1 = false
                    }
                }
                checked: {
                }
            }
        }

    }

    SGRadioButtonContainer {
        id: switchLowControl
        anchors {
            top: moduleImage.top
            topMargin: moduleImage.height/1.6
            left: dcLinkSliderValue.right
            leftMargin: moduleImage.width/4
        }

        label: "<b>Low Side (DUT):</b>"
        labelLeft: false
        exclusive: true

        radioGroup: GridLayout {

            columnSpacing: moduleImage.width/5

            SGRadioButton {
                id: q6
                text: "Q6"
                onCheckedChanged: {
                    if (checked) {
                        platformInterface.q6 = true
                    }
                    else {
                        platformInterface.q6 = false
                    }
                }
                checked: {
                }
            }

            SGRadioButton {
                id: q4
                text: "Q4"
                onCheckedChanged: {
                    if (checked) {
                        platformInterface.q4 = true
                    }
                    else {
                        platformInterface.q4 = false
                    }
                }
                checked: {
                }
            }

            SGRadioButton {
                id: q2
                text: "Q2"
                onCheckedChanged: {
                    if (checked) {
                        platformInterface.q2 = true
                    }
                    else {
                        platformInterface.q2 = false
                    }
                }
                checked: {
                }
            }
        }
    }


    SGAccordion {
        id: settingsAccordion
        anchors {
            top: parent.top
            topMargin: parent.height/2.3
            bottom: root.bottom
        }
        width: root.width

        accordionItems: Column {
            SGAccordionItem {
                id: generalInputs
                title: "<b>General Inputs</b>"
                open: false
                contents: GeneralInputs { }
            }

            SGAccordionItem {
                id: singlePulseTesting
                title: "<b>Single Pulse Testing</b>"
                open: false
                contents: SinglePulseTesting { }
            }

            SGAccordionItem {
                id: doublePulseTesting
                title: "<b>Double Pulse Testing</b>"
                open: false
                contents: DoublePulseTesting { }
            }

            SGAccordionItem {
                id: burstTesting
                title: "<b>Burst Testing</b>"
                open: false
                contents: BurstTesting { }
            }

            SGAccordionItem {
                id: shortCircuitMode
                title: "<b>Short Circuit Mode</b>"
                open: false
                contents: ShortCircuitMode { }
            }
        }
    }

}
