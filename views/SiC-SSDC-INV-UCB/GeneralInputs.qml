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
    height: 500
    width: parent.width

    property var gainVolt_3: platformInterface.gainVolt_3
    property var offsetVolt_3: platformInterface.offsetVolt_3
    property var gainCurrent_3: platformInterface.gainCurrent_3
    property var offsetCurrent_3: platformInterface.offsetCurrent_3
    property var gainTemp_3: platformInterface.gainTemp_3
    property var offsetTemp_3: platformInterface.offsetTemp_3

    property var gainVolt_2: platformInterface.gainVolt_2
    property var offsetVolt_2: platformInterface.offsetVolt_2
    property var gainCurrent_2: platformInterface.gainCurrent_2
    property var offsetCurrent_2: platformInterface.offsetCurrent_2
    property var gainTemp_2: platformInterface.gainTemp_2
    property var offsetTemp_2: platformInterface.offsetTemp_2

    property var gainVolt_1: platformInterface.gainVolt_1
    property var offsetVolt_1: platformInterface.offsetVolt_1
    property var gainCurrent_1: platformInterface.gainCurrent_1
    property var offsetCurrent_1: platformInterface.offsetCurrent_1
    property var gainTemp_1: platformInterface.gainTemp_1
    property var offsetTemp_1: platformInterface.offsetTemp_1

    Rectangle {
        id: gainOffset
        property bool debugLayout: false
        anchors.fill: parent

            SGAlignedLabel{
                id: gainVolt_3Label
                target: gainVolt_3Slider
                text:"<b>Gain Voltage 3:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: parent.top
                    topMargin: parent.height/30
                    left: parent.left
                    leftMargin: parent.height/20
                    }
                SGSlider {
                    id: gainVolt_3Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainVolt_3
                    stepSize: 0.1
                    onValueChanged: gainVolt_3 = value
                    onUserSet: platformInterface.gainVolt_3 = gainVolt_3Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetVolt_3Label
                target: offsetVolt_3Slider
                text:"<b>Offset Voltage 3:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainVolt_3Label.bottom
                    topMargin: parent.height/30
                    left: parent.left
                    leftMargin: parent.height/20
                    }
                SGSlider {
                    id: offsetVolt_3Slider
                    width: parent.width
                    from: -1000
                    to: 1000
                    value: platformInterface.offsetVolt_3
                    stepSize: 1
                    onValueChanged: offsetVolt_3 = value
                    onUserSet: platformInterface.offsetVolt_3 = offsetVolt_3Slider.value
                    live: false
                }
                Text{
                    id: offsetVolt_3SliderUnit
                    text:"V"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetVolt_3Slider.right
                    anchors.verticalCenter: offsetVolt_3Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainCurrent_3Label
                target: gainCurrent_3Slider
                text:"<b>Gain Current 3:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: offsetVolt_3Label.bottom
                    topMargin: parent.height/30
                    left: parent.left
                    leftMargin: parent.height/20
                    }
                SGSlider {
                    id: gainCurrent_3Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainCurrent_3
                    stepSize: 0.1
                    onValueChanged: gainCurrent_3 = value
                    onUserSet: platformInterface.gainCurrent_3 = gainCurrent_3Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetCurrent_3Label
                target: offsetCurrent_3Slider
                text:"<b>Offset Current 3:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainCurrent_3Label.bottom
                    topMargin: parent.height/30
                    left: parent.left
                    leftMargin: parent.height/20
                    }
                SGSlider {
                    id: offsetCurrent_3Slider
                    width: parent.width
                    from: -1000
                    to: 1000
                    value: platformInterface.offsetCurrent_3
                    stepSize: 1
                    onValueChanged: offsetCurrent_3 = value
                    onUserSet: platformInterface.offsetCurrent_3 = offsetCurrent_3Slider.value
                    live: false
                }
                Text{
                    id: offsetCurrent_3SliderUnit
                    text:"A"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetCurrent_3Slider.right
                    anchors.verticalCenter: offsetCurrent_3Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainTemp_3Label
                target: gainTemp_3Slider
                text:"<b>Gain Temperature 3:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: offsetCurrent_3Label.bottom
                    topMargin: parent.height/30
                    left: parent.left
                    leftMargin: parent.height/20
                    }
                SGSlider {
                    id: gainTemp_3Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainTemp_3
                    stepSize: 0.1
                    onValueChanged: gainTemp_3 = value
                    onUserSet: platformInterface.gainTemp_3 = gainTemp_3Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetTemp_3Label
                target: offsetTemp_3Slider
                text:"<b>Offset Temperature 3:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainTemp_3Label.bottom
                    topMargin: parent.height/30
                    left: parent.left
                    leftMargin: parent.height/20
                    }
                SGSlider {
                    id: offsetTemp_3Slider
                    width: parent.width
                    from: -200
                    to: 200
                    value: platformInterface.offsetTemp_3
                    stepSize: 1
                    onValueChanged: offsetTemp_3 = value
                    onUserSet: platformInterface.offsetTemp_3 = offsetTemp_3Slider.value
                    live: false
                }
                Text{
                    id: offsetTemp_3SliderUnit
                    text:"°C"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetTemp_3Slider.right
                    anchors.verticalCenter: offsetTemp_3Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainVolt_2Label
                target: gainVolt_2Slider
                text:"<b>Gain Voltage 2:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: parent.top
                    topMargin: parent.height/30
                    left: gainVolt_3Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: gainVolt_2Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainVolt_2
                    stepSize: 0.1
                    onValueChanged: gainVolt_2 = value
                    onUserSet: platformInterface.gainVolt_2 = gainVolt_2Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetVolt_2Label
                target: offsetVolt_2Slider
                text:"<b>Offset Voltage 2:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainVolt_2Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_3Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: offsetVolt_2Slider
                    width: parent.width
                    from: -1000
                    to: 1000
                    value: platformInterface.offsetVolt_2
                    stepSize: 1
                    onValueChanged: offsetVolt_2 = value
                    onUserSet: platformInterface.offsetVolt_2 = offsetVolt_2Slider.value
                    live: false
                }
                Text{
                    id: offsetVolt_2SliderUnit
                    text:"V"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetVolt_2Slider.right
                    anchors.verticalCenter: offsetVolt_2Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainCurrent_2Label
                target: gainCurrent_2Slider
                text:"<b>Gain Current 2:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: offsetVolt_2Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_3Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: gainCurrent_2Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainCurrent_2
                    stepSize: 0.1
                    onValueChanged: gainCurrent_2 = value
                    onUserSet: platformInterface.gainCurrent_2 = gainCurrent_2Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetCurrent_2Label
                target: offsetCurrent_2Slider
                text:"<b>Offset Current 2:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainCurrent_2Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_3Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: offsetCurrent_2Slider
                    width: parent.width
                    from: -1000
                    to: 1000
                    value: platformInterface.offsetCurrent_2
                    stepSize: 1
                    onValueChanged: offsetCurrent_2 = value
                    onUserSet: platformInterface.offsetCurrent_2 = offsetCurrent_2Slider.value
                    live: false
                }
                Text{
                    id: offsetCurrent_2SliderUnit
                    text:"A"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetCurrent_2Slider.right
                    anchors.verticalCenter: offsetCurrent_2Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainTemp_2Label
                target: gainTemp_2Slider
                text:"<b>Gain Temperature 2:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: offsetCurrent_2Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_3Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: gainTemp_2Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainTemp_2
                    stepSize: 0.1
                    onValueChanged: gainTemp_2 = value
                    onUserSet: platformInterface.gainTemp_2 = gainTemp_2Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetTemp_2Label
                target: offsetTemp_2Slider
                text:"<b>Offset Temperature 2:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainTemp_2Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_3Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: offsetTemp_2Slider
                    width: parent.width
                    from: -200
                    to: 200
                    value: platformInterface.offsetTemp_2
                    stepSize: 1
                    onValueChanged: offsetTemp_2 = value
                    onUserSet: platformInterface.offsetTemp_2 = offsetTemp_2Slider.value
                    live: false
                }
                Text{
                    id: offsetTemp_2SliderUnit
                    text:"°C"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetTemp_2Slider.right
                    anchors.verticalCenter: offsetTemp_2Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainVolt_1Label
                target: gainVolt_1Slider
                text:"<b>Gain Voltage 1:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: parent.top
                    topMargin: parent.height/30
                    left: gainVolt_2Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: gainVolt_1Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainVolt_1
                    stepSize: 0.1
                    onValueChanged: gainVolt_1 = value
                    onUserSet: platformInterface.gainVolt_1 = gainVolt_1Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetVolt_1Label
                target: offsetVolt_1Slider
                text:"<b>Offset Voltage 1:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainVolt_1Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_2Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: offsetVolt_1Slider
                    width: parent.width
                    from: -1000
                    to: 1000
                    value: platformInterface.offsetVolt_1
                    stepSize: 1
                    onValueChanged: offsetVolt_1 = value
                    onUserSet: platformInterface.offsetVolt_1 = offsetVolt_1Slider.value
                    live: false
                }
                Text{
                    id: offsetVolt_1SliderUnit
                    text:"V"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetVolt_1Slider.right
                    anchors.verticalCenter: offsetVolt_1Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainCurrent_1Label
                target: gainCurrent_1Slider
                text:"<b>Gain Current 1:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: offsetVolt_1Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_2Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: gainCurrent_1Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainCurrent_1
                    stepSize: 0.1
                    onValueChanged: gainCurrent_1 = value
                    onUserSet: platformInterface.gainCurrent_1 = gainCurrent_1Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetCurrent_1Label
                target: offsetCurrent_1Slider
                text:"<b>Offset Current 1:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainCurrent_1Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_2Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: offsetCurrent_1Slider
                    width: parent.width
                    from: -1000
                    to: 1000
                    value: platformInterface.offsetCurrent_1
                    stepSize: 1
                    onValueChanged: offsetCurrent_1 = value
                    onUserSet: platformInterface.offsetCurrent_1 = offsetCurrent_1Slider.value
                    live: false
                }
                Text{
                    id: offsetCurrent_1SliderUnit
                    text:"A"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetCurrent_1Slider.right
                    anchors.verticalCenter: offsetCurrent_1Slider.top
                    }
            }

            SGAlignedLabel{
                id: gainTemp_1Label
                target: gainTemp_1Slider
                text:"<b>Gain Temperature 1:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: offsetCurrent_1Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_2Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: gainTemp_1Slider
                    width: parent.width
                    from: 0
                    to: 100
                    value: platformInterface.gainTemp_1
                    stepSize: 0.1
                    onValueChanged: gainTemp_1 = value
                    onUserSet: platformInterface.gainTemp_1 = gainTemp_1Slider.value
                    live: false
                }
            }

            SGAlignedLabel{
                id: offsetTemp_1Label
                target: offsetTemp_1Slider
                text:"<b>Offset Temperature 1:<b>"
                font.pixelSize: (parent.width + parent.height)/ 150
                width: parent.width/10
                anchors {
                    top: gainTemp_1Label.bottom
                    topMargin: parent.height/30
                    left: gainVolt_2Label.right
                    leftMargin: parent.height/15
                    }
                SGSlider {
                    id: offsetTemp_1Slider
                    width: parent.width
                    from: -200
                    to: 200
                    value: platformInterface.offsetTemp_1
                    stepSize: 1
                    onValueChanged: offsetTemp_1 = value
                    onUserSet: platformInterface.offsetTemp_1 = offsetTemp_1Slider.value
                    live: false
                }
                Text{
                    id: offsetTemp_1SliderUnit
                    text:"°C"
                    font.pixelSize: (parent.width + parent.height)/20
                    color: "black"
                    anchors.left: offsetTemp_1Slider.right
                    anchors.verticalCenter: offsetTemp_1Slider.top
                    }
            }


        }
}

