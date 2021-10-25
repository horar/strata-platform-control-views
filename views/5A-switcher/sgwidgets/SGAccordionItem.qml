/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Layouts 1.3

// SGAccordionItem is a clickable title bar that drops down an area that can be filled with items

Rectangle {
    id: root
    height: titleBar.height + contentContainer.height + divider.height
    width: scrollContainerWidth
    clip: true

    property alias contents: contents.sourceComponent

    property string title: "Default Title Text"
    property bool open: false
    property int openCloseTime: accordionOpenCloseTime
    property string statusIcon: accordionStatusIcon
    property color textOpenColor: accordionTextOpenColor
    property color textClosedColor: accordionTextClosedColor
    property color contentsColor: accordionContentsColor
    property color headerOpenColor: accordionHeaderOpenColor
    property color headerClosedColor: accordionHeaderClosedColor
    property alias dividerColor: divider.color

    Rectangle {
        id: titleBar
        width: root.width
        height: 32
        color: root.open ? headerOpenColor : headerClosedColor

        Text {
            id: titleText
            text: title
            elide: Text.ElideRight
            color: root.open ? root.textOpenColor : root.textClosedColor
            anchors {
                verticalCenter: titleBar.verticalCenter
                left: titleBar.left
                leftMargin: 10
                right: minMaxContainer.left
            }
        }

        Item {
            id: minMaxContainer
            width: titleBar.height
            height: width
            anchors {
               right: titleBar.right
            }

            Text {
                id: minMaxIcon
                color: root.open ? root.textOpenColor : root.textClosedColor
                text: statusIcon
                rotation: root.open ? 180 : 0
                anchors {
                    verticalCenter: minMaxContainer.verticalCenter
                    horizontalCenter: minMaxContainer.horizontalCenter
                }
            }
        }

        MouseArea {
            id: titleBarClick
            anchors { fill: titleBar }
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (root.open) {
                    closeContent.start()
                    root.open = !root.open
                } else {
                    openContent.start()
                    root.open = !root.open
                }
            }
        }
    }

    Rectangle {
        id: contentContainer
        width: root.width
        height: 0
        color: root.contentsColor
        anchors {
            top: titleBar.bottom
        }

        Component.onCompleted: {
            if (root.open) {
                bindHeight()  // If open, bind height to contents.height so contents can dynamically resize the accordionItem
            }
        }

        Loader {
            id: contents
            anchors {
                top: contentContainer.top
                left: contentContainer.left
                right: contentContainer.right
            }
        }
    }

    Rectangle {
        id: divider
        anchors { bottom: root.bottom }
        width: root.width
        height: 1
        color: accordionDividerColor
    }

    NumberAnimation {
        id: closeContent
        target: contentContainer
        property: "height"
        from: contentContainer.height
        to: 0
        duration: openCloseTime
        onStopped: {
            contentContainer.height = 0  // Bind height to 0 so any content resizing while closed doesn't resize the accordionItem
        }
    }

    NumberAnimation {
        id: openContent
        target: contentContainer
        property: "height"
        from: 0
        to: contents.height
        duration: openCloseTime
        onStopped: {
            bindHeight()  // Rebind to contents.height while open so contents can dynamically resize the accordionItem
        }
    }

    function bindHeight() {
        contentContainer.height = Qt.binding(function() { return contents.height })
        return
    }
}
