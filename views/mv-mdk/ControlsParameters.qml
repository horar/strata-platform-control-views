import QtQuick 2.12

import tech.strata.sgwidgets 1.0

UIBase { // start_uibase
    columnCount: 30
    rowCount: 25

    LayoutText { // start_8695e
        id: text_8695e
        layoutInfo.uuid: "8695e"
        layoutInfo.columnsWide: 28
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 0

        text: "BLDC Motor Drive EVB for 30-60V 1200W Applications"
        fontSizeMode: Text.Fit
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_8695e

    LayoutText { // start_bb4f0
        id: text_bb4f0
        layoutInfo.uuid: "bb4f0"
        layoutInfo.columnsWide: 28
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 1

        text: "Part of the Motor Development Kit (MDK) Family"
        fontSizeMode: Text.Fit
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#7f7f7f"
    } // end_bb4f0


    LayoutDivider { // start_578da
        id: divider_578da
        layoutInfo.uuid: "578da"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 3
    } // end_578da

    LayoutDivider { // start_a9879
        id: layoutDivider_a9879
        layoutInfo.uuid: "a9879"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 3
    } // end_a9879

    LayoutDivider { // start_af218
        id: layoutDivider_af218
        layoutInfo.uuid: "af218"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 3
    } // end_af218

    LayoutText { // start_99acd
        id: layoutText_99acd
        layoutInfo.uuid: "99acd"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 3

        text: "PWM Settings"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_99acd

    LayoutText { // start_0f99c
        id: layoutText_0f99c
        layoutInfo.uuid: "0f99c"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 13

        text: "Protection Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_0f99c

    LayoutText { // start_57735
        id: layoutText_57735
        layoutInfo.uuid: "57735"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 13

        text: "PID Control Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_57735

    LayoutText { // start_e09f2
        id: layoutText_e09f2
        layoutInfo.uuid: "e09f2"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 3

        text: "Speed Loop Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_e09f2

    LayoutText { // start_1f951
        id: layoutText_1f951
        layoutInfo.uuid: "1f951"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 3

        text: "Motor and Load Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_1f951




    LayoutDivider { // start_ac34b
        id: layoutDivider_ac34b
        layoutInfo.uuid: "ac34b"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 13
    } // end_ac34b

    LayoutDivider { // start_8edf6
        id: layoutDivider_8edf6
        layoutInfo.uuid: "8edf6"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 13
    } // end_8edf6

    LayoutSGSwitch { // start_d68f2
        id: switch_d68f2
        layoutInfo.uuid: "d68f2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 5

        checked: true
        checkedLabel: "Bipolar"
        uncheckedLabel: "Unipolar"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
        }
    } // end_d68f2

    LayoutText { // start_65728
        id: text_65728
        layoutInfo.uuid: "65728"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 5

        text: "Output Type"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_65728

    LayoutSGSlider { // start_b8761
        id: sgSlider_b8761
        layoutInfo.uuid: "b8761"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 7

        from: 10
        to: 1000
        stepSize: 10
        showLabels: true
        // fromText: "10ns"
        // toText: "1000ns"

        live: false

        onUserSet: {
            console.log("onUserSet:", value)
        }

    } // end_b8761

    LayoutText { // start_855ec
        id: layoutText_855ec
        layoutInfo.uuid: "855ec"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 6

        text: "Deadtime"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_855ec

    LayoutSGSlider { // start_547f7
        id: sgSlider_547f7
        layoutInfo.uuid: "547f7"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 9

        from: 0
        to: 10
        live: false

        onUserSet: {
            console.log("onUserSet:", value)
        }
    } // end_547f7
} // end_uibase