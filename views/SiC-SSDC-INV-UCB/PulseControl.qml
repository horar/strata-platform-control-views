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

    anchors.fill: parent

    Component.onCompleted: {
        platformInterface.read_initial_status.update()

        Help.registerTarget(navTabs, "Pulse Testing View:\n-Testing the switching performance of power semiconductors in a safe and controlled environment is a challenge. Two or double testing is a key implement in the tool box of power electronics engineers that enables comprehensive and accurate measurements to be made early in the design cycle and so can help reduce time to market.", 0, "pulseControlHelp")

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
        id: dcLinkTargetValue
        text:"<b>Target DC Link Voltage: <b>"+ dcLink +" V"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: parent.top
            topMargin: parent.height/3
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    Text{
        id: inductorTargetValue
        text:"<b>Target Load Inductance: <b>"+ inductor +" µH"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: dcLinkTargetValue.top
            topMargin: parent.height/20
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }


    Text{
        id: testResponseText
        text: "<b>Test:<b>"
        font.pixelSize: (parent.width + parent.height)/140
        color: "black"
        anchors {
            top : parent.top
            topMargin : parent.height/20
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    SGComboBox {
        id: testResponseCombo
        model: [ "","Single_Pulse","Double_Pulse","Burst","Short_Circuit"]
        borderColor: "green"
        textColor: "black"
        indicatorColor: "green"
        width: parent.width/10
        height:parent.height/10
        anchors {
            top : testResponseText.top
            topMargin : parent.height/30
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        onActivated: {
            platformInterface.set_testResponse.update(currentText)
            }
        }

    Text{
        id: switchResponseText
        text: "<b>DUT:<b>"
        font.pixelSize: (parent.width + parent.height)/140
        color: "black"
        anchors {
            top : parent.top
            topMargin : parent.height/20
            left: testResponseCombo.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    SGComboBox {
        id: switchResponseCombo
        model: testResponseCombo.currentIndex > 0 ? ["","Q1","Q2","Q3","Q4","Q5","Q6"] : [""]
        borderColor: "green"
        textColor: "black"
        indicatorColor: "green"
        width: parent.width/10
        height:parent.height/10
        anchors {
            top : switchResponseText.top
            topMargin : parent.height/30
            left: testResponseCombo.right
            leftMargin: (parent.width + parent.height)/50
            }
        onActivated: {
            platformInterface.set_switchResponse.update(currentText)
            }
        }

    Text{
        id: constantResponseText
        text: "<b>Constant On Switch:<b>"
        font.pixelSize: (parent.width + parent.height)/140
        color: "black"
        anchors {
            top : parent.top
            topMargin : parent.height/20
            left: switchResponseCombo.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    SGComboBox {
        id: constantResponseCombo
        model: {
            if (testResponseCombo.currentIndex === 4 && switchResponseCombo.currentIndex === 1) {["","Q4","Q6"]}
                else if(testResponseCombo.currentIndex === 4 && switchResponseCombo.currentIndex === 2) {["","Q3","Q5"]}
                else if(testResponseCombo.currentIndex === 4 && switchResponseCombo.currentIndex === 3) {["","Q2","Q6"]}
                else if(testResponseCombo.currentIndex === 4 && switchResponseCombo.currentIndex === 4) {["","Q1","Q5"]}
                else if(testResponseCombo.currentIndex === 4 && switchResponseCombo.currentIndex === 5) {["","Q2","Q4"]}
                else if(testResponseCombo.currentIndex === 4 && switchResponseCombo.currentIndex === 6) {["","Q1","Q3"]}

            else {[""]}
        }
        borderColor: "green"
        textColor: "black"
        indicatorColor: "green"
        width: parent.width/10
        height:parent.height/10
        anchors {
            top : switchResponseText.top
            topMargin : parent.height/30
            left: switchResponseCombo.right
            leftMargin: (parent.width + parent.height)/50
            }
        onActivated: {
            platformInterface.set_constantResponse.update(currentText)
            }
        }

    Button {
        id:setParametersButton
        anchors {
            top : testResponseText.bottom
            topMargin : parent.height/10
            left: moduleImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        font.pixelSize: (parent.width + parent.height)/150
        text: "<b>TEST<b>"
        visible: testResponseCombo.currentIndex > 0 ? true : false
        width: parent.width/20
        height: parent.height/25
        onClicked: {
            platformInterface.set_test.update(1)
        }
    }

    SGAccordion {
        id: settingsAccordion
        anchors {
            top: parent.top
            topMargin: parent.height/2.3
            bottom: root.bottom
        }
        height: root.height/3
        width: root.width

        accordionItems: Column {

            SGAccordionItem {
                id: singlePulseTesting
                title: "<b>Single Pulse settings</b>"
                open: false
                contents: SinglePulseTesting { }
            }

            SGAccordionItem {
                id: doublePulseTesting
                title: "<b>Double Pulse settings</b>"
                open: false
                contents: DoublePulseTesting { }
            }

            SGAccordionItem {
                id: burstTesting
                title: "<b>Burst settings</b>"
                open: false
                contents: BurstTesting { }
            }

            SGAccordionItem {
                id: shortCircuitMode
                title: "<b>Short Circuit settings</b>"
                open: false
                contents: ShortCircuitMode { }
            }

            SGAccordionItem {
                id: valuesPulse
                title: "<b>Measured Values</b>"
                open: true
                contents: ValuesPulse { }
            }
        }
    }

}
