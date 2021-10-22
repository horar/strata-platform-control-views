import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Image {
    id: rotatingBox
    fillMode: Image.PreserveAspectFit
    source: source

    states: State {
        name: "moved"
        PropertyChanges { target: rect; x: 0 }
    }

    transitions: Transition {
        PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad }
    }
}

