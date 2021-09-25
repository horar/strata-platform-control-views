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

Item {
    id: root
    clip: true

    property real minimumHeight: 800
    property real minimumWidth: 1000
    property alias contentItem : content.sourceComponent

    ScrollView {
        id: scrollView
        anchors {
            fill: root
        }

        contentWidth: content.width
        contentHeight: content.height

        ScrollBar.vertical: ScrollBar {
            visible: content.height !== scrollView.height
            interactive: visible
            z: 100
            parent: scrollView
            anchors {
                right: scrollView.right
                top: scrollView.top
                bottom: scrollView.bottom
            }
            contentItem: Rectangle {
                implicitWidth: 15
                implicitHeight: 15
                radius: width / 2
                color: "white"
            }
        }

        ScrollBar.horizontal: ScrollBar {
            visible: content.width !== scrollView.width
            interactive: visible
            z: 100
            parent: scrollView
            anchors {
                bottom: scrollView.bottom
                right: scrollView.right
                left: scrollView.left
            }
            contentItem: Rectangle {
                implicitWidth: 15
                implicitHeight: 15
                radius: height / 2
                color: "white"
            }
        }

        Loader {
            id: content

            width: root.width < root.minimumWidth ? root.minimumWidth : root.width
            height: root.height < root.minimumHeight ? root.minimumHeight : root.height
        }
    }
}
