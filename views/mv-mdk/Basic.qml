import QtQuick 2.12

import tech.strata.sgwidgets 1.0

UIBase { // start_uibase
    columnCount: 30
    rowCount: 25




    LayoutText { // start_8695e
        id: text_8695e
        layoutInfo.uuid: "8695e"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 12
        layoutInfo.yRows: 0

        text: "Title"
        fontSizeMode: Text.Fit
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_8695e

    LayoutText { // start_bb4f0
        id: text_bb4f0
        layoutInfo.uuid: "bb4f0"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 12
        layoutInfo.yRows: 1

        text: "Subtitle"
        fontSizeMode: Text.Fit
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#7f7f7f"
    } // end_bb4f0

    LayoutRectangle { // start_6a35c
        id: rect_6a35c
        layoutInfo.uuid: "6a35c"
        layoutInfo.columnsWide: 7
        layoutInfo.rowsTall: 15
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 3

        color: "#ffffff"
        border.width: 3
    } // end_6a35c




    LayoutDivider { // start_c0d6c
        id: divider_c0d6c
        layoutInfo.uuid: "c0d6c"
        layoutInfo.columnsWide: 7
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 3
    } // end_c0d6c




    LayoutRectangle { // start_bead4
        id: layoutRectangle_bead4
        layoutInfo.uuid: "bead4"
        layoutInfo.columnsWide: 20
        layoutInfo.rowsTall: 15
        layoutInfo.xColumns: 9
        layoutInfo.yRows: 3

        color: "#ffffff"
        border.width: 3
    } // end_bead4




    LayoutText { // start_6d841
        id: layoutText_6d841
        layoutInfo.uuid: "6d841"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 2
        layoutInfo.yRows: 3

        text: "Input"
        fontSizeMode: Text.Fit
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_6d841




    LayoutText { // start_aad3b
        id: layoutText_aad3b
        layoutInfo.uuid: "aad3b"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 16
        layoutInfo.yRows: 3

        text: "Output"
        fontSizeMode: Text.Fit
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_aad3b

    LayoutDivider { // start_ef0b6
        id: layoutDivider_ef0b6
        layoutInfo.uuid: "ef0b6"
        layoutInfo.columnsWide: 20
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 9
        layoutInfo.yRows: 3
    } // end_ef0b6

    LayoutSGCircularGauge { // start_7b02e
        id: layoutSGCircularGauge_7b02e
        layoutInfo.uuid: "7b02e"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 15
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 3

        unitText: "RPM"
        minimumValue: 0
        maximumValue: 10000
        tickmarkStepSize: 1000
        value: 3000

        function lerpColor (color1, color2, x){
            if (Qt.colorEqual(color1, color2)){
                return color1;
            } else {
                return Qt.hsva(
                    color1.hsvHue * (1 +  x) + color2.hsvHue * x,
                    color1.hsvSaturation * (1 + x) + color2.hsvSaturation * x,
                    color1.hsvValue * (1 + x) + color2.hsvValue * x, 1
                    );
            }
        }
    } // end_7b02e

    LayoutSGCircularGauge { // start_116ab
        id: layoutSGCircularGauge_116ab
        layoutInfo.uuid: "116ab"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 9
        layoutInfo.xColumns: 23
        layoutInfo.yRows: 7

        unitText: "C"
        minimumValue: 0
        maximumValue: 140
        tickmarkStepSize: 20
        value: 23.0

        function lerpColor (color1, color2, x){
            if (Qt.colorEqual(color1, color2)){
                return color1;
            } else {
                return Qt.hsva(
                    color1.hsvHue * (1 +  x) + color2.hsvHue * x,
                    color1.hsvSaturation * (1 + x) + color2.hsvSaturation * x,
                    color1.hsvValue * (1 + x) + color2.hsvValue * x, 1
                    );
            }
        }
    } // end_116ab

    LayoutSGCircularGauge { // start_b06c4
        id: layoutSGCircularGauge_b06c4
        layoutInfo.uuid: "b06c4"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 9
        layoutInfo.xColumns: 2
        layoutInfo.yRows: 7

        unitText: "V"
        minimumValue: 0
        maximumValue: 100
        tickmarkStepSize: 10
        value: 48

        function lerpColor (color1, color2, x){
            if (Qt.colorEqual(color1, color2)){
                return color1;
            } else {
                return Qt.hsva(
                    color1.hsvHue * (1 +  x) + color2.hsvHue * x,
                    color1.hsvSaturation * (1 + x) + color2.hsvSaturation * x,
                    color1.hsvValue * (1 + x) + color2.hsvValue * x, 1
                    );
            }
        }
    } // end_b06c4




    LayoutContainer { // start_abcde
        id: statusLogBox
        layoutInfo.uuid: "abcde"
        layoutInfo.columnsWide: 28
        layoutInfo.rowsTall: 5
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 19
        contentItem: SGStatusLogBox {
            title: "Default Status Logs"
            Component.onCompleted: {
                for (let i = 0; i < 10; i++){
                    append("Message " + i)
                }
            }
        }
    } // end_abcde


    LayoutText { // start_f52c7
        id: text_f52c7
        layoutInfo.uuid: "f52c7"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 2
        layoutInfo.yRows: 15

        text: "Input Voltage (V)"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_f52c7

    LayoutText { // start_18cff
        id: layoutText_18cff
        layoutInfo.uuid: "18cff"
        layoutInfo.columnsWide: 4
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 13
        layoutInfo.yRows: 16

        text: "Actual Speed (RPM)"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_18cff

    LayoutText { // start_d490f
        id: layoutText_d490f
        layoutInfo.uuid: "d490f"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 23
        layoutInfo.yRows: 15

        text: "MOSFET Temp (C)"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_d490f
} // end_uibase