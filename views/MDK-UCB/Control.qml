import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/sgwidgets"
import "qrc:/image"
import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.fonts 1.0
import tech.strata.sgwidgets 0.9
import tech.strata.sgwidgets 1.0 as Widget10

Rectangle {
    id: controlNavigation
    objectName: "control"
    width: parent.width - 70
    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 70
    anchors.top:parent.top

    anchors.fill: parent

    property alias class_id: multiplePlatform.class_id

    PlatformInterface {
        id: platformInterface
    }

    MultiplePlatform{
        id: multiplePlatform
    }

    Component.onCompleted: {
        helpIcon.visible = true
        platformInterface.pause_periodic.update(false)
    }

    Component.onDestruction:  {
        platformInterface.pause_periodic.update(true)
    }

    ApplicationWindow {
        id: window
        width: 500
        height: 100
        visible: true

        SGButton {
            text: "Please check settings before enable"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            font.pixelSize: 20
            onClicked: window.close()
        }
    }

    TabBar {
        id: navTabs
        anchors {
            top: controlNavigation.top
            left: controlNavigation.left
            right: controlNavigation.right
        }

        TabButton {
            id: basicButton
            text: qsTr("Basic")
            onClicked: {
                basicControl.visible = true
                advancedControl.visible = false
                settingsControl.visible = false
                exportControl.visible = false
            }
        }

        TabButton {
            id: advancedButton
            text: qsTr("Advanced")
            onClicked: {
                basicControl.visible = false
                advancedControl.visible = true
                settingsControl.visible = false
                exportControl.visible = false
            }
        }

        TabButton {
            id: settingsButton
            text: qsTr("Control / Settings")
            onClicked: {
                basicControl.visible = false
                advancedControl.visible = false
                settingsControl.visible = true
                exportControl.visible = false
            }
        }

        TabButton {
            id: exportButton
            text: qsTr("Data Logger / Export")
            onClicked: {
                basicControl.visible = false
                advancedControl.visible = false
                settingsControl.visible = false
                exportControl.visible = true
            }
        }

    }

    StackLayout {
        id: controlContainer
        anchors {
            top: navTabs.bottom
            bottom: controlNavigation.bottom
            right: controlNavigation.right
            left: controlNavigation.left

        }

        currentIndex: navTabs.currentIndex

        Rectangle {
            width: parent.width
            height: parent.height

            BasicControl {
                id: basicControl
                visible: true
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "light gray"

            AdvancedControl {
                id: advancedControl
                visible: false
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "light gray"

            SettingsControl {
                id: settingsControl
                visible: false
                width: parent.width
                height: parent.height
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height
            color: "light gray"

            ExportControl {
                id: exportControl
                visible: false
                width: parent.width
                height: parent.height
            }
        }

    }

    Widget10.SGIcon {
        id: helpIcon
        anchors {
            right: parent.right
            rightMargin: parent.width/300
            top: parent.top
            topMargin: 50
        }
        source: "qrc:/sgimages/question-circle.svg"
        iconColor: helpMouse.containsMouse ? "lightgrey" : "grey"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: helpMouse
            anchors {
                fill: helpIcon
            }
            onClicked: {
                if(basicControl.visible === true) {Help.startHelpTour("basicHelp")}
                else if(advancedControl.visible === true) {Help.startHelpTour("advanceHelp")}
                else if(settingsControl.visible === true) {Help.startHelpTour("settingsHelp")}
                else if(exportControl.visible === true) {Help.startHelpTour("exportControlHelp")}
                else console.log("help not available")
            }
            hoverEnabled: true
        }
    }

    Rectangle{
        id: drawer
        width: 70
        height: parent.height
        anchors {
            left: parent.left
            leftMargin: -70
            top: parent.top
        }
        color: "#454545"
    }

        SideBar {
        id: sideBar
        anchors {
            left: parent.left
            leftMargin: -70
            top: parent.top
        }
    }
}


