import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls 2.3
import tech.strata.sgwidgets 0.9 as Widget09
import tech.strata.sgwidgets 1.0
import "qrc:/js/navigation_control.js" as NavigationControl
import "qrc:/js/help_layout_manager.js" as Help
import "qrc:/image"

Item {
    id: root
    height: parent.width/4
    width: parent.width

    property bool debugLayout: false

    property var t1_single: 0
    property var currentT1_singleCalc: ((dcLink*t1_single)/inductor).toFixed(0)

    Rectangle {
        id: images
        anchors.fill: parent

        Image {
            id:dPTSetupImage
            anchors {
                top: parent.top
            }
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            source: "image/DPT_Set-up.png"
            width: parent.width/3
            height: parent.height
            fillMode: Image.PreserveAspectFit
            mipmap:true
            visible: true
        }

        Image {
            id:singlePulseTestingImage
            anchors {
                top: parent.top
                left: dPTSetupImage.right
            }
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            source: "image/SinglePulseTesting.png"
            width: parent.width/3
            height: parent.height
            fillMode: Image.PreserveAspectFit
            mipmap:true
            visible: true
        }

        SGSlider {
            id: t1Slider
            anchors {
                top: parent.top
                topMargin: parent.height/6
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 200
            value: 0
            stepSize: 1
            onValueChanged: t1_single = value
            onUserSet: platformInterface.t1_single = t1Slider.value
            live: false
        }

        Text{
            id: t1SliderValue
            text:"<b>Pulse Duration: <b>"+ t1_single +" µs"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: parent.top
                topMargin: parent.height/6
                left: singlePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        Text{
            id: calculatedCurrentValue
            text:"<b>Switch Current (calculated): <b>"+ currentT1_singleCalc +" A"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: t1SliderValue.top
                topMargin: parent.height/6
                left: singlePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }
    }
}

