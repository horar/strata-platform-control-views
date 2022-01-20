/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Controls 2.2
import "../sgwidgets"
import "../views/advanced-partial-views"

Rectangle {
    id: root

    property bool debugLayout: false

    anchors {
        fill: parent
    }

    Overview {
        id: overview
        height: 310

        SGLayoutDivider {
            position: "bottom"
        }
    }

    SGAccordion {
        id: settingsAccordion
        anchors {
            top: overview.bottom
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
                    enableAssuredPower: false
                }
            }

            SGAccordionItem {
                title: "<b>Port 3</b>"
                open: true
                contents: SGPopout {
                    portNumber: 3
                    portColor: "#d68f14"
                    enableAssuredPower: false
                }
            }

            SGAccordionItem {
                title: "<b>Port 4</b>"
                open: true
                contents: SGPopout {
                    portNumber: 4
                    portConnected: false
                    portColor: "#2348cd"
                    enableAssuredPower: false
                }
            }
        }

        SGLayoutDebug {
            visible: debugLayout
        }
    }
}
