import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import tech.strata.sgwidgets 1.0
import "control-views"

Item {
    id: controlViewRoot
    property string class_id

    RowLayout {
        
        anchors.fill: parent
        spacing: 0

        PlatformInterface {
            id: platformInterface
        }

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
                    text: "Advanced"
                }

            }

            StackLayout {
                currentIndex: tabBar.currentIndex

                Basic {
                    id: basic
                }

                Advanced {
                    id: advanced
                }
            }
        }        
    }
}