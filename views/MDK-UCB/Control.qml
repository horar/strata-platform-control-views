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

    property var dc_link_vin_calc: platformInterface.status_vi.l/1000

    property var motor_running

    PlatformInterface {
        id: platformInterface
    }

    MultiplePlatform{
        id: multiplePlatform
    }

    Component.onCompleted: {

        motor_running = 0
        helpIcon.visible = true
        playIcon.enabled = true
        stopIcon.enabled = false
        stopIcon.opacity = 0
        playIcon.opacity = 1
        clockwiseIcon.enabled = true
        counterclockwiseIcon.enabled = false
        counterclockwiseIcon.opacity = 0
        clockwiseIcon.opacity = 1

        speedSlider.opacity = 0
        speedSlider.value = settingsControl.target
        speed_showIcon.enabled  = true
        speed_hideIcon.enabled  = false

        accelerationSlider.opacity = 0
        accelerationSlider.value = settingsControl.ratio
        acceleration_showIcon.enabled  = true
        acceleration_hideIcon.enabled  = false

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

    Widget10.SGIcon {
        id: acceleration_showIcon
        anchors {
            right: helpIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 50
        }
        source: "image/acceleration.png"
        iconColor: acceleration_showMouse.containsMouse ? "lightgrey" : "black"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: acceleration_showMouse
            anchors {
                fill: acceleration_showIcon
            }
            onClicked: {
                accelerationSlider.opacity = 1
                acceleration_hideIcon.enabled = true
                acceleration_showIcon.enabled  = false
                acceleration_hideIcon.opacity = 1
                acceleration_showIcon.opacity = 0
            }
            hoverEnabled: true
        }
    }

    Widget10.SGIcon {
        id: acceleration_hideIcon
        anchors {
            right: helpIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 50
        }
        source: "image/acceleration.png"
        iconColor: acceleration_hideMouse.containsMouse ? "lightgrey" : "black"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: acceleration_hideMouse
            anchors {
                fill: acceleration_hideIcon
            }
            onClicked: {
                accelerationSlider.opacity = 0
                acceleration_showIcon.enabled  = true
                acceleration_hideIcon.enabled = false
                acceleration_showIcon.opacity = 1
                acceleration_hideIcon.opacity = 0
            }
            hoverEnabled: true
        }
    }

    Widget10.SGIcon {
        id: stopIcon
        anchors {
            right: acceleration_showIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 50
        }
        source: "image/Stop.svg"
        iconColor: stopMouse.containsMouse ? "lightgrey" : "red"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: stopMouse
            anchors {
                fill: stopIcon
            }
            onClicked: {
                motor_running = 0
                settingsControl.stop()
                playIcon.opacity = 1
                stopIcon.opacity = 0
                playIcon.enabled = true
                stopIcon.enabled = false
                clockwiseIcon.opacity = 1
                clockwiseIcon.enabled = true
                speedSlider.value = 0
                accelerationSlider.value = 0
            }
            hoverEnabled: true
        }
    }

    Widget10.SGIcon {
        id: playIcon
        anchors {
            right: acceleration_showIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 50
        }
        source: "image/Play.svg"
        iconColor: playMouse.containsMouse ? "lightgrey" : "green"
        height: parent.height/25
        width: parent.width/25
        visible: {
            if (basicControl.motor_play === 1){
                true
            }
            else {
                false
                }
            }

        MouseArea {
            id: playMouse
            anchors {
                fill: playIcon
            }
            onClicked: {
                motor_running = 1
                settingsControl.play()
                stopIcon.opacity = 1
                playIcon.opacity = 0
                playIcon.enabled = false
                stopIcon.enabled = true
                counterclockwiseIcon.enabled = false
                clockwiseIcon.enabled = false
            }
            hoverEnabled: true
        }
    }

    RotationAnimator {
        target: clockwiseIcon
        from: 0
        to: 360
        duration: 5000
        running: {
                if (motor_running === 1){true}
                else {false}
                }
        loops: Animation.Infinite
    }


    Widget10.SGIcon {
        id: clockwiseIcon
        anchors {
            right: playIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 55
        }
        source: "qrc:/sgimages/redo.svg"
        iconColor: clockwiseMouse.containsMouse ? "lightgrey" : "black"
        height: parent.height/30
        width: parent.width/30
        visible: true

        MouseArea {
            id: clockwiseMouse
            anchors {
                fill: clockwiseIcon
            }
            onClicked: {
                platformInterface.set_direction.update("clockwise")
                counterclockwiseIcon.opacity = 1
                clockwiseIcon.opacity = 0
                clockwiseIcon.enabled = false
                counterclockwiseIcon.enabled = true
            }
            hoverEnabled: true
        }
    }

    RotationAnimator {
        target: counterclockwiseIcon
        from: 360
        to: 0
        duration: 5000
        running: {
                if (motor_running === 1){true}
                else {false}
                }
        loops: Animation.Infinite
    }

    Widget10.SGIcon {
        id: counterclockwiseIcon
        anchors {
            right: playIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 55
        }
        source: "qrc:/sgimages/undo.svg"
        iconColor: counterclockwiseMouse.containsMouse ? "lightgrey" : "grey"
        height: parent.height/30
        width: parent.width/30
        visible: true

        MouseArea {
            id: counterclockwiseMouse
            anchors {
                fill: counterclockwiseIcon
            }
            onClicked: {
                platformInterface.set_direction.update("counterClockwise")
                clockwiseIcon.opacity = 1
                counterclockwiseIcon.opacity = 0
                counterclockwiseIcon.enabled = false
                clockwiseIcon.enabled = true
            }
            hoverEnabled: true
        }
    }

    Widget10.SGIcon {
        id: speed_showIcon
        anchors {
            right: counterclockwiseIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 50
        }
        source: "image/speed.png"
        iconColor: speed_showMouse.containsMouse ? "lightgrey" : "black"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: speed_showMouse
            anchors {
                fill: speed_showIcon
            }
            onClicked: {
                speedSlider.opacity = 1
                speed_hideIcon.enabled = true
                speed_showIcon.enabled  = false
                speed_hideIcon.opacity = 1
                speed_showIcon.opacity = 0
            }
            hoverEnabled: true
        }
    }

    Widget10.SGIcon {
        id: speed_hideIcon
        anchors {
            right: counterclockwiseIcon.left
            rightMargin: 0
            top: parent.top
            topMargin: 50
        }
        source: "image/speed.png"
        iconColor: speed_hideMouse.containsMouse ? "lightgrey" : "black"
        height: parent.height/25
        width: parent.width/25
        visible: true

        MouseArea {
            id: speed_hideMouse
            anchors {
                fill: speed_hideIcon
            }
            onClicked: {
                speedSlider.opacity = 0
                speed_showIcon.enabled  = true
                speed_hideIcon.enabled = false
                speed_showIcon.opacity = 1
                speed_hideIcon.opacity = 0
            }
            hoverEnabled: true
        }
    }

    SGSlider {
        id: speedSlider
        width: parent.width/10
        anchors {
            right: accelerationSlider.left
            rightMargin: parent.width/300
            top: parent.top
            topMargin: 60 + (parent.height/25)
            }
        from: 0
        to: settingsControl.max_motor_speed
        value: settingsControl.target
        onUserSet: {
            settingsControl.target = speedSlider.value
            platformInterface.speed = speedSlider.value
            }
        stepSize: 1
        onValueChanged: {
            settingsControl.target = speedSlider.value
            }
        live: false
        }

    SGSlider {
        id: accelerationSlider
        width: parent.width/10
        anchors {
            right: parent.right
            rightMargin: 0
            top: parent.top
            topMargin: 60 + (parent.height/25)
        }
        from: 0
        to: settingsControl.max_motor_speed
        value: settingsControl.ratio
        stepSize: 1
        onUserSet: {
            settingsControl.ratio = accelerationSlider.value
            settingsControl.acceleration = accelerationSlider.value
            platformInterface.acceleration = accelerationSlider.value
        }
        onValueChanged: {
            settingsControl.ratio = accelerationSlider.value
            settingsControl.acceleration = accelerationSlider.value
            }
        live: false
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
        Image{
            id:onLogo
            source:"image/ON-logo.svg"
            height: 50
            anchors.left: parent.left
            anchors.leftMargin: -60
            anchors.top:parent.top
            anchors.topMargin: 5
            fillMode: Image.PreserveAspectFit
            mipmap:true
            opacity:1
        }
        RotationAnimator {
            target: onLogo
            from: 0
            to: 360
            duration: 5000
            running: {true
                    //if (motor_running === 1){true}
                    //else {false}
                    }
            //loops: Animation.Infinite
        }
}


