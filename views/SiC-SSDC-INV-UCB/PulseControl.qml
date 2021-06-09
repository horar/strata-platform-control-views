import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import tech.strata.sgwidgets 0.9
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help


Rectangle {
    id: root

    property bool debugLayout: false
    anchors.fill: parent

    Component.onCompleted: {
        platformInterface.read_initial_status.update()
    }

    SGAccordion {
        id: settingsAccordion
        anchors {
            top: parent.top
            topMargin: parent.height/10
            bottom: root.bottom
        }
        width: root.width

        accordionItems: Column {
            SGAccordionItem {
                id: generalInputs
                title: "<b>General Inputs</b>"
                open: true
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
