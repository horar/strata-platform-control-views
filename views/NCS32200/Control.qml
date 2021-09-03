import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "qrc:/js/help_layout_manager.js" as Help

import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Rectangle {
    id: controlRoot
    anchors {
        fill: parent
    }
    color: "light gray"

    BasicControl { }

    PlatformInterface {
        id: platformInterface

    }

}
