import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import tech.strata.sgwidgets 1.0
import tech.strata.fonts 1.0

Rectangle {
    id: root
    height: 100
    width: 150
    border {
        width: 1
        color: "#fff"
    }

    Item {
        anchors {
            fill: root
            margins: 1
        }
        clip: true

        Column {
            width: parent.width

            Rectangle {
                id: header
                color: "#eee"
                width: parent.width
                height: 40

                Text {
                    text: "Debug"
                    anchors {
                        verticalCenter: header.verticalCenter
                        left: header.left
                        leftMargin: 15
                    }
                }

                Button {
                    text: "X"
                    height: 30
                    width: height
                    onClicked: root.visible = false
                    anchors {
                        right: header.right
                    }
                }
            }

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
    }
    Rectangle {
        id: shadow
        anchors.fill: root
        visible: false
    }

    DropShadow {
        anchors.fill: shadow
        radius: 15.0
        samples: 30
        source: shadow
        z: -1
    }
}
