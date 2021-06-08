import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import tech.strata.sgwidgets 1.0
import "control-views"

RowLayout {
    id: controlViewRoot
    spacing: 0

    SideBar {
        id: sideBar
    }

    ColumnLayout {
        spacing: 0

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton {
                text: "Basic"
            }

            TabButton {
                text: "Controls and Parameters"
            }

        }

        Loader {
            id: loader
            Layout.fillWidth: true
            Layout.fillHeight: true

            sourceComponent: {
                switch (tabBar.currentIndex) {
                case 0:
                    return basicView
                case 1:
                    return controlsParametersView
                }
            }
        }

        Component {
            id: basicView

            Basic {}
        }

        Component {
            id: controlsParametersView

            ControlsParameters {}
        }
    }
}
