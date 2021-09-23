/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import tech.strata.theme 1.0

ComboBox {
    id: root
    height: 32 * fontSizeMultiplier
    implicitWidth: modelWidth + height + contentItem.leftPadding
    font.pixelSize: 13 * root.fontSizeMultiplier
    model: ["First", "Second", "Third"]

    property color textColor: "black"
    property color indicatorColor: "#B3B3B3"
    property color borderColor: "#B3B3B3"
    property color boxColor: "white"
    property bool dividers: false
    property real popupHeight: 300 * fontSizeMultiplier
    property real fontSizeMultiplier: 1.0
    property string placeholderText
    property real modelWidth: textMetrics.contentWidth

    Component.onCompleted: findWidth()
    onModelChanged: findWidth()

    Connections{
        target: Array.isArray(model)? null : model
        onCountChanged: {
            findWidth()
        }
    }

    indicator: SGIcon {
        id: iconImage
        rotation: root.popup.visible ? 180 : 0
        anchors {
            verticalCenter: root.verticalCenter
            right: root.right
            rightMargin: root.height/2 - width/2
        }

        iconColor: root.pressed ? colorMod(root.indicatorColor, .25) : root.indicatorColor
        source: "qrc:/sgimages/chevron-down.svg"
        width: height
        height: root.height/2
    }

    contentItem: TextField {
        id: textField
        anchors {
            fill: parent
            rightMargin: root.height
        }
        leftPadding: 10
        rightPadding: 0

        text: root.editable ? root.editText : root.displayText
        enabled: root.enabled && root.editable
        autoScroll: root.editable
        readOnly: root.down
        font: root.font
        //            inputMethodHints: root.inputMethodHints
        //            validator: root.validator
        placeholderText: root.placeholderText

        color: root.textColor
        selectionColor: root.palette.highlight
        selectedTextColor: root.palette.highlightedText
        verticalAlignment: Text.AlignVCenter

        background: Rectangle {
            visible: root.enabled && root.editable && !root.flat
            border.width: parent && parent.activeFocus && !parent.readOnly ? 2 : 1
            border.color: parent && parent.activeFocus && !parent.readOnly ? "#219647" : root.borderColor
            color: root.boxColor
        }
        onAccepted: parent.focus = false
        Keys.forwardTo: root
    }

    background: Rectangle {
        implicitWidth: root.width
        height: root.height
        border.color: root.pressed ? colorMod(root.borderColor, .25) : root.borderColor
        border.width: root.visualFocus ? 2 : 1
        radius: 2
    }

    popup: Popup {
        y: root.height - 1
        width: root.width
        implicitHeight: Math.min(contentItem.implicitHeight + ( 2 * padding ), root.popupHeight)
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: root.popup.visible ? root.delegateModel : null
            currentIndex: root.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {
                active: true
            }
        }

        background: Rectangle {
            border.color: root.borderColor
            radius: 2
        }

        opacity: root.delegateModel.count > 0 ? 1 : 0
    }

    delegate: ItemDelegate {
        id: delegate
        width: root.width
        height: Math.max (root.height, contentItem.implicitHeight + 10)  // Add/Subtract from this to modify list item heights in popup
        topPadding: 0
        bottomPadding: 0
        highlighted: root.highlightedIndex === index
        contentItem: SGText {
            text: root.textRole ? (Array.isArray(root.model) ? modelData[root.textRole] : model[root.textRole]) : modelData
            implicitColor: root.textColor
            font: textField.font
            //                elide: Text.ElideRight
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            id: delegateBackground
            implicitWidth: root.width
            color: delegate.highlighted ? colorMod(root.boxColor, -0.05) : root.boxColor

            Rectangle {
                id: delegateDivider
                visible: root.dividers && index !== root.count - 1
                width: delegateBackground.width - 20
                height: 1
                color: colorMod(root.boxColor, -0.05)
                anchors {
                    bottom: delegateBackground.bottom
                    horizontalCenter: delegateBackground.horizontalCenter
                }
            }
        }
    }

    Text {
        // using Text instead of TextMetrics due to font rendering bug related to OSX default SF font tracking
        id: textMetrics
        visible: false
        font: root.font
    }

    function findWidth () {
        // calculates implicitWidth of comboBox based on the widest text in the given model
        var width = 0
        var widestIndex = 0
        if (Array.isArray(root.model)) {
            if (model.length <= 0) return
            for (var i = 0; i < model.length; i++) {
                textMetrics.text = root.textRole ? model[i][root.textRole] : model[i]
                if (textMetrics.contentWidth > width) {
                    widestIndex = i
                    width = textMetrics.contentWidth
                }
            }
            textMetrics.text = root.textRole ? model[widestIndex][root.textRole] : model[widestIndex]
        } else {
            if (root.textRole) {
                if (model.count <= 0) return
                for (var j = 0; j < model.count; j++) {
                    textMetrics.text = model.get(j)[root.textRole]
                    if (textMetrics.contentWidth > width) {
                        widestIndex = j
                        width = textMetrics.contentWidth
                    }
                }
                textMetrics.text = model.get(widestIndex)[root.textRole]
            } else {
                console.log("Must assign textRole to use width auto-adjustment")
            }
        }
    }

    // Add increment to color (within range of 0-1) add to lighten, subtract to darken
    function colorMod (color, increment) {
        return Qt.rgba(color.r + increment, color.g + increment, color.b + increment, 1 )
    }
}
