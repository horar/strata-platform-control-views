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

    property var frequency: 1
    property var duty: 0
    property var pulses: 0
    property var currentMaxCalc: ((dcLink*(duty/100)*pulses)/((inductor/1000000)*frequency)).toFixed(0)

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
            id:burstPulseTestingImage
            anchors {
                top: parent.top
                left: dPTSetupImage.right
            }
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            source: "image/BurstTesting.png"
            width: parent.width/3
            height: parent.height
            fillMode: Image.PreserveAspectFit
            mipmap:true
            visible: true
        }

        SGSlider {
            id: frequencySlider
            anchors {
                top: parent.top
                topMargin: parent.height/30
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 20000
            value: 0
            stepSize: 1
            onValueChanged: frequency = value
            onUserSet: platformInterface.frequency = frequencySlider.value
            live: false
        }

        Text{
            id: frequencySliderValue
            text:"<b>PWM Frequency: <b>"+ frequency +" Hz"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: parent.top
                topMargin: parent.height/30
                left: burstPulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        SGSlider {
            id: dutySlider
            anchors {
                top: frequencySlider.top
                topMargin: parent.height/7
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 100
            value: 0
            stepSize: 1
            onValueChanged: duty = value
            onUserSet: platformInterface.duty = dutySlider.value
            live: false
        }

        Text{
            id: dutySliderValue
            text:"<b>Duty Cycle: <b>"+ duty +" %"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: frequencySliderValue.top
                topMargin: parent.height/7
                left: burstPulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        SGSlider {
            id: pulsesSlider
            anchors {
                top: dutySlider.top
                topMargin: parent.height/7
                right: parent.right
                rightMargin: (parent.width + parent.height)/100
                }
            width: parent.width/10
            from: 0
            to: 100
            value: 0
            stepSize: 1
            onValueChanged: pulses = value
            onUserSet: platformInterface.pulses = pulsesSlider.value
            live: false
        }

        Text{
            id: pulsesSliderValue
            text:"<b>Number of Pulses: <b>"+ pulses +""
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: dutySliderValue.top
                topMargin: parent.height/7
                left: burstPulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }

        Text{
            id: calculatedCurrentValue
            text:"<b>Switch Current Max. (calculated): <b>"+ currentMaxCalc +" A"
            font.pixelSize: (parent.width + parent.height)/110
            color: "black"
            anchors {
                top: pulsesSliderValue.top
                topMargin: parent.height/6
                left: burstPulseTestingImage.right
                leftMargin: (parent.width + parent.height)/25
                }
            }
    }
}
