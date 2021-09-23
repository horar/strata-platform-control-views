import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Rectangle {
    id: root
    height: 100
    width: 100
    border {
        width: 1
        color: "#fff"
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            SGSwitch {
                id: dummy_switch
                checkedLabel: "Dummy"
                uncheckedLabel: "Real"
                onToggled: {
                    if(checked) {
                        basic.addCommand("dummy_data","true")
                    }
                    else {
                        basic.addCommand("dummy_data","false")
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
