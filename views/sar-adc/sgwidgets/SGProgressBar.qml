/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.3

Item {
    id: root
    property real percent_complete: 0
    property bool animation_completed: false
    property alias progressBarContainer: progressBarContainer
    implicitWidth: 100
    implicitHeight: root.labelLeft ? progressBarContainer.height : progressBarContainer.height + progressStatus.height + progressBarContainer.anchors.topMargin


    Rectangle {
        id: progressBarContainer
        height: 30
        border {
            width: 1
            color: "#bbb"
        }
        color: "transparent"
        width: root.width
        anchors {
            centerIn: parent
        }

        Rectangle {
            id: progressBar
            color: "#33b13b"
            height: progressBarContainer.height - 6
            anchors {
                verticalCenter: progressBarContainer.verticalCenter
                left: progressBarContainer.left
                leftMargin: 3
            }
            width: progressBarContainer.width * percent_complete
        }
    }

    Text {
        id: progressStatus
        text: "" + (100 * progressBar.width / (progressBarContainer.width - 6)).toFixed(0) + "% complete"
        color: "#bbb"
        font.bold: true
        anchors {
            bottom: progressBarContainer.top
            right: progressBarContainer.right
            bottomMargin: 3
        }

    }

}
