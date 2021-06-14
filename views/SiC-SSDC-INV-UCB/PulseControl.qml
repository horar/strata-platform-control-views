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
    }

    Image {
        id:moduleImage
        anchors {
            top: parent.top
            topMargin: parent.height/50
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

    Image {
        id:switchDistributionImage
        anchors {
            top: parent.top
            topMargin: parent.height/20
            left: moduleImage.right
        }
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.width
        source: "image/SwitchDistribution.png"
        width: parent.width/3
        height: parent.height/3
        fillMode: Image.PreserveAspectFit
        mipmap:true
        visible: true
    }

    Text{
        id: dcLinkSliderValue
        text:"<b>DC Link: <b>"+ dcLink +" V"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: parent.top
            topMargin: parent.height/10
            left: switchDistributionImage.right
            leftMargin: (parent.width + parent.height)/50
            }
        }

    Text{
        id: inductorSliderValue
        text:"<b>Inductor: <b>"+ inductor +" µH"
        font.pixelSize: (parent.width + parent.height)/150
        color: "black"
        anchors {
            top: dcLinkSliderValue.top
            topMargin: parent.height/15
            left: switchDistributionImage.right
            leftMargin: (parent.width + parent.height)/50
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
