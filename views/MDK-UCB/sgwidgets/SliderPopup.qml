import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import tech.strata.sgwidgets 1.0

Popup {
    id: sliderPopup
    closePolicy: Popup.NoAutoClose

    property alias value: targetSlider.value
    property string unit
    property alias from: targetSlider.from
    property alias to: targetSlider.to
    property alias title: title.text

    Connections {
        target: parent
        onVisibleChanged: {
            if (parent.visible === false) {
                sliderPopup.close()
            }
        }
    }

    background: Rectangle {
        color: sideBar.color

        Rectangle {
            width: 1
            height: parent.height
            color: Qt.darker(parent.color)
        }
    }

    RowLayout {
        height: parent.height
        spacing:10

        SGText {
            id: title
            font.bold: true
            color: "lightgrey"
            fontSizeMultiplier: 1.25
        }

        SGSlider {
            id: targetSlider
            Layout.preferredWidth: 300
            Layout.fillWidth: true
            inputBox.unit: sliderPopup.unit
            inputBox.boxColor: "#222"
            inputBoxWidth: 100
            textColor: "grey"
            stepSize: 1
            live: false
        }
    }
}
