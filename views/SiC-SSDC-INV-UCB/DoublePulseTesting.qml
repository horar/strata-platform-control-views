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

    property var t1_double: 0
    property var t2_double: 0
    property var t3_double: 0
    property var currentT1_doubleCalc: ((dcLink*t1_double)/inductor).toFixed(0)
    property var currentT3_doubleCalc: (((dcLink*t1_double)/inductor)+((dcLink*t3_double)/inductor)).toFixed(0)

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
            source: "image/DPT_Set−up.png"
            width: parent.width/3
            height: parent.height
            fillMode: Image.PreserveAspectFit
            mipmap:true
            visible: true
        }

        Image {
            id:doublePulseTestingImage
            anchors {
                top: parent.top
                left: dPTSetupImage.right
            }
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            source: "image/DoublePulseTesting.png"
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
                topMargin: parent.height/30
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 200
            value: 0
            stepSize: 1
            onValueChanged: t1_double = value
            onUserSet: platformInterface.t1_double = t1Slider.value
            live: false
        }

        Text{
            id: t1SliderValue
            text:"<b>Pulse Duration T1: <b>"+ t1_double +" µs"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: parent.top
                topMargin: parent.height/30
                left: doublePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        SGSlider {
            id: t2Slider
            anchors {
                top: t1Slider.top
                topMargin: parent.height/7
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 200
            value: 0
            stepSize: 1
            onValueChanged: t2_double = value
            onUserSet: platformInterface.t2_double = t2Slider.value
            live: false
        }

        Text{
            id: t2SliderValue
            text:"<b>Pulse Duration T2: <b>"+ t2_double +" µs"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: t1SliderValue.top
                topMargin: parent.height/7
                left: doublePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        SGSlider {
            id: t3Slider
            anchors {
                top: t2Slider.top
                topMargin: parent.height/7
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 200
            value: 0
            stepSize: 1
            onValueChanged: t3_double = value
            onUserSet: platformInterface.t3_double = t3Slider.value
            live: false
        }

        Text{
            id: t3SliderValue
            text:"<b>Pulse Duration T3: <b>"+ t3_double +" µs"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: t2SliderValue.top
                topMargin: parent.height/7
                left: doublePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        Text{
            id: calculatedCurrentT1Value
            text:"<b>Switch Current T1 (calculated): <b>"+ currentT1_doubleCalc +" A"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: t3SliderValue.top
                topMargin: parent.height/7
                left: doublePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        Text{
            id: calculatedCurrentT3Value
            text:"<b>Switch Current T3 (calculated): <b>"+ currentT3_doubleCalc +" A"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: calculatedCurrentT1Value.top
                topMargin: parent.height/8
                left: doublePulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }
    }
}
