/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import "qrc:/js/core_platform_interface.js" as CorePlatformInterface

// This is an example debug menu that shows how you can test your UI by injecting
// spoofed notifications to simulate a connected platform board.
//
// It is for development and should be removed from finalized UI's.

Rectangle {
    id: root
    height: 200
    width: 350
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
                    text: "Debug (inject fake platform notifications):"
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

            Button {
                id: motorRunningTrue
                text: "read input vol"
                onClicked: {
                    CorePlatformInterface.data_source_handler('{
                                "value":"input_notification",
                                "payload":{
                                            "vin": ' + (Math.random()*264).toFixed(0) + ',
                                            "iin": '+ (Math.random()*5).toFixed(2) +',
                                            "pin": '+ (Math.random()*125).toFixed(0) +'
                                }
                        }')
                }
            }

            Button {
                id: motorRunningTrue2
                text: "read output vol"
                onClicked: {
                    CorePlatformInterface.data_source_handler('{
                                "value":"output_notification",
                                "payload":{
                                            "vout": ' + (Math.random()*15).toFixed(2) + ',
                                            "iout": '+ (Math.random()*15).toFixed(2) +',
                                            "pout": '+ (Math.random()*150).toFixed(2) +'
                                }
                        }')
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
