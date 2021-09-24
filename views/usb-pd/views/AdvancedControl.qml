/*
 * Copyright (c) 2018-2021 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Controls 2.2
import "../sgwidgets"
import "advanced-partial-views"

Rectangle {
    id: root

    property bool debugLayout: false

    anchors {
        fill: parent
    }

    SGAccordion {
        id: settingsAccordion
        anchors {
            top: root.top
            bottom: root.bottom
        }
        width: root.width
        scrollBarPolicy: ScrollBar.AlwaysOn

        accordionItems: Column {
            SGAccordionItem {
                title: "<b>System Settings</b>"
                open: true
                contents: SystemSettings {
                    //
                }
            }

            SGAccordionItem {
                title: "<b>Port 1</b>"
                open: true
                contents: SGPopout {
                    portNumber: 1
                    portColor: "#30a2db"
                }
            }

            SGAccordionItem {
                title: "<b>Port 2</b>"
                open: true
                contents: SGPopout {
                    portNumber: 2
                    portColor: "#3bb539"
                }
            }
        }

        SGLayoutDebug {
            visible: debugLayout
        }
    }
}
