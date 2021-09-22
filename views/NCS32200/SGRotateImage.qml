import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Item {
    property alias source: rotatingBox.source

    Image {
        id: rotatingBox
        fillMode: Image.PreserveAspectFit
        source: source
        height: parent.height
        anchors {
            centerIn: parent
        }
        layer.enabled: true
        layer.effect: DropShadow {
            samples: 8
            verticalOffset: 3
            horizontalOffset: 1
        }

        states: State {
            name: "moved"
            PropertyChanges { target: rect; x: 0 }
        }

        transitions: Transition {
            PropertyAnimation { properties: "x"; easing.type: Easing.InOutQuad }
        }
    }
}



