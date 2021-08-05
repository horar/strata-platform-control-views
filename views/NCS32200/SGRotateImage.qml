import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4


Rectangle {
    id: rect
    width: 80; height: 80
    color: "transparent"

    z: -1

    Image {
        id: rotatingBox
        fillMode: Image.PreserveAspectFit
        source: "target_edited.png"
        anchors.fill: parent

        states: State {
            name: "moved"
            PropertyChanges { target: rect; x: 0 }
        }

        transitions: Transition {
            PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad }
        }
    }
}



