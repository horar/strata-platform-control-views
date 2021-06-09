import QtQuick 2.12

import tech.strata.sgwidgets 1.0

UIBase { // start_uibase
    columnCount: 30
    rowCount: 50

    LayoutText { // start_8695e
        id: title_2
        layoutInfo.uuid: "8695e"
        layoutInfo.columnsWide: 28
        layoutInfo.rowsTall: 2
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
        id: subtitle_2
        layoutInfo.uuid: "bb4f0"
        layoutInfo.columnsWide: 28
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 2

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
        layoutInfo.yRows: 7
        thickness: 2
    } // end_578da

    LayoutDivider { // start_a9879
        id: layoutDivider_a9879
        layoutInfo.uuid: "a9879"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 7
        thickness: 2
    } // end_a9879

    LayoutDivider { // start_af218
        id: layoutDivider_af218
        layoutInfo.uuid: "af218"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 7
        thickness: 2
    } // end_af218

    LayoutText { // start_99acd
        id: layoutText_99acd
        layoutInfo.uuid: "99acd"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 6

        text: "PWM Settings"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_99acd

    LayoutText { // start_0f99c
        id: layoutText_0f99c
        layoutInfo.uuid: "0f99c"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 22

        text: "Protection Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_0f99c

    LayoutText { // start_57735
        id: layoutText_57735
        layoutInfo.uuid: "57735"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 30

        text: "PID Control Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_57735

    LayoutText { // start_e09f2
        id: layoutText_e09f2
        layoutInfo.uuid: "e09f2"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 6

        text: "Speed Loop Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_e09f2

    LayoutText { // start_1f951
        id: layoutText_1f951
        layoutInfo.uuid: "1f951"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 6

        text: "Motor and Load Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
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
        layoutInfo.yRows: 31
        thickness: 2
    } // end_ac34b

    LayoutDivider { // start_8edf6
        id: layoutDivider_8edf6
        layoutInfo.uuid: "8edf6"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 23
        thickness: 2
    } // end_8edf6

    LayoutSGSwitch { // start_d68f2
        id: switch_d68f2
        layoutInfo.uuid: "d68f2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 9

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
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 9

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
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 13

        from: 10
        to: 1000
        stepSize: 10
        // showLabels: true
        live: false

        onUserSet: {
            console.log("onUserSet:", value)
        }

        // onValueChanged: console.info("Slider value is now:", value)  // Signals on any value change (both user and programmatic changes)
        // onUserSet: console.info("Slider set by user to:", value)     // Signals when user sets value (affected by live)
        

    } // end_b8761

    LayoutText { // start_855ec
        id: layoutText_855ec
        layoutInfo.uuid: "855ec"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 12

        text: "Deadtime (ns)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_855ec

    LayoutSGSlider { // start_547f7
        id: sgSlider_547f7
        layoutInfo.uuid: "547f7"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 18

        from: 10
        to: 1000
        stepSize: 10
        live: false

        onUserSet: {
            console.log("onUserSet:", value)
        }
    } // end_547f7

    LayoutText { // start_62f6b
        id: layoutText_62f6b
        layoutInfo.uuid: "62f6b"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 17

        text: "Minimum Allowed LS FET On-time (ns)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_62f6b

    LayoutText { // start_b6660
        id: layoutText_b6660
        layoutInfo.uuid: "b6660"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 22

        text: "Switching Frequency (kHz)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_b6660

    LayoutSGSlider { // start_b15e0
        id: layoutSGSlider_b15e0
        layoutInfo.uuid: "b15e0"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 23

        from: 10
        to: 50
        stepSize: 1
        live: false

        onUserSet: {
            console.log("onUserSet:", value)
            platformInterface.commands.pwm_params.update(1,1,1,1,1);
            // platformInterface.commands.pwm_params.send(;)
        }

        value: platformInterface.notifications.actual_speed_value.value
        // value: 20

    } // end_b15e0

    LayoutSGComboBox { // start_f5402
        id: sgComboBox_f5402
        layoutInfo.uuid: "f5402"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 10

        model: ["Open Loop", "Closed with Step Speed Reference", "Closed with Ramped Speed Reference"]
        currentIndex: 1
        
        onActivated: {
            console.log("onActivated:", currentIndex, currentText)
        }
    } // end_f5402

    LayoutSGInfoBox { // start_61e5b
        id: sgInfoBox_61e5b
        layoutInfo.uuid: "61e5b"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 27

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_61e5b

    LayoutText { // start_bf582
        id: layoutText_bf582
        layoutInfo.uuid: "bf582"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 27

        text: "TR Delay (clock cycles)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_bf582

    LayoutSGInfoBox { // start_4517c
        id: layoutSGInfoBox_4517c
        layoutInfo.uuid: "4517c"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 4
        layoutInfo.yRows: 33

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_4517c

    LayoutSGInfoBox { // start_1d4dc
        id: layoutSGInfoBox_1d4dc
        layoutInfo.uuid: "1d4dc"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 6
        layoutInfo.yRows: 33

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_1d4dc

    LayoutSGInfoBox { // start_4b295
        id: layoutSGInfoBox_4b295
        layoutInfo.uuid: "4b295"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 8
        layoutInfo.yRows: 33

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_4b295

    LayoutText { // start_e917b
        id: layoutText_e917b
        layoutInfo.uuid: "e917b"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 33

        text: "Gains"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_e917b

    LayoutText { // start_6d06a
        id: layoutText_6d06a
        layoutInfo.uuid: "6d06a"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 3
        layoutInfo.yRows: 33

        text: "Kp"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    } // end_6d06a

    LayoutText { // start_2ca39
        id: layoutText_2ca39
        layoutInfo.uuid: "2ca39"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 5
        layoutInfo.yRows: 33

        text: "Ki"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    } // end_2ca39

    LayoutText { // start_752ae
        id: layoutText_752ae
        layoutInfo.uuid: "752ae"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 33

        text: "Kd"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    } // end_752ae

    LayoutSGInfoBox { // start_cd9bc
        id: layoutSGInfoBox_cd9bc
        layoutInfo.uuid: "cd9bc"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 36

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_cd9bc

    LayoutSGInfoBox { // start_9ac57
        id: layoutSGInfoBox_9ac57
        layoutInfo.uuid: "9ac57"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 39

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_9ac57

    LayoutSGInfoBox { // start_625e9
        id: layoutSGInfoBox_625e9
        layoutInfo.uuid: "625e9"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 42

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_625e9

    LayoutSGSwitch { // start_b8452
        id: layoutSGSwitch_b8452
        layoutInfo.uuid: "b8452"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 45

        checked: true
        checkedLabel: "Auto"
        uncheckedLabel: "Manual"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
        }
    } // end_b8452

    LayoutText { // start_cb3ed
        id: layoutText_cb3ed
        layoutInfo.uuid: "cb3ed"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 36

        text: "Derivative Term LP Cutoff Freq (rads/s)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_cb3ed

    LayoutText { // start_d46ff
        id: layoutText_d46ff
        layoutInfo.uuid: "d46ff"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 39

        text: "Integral Error Limit (V)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_d46ff

    LayoutText { // start_2d719
        id: layoutText_2d719
        layoutInfo.uuid: "2d719"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 42

        text: "System Time Constant (s)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_2d719

    LayoutText { // start_6893f
        id: layoutText_6893f
        layoutInfo.uuid: "6893f"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 45

        text: "PID Control Gain Mode"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_6893f

    LayoutSGInfoBox { // start_7b111
        id: layoutSGInfoBox_7b111
        layoutInfo.uuid: "7b111"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 9

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_7b111

    LayoutSGInfoBox { // start_b2002
        id: layoutSGInfoBox_b2002
        layoutInfo.uuid: "b2002"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 12

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_b2002

    LayoutSGInfoBox { // start_6bb67
        id: layoutSGInfoBox_6bb67
        layoutInfo.uuid: "6bb67"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 15

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_6bb67

    LayoutSGInfoBox { // start_c26b5
        id: layoutSGInfoBox_c26b5
        layoutInfo.uuid: "c26b5"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 18

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_c26b5

    LayoutSGInfoBox { // start_e7154
        id: layoutSGInfoBox_e7154
        layoutInfo.uuid: "e7154"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 21

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_e7154

    LayoutSGInfoBox { // start_d33f4
        id: layoutSGInfoBox_d33f4
        layoutInfo.uuid: "d33f4"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 24

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_d33f4

    LayoutSGInfoBox { // start_9a955
        id: layoutSGInfoBox_9a955
        layoutInfo.uuid: "9a955"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 27

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_9a955

    LayoutSGInfoBox { // start_18fca
        id: layoutSGInfoBox_18fca
        layoutInfo.uuid: "18fca"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 30

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_18fca

    LayoutSGInfoBox { // start_a85c0
        id: layoutSGInfoBox_a85c0
        layoutInfo.uuid: "a85c0"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 33

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_a85c0

    LayoutSGInfoBox { // start_16b29
        id: layoutSGInfoBox_16b29
        layoutInfo.uuid: "16b29"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 36

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_16b29

    LayoutSGInfoBox { // start_cc444
        id: layoutSGInfoBox_cc444
        layoutInfo.uuid: "cc444"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 39

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_cc444

    LayoutSGInfoBox { // start_d3605
        id: layoutSGInfoBox_d3605
        layoutInfo.uuid: "d3605"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 42

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_d3605

    LayoutSGSwitch { // start_7baa1
        id: layoutSGSwitch_7baa1
        layoutInfo.uuid: "7baa1"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 18
        layoutInfo.yRows: 45

        checked: true
        checkedLabel: "Active High"
        uncheckedLabel: "Active Low"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
        }
    } // end_7baa1

    LayoutText { // start_fdceb
        id: layoutText_fdceb
        layoutInfo.uuid: "fdceb"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 9

        text: "Line-Line Stator R (Ohms)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_fdceb

    LayoutText { // start_caedc
        id: layoutText_caedc
        layoutInfo.uuid: "caedc"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 12

        text: "Line-Line Stator L (H)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_caedc

    LayoutText { // start_1dadf
        id: layoutText_1dadf
        layoutInfo.uuid: "1dadf"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 15

        text: "Rotor Inertia (kg-m2)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_1dadf

    LayoutText { // start_576d3
        id: layoutText_576d3
        layoutInfo.uuid: "576d3"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 18

        text: "Load Inertia (kg-m2)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_576d3

    LayoutText { // start_92896
        id: layoutText_92896
        layoutInfo.uuid: "92896"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 21

        text: "Motor Damping (kg-m2/s)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_92896

    LayoutText { // start_ba70b
        id: layoutText_ba70b
        layoutInfo.uuid: "ba70b"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 24

        text: "Load Damping (kg-m2/s)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_ba70b

    LayoutText { // start_f9ec8
        id: layoutText_f9ec8
        layoutInfo.uuid: "f9ec8"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 27

        text: "Pole Pairs"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_f9ec8

    LayoutText { // start_40687
        id: layoutText_40687
        layoutInfo.uuid: "40687"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 30

        text: "Max RPM"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_40687

    LayoutText { // start_507bc
        id: layoutText_507bc
        layoutInfo.uuid: "507bc"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 33

        text: "Rated RPM"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_507bc

    LayoutText { // start_999d2
        id: layoutText_999d2
        layoutInfo.uuid: "999d2"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 36

        text: "Min RPM"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_999d2

    LayoutText { // start_95206
        id: layoutText_95206
        layoutInfo.uuid: "95206"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 39

        text: "Ke BEMF Constant (V-s/rad)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_95206

    LayoutText { // start_bc611
        id: layoutText_bc611
        layoutInfo.uuid: "bc611"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 42

        text: "Rated Voltage (V)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_bc611

    LayoutText { // start_ee7f4
        id: layoutText_ee7f4
        layoutInfo.uuid: "ee7f4"
        layoutInfo.columnsWide: 6
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 45

        text: "Hall Polarity"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_ee7f4

    LayoutText { // start_b10f9
        id: layoutText_b10f9
        layoutInfo.uuid: "b10f9"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 9

        text: "Speed Loop Mode"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_b10f9

    LayoutSGInfoBox { // start_33053
        id: layoutSGInfoBox_33053
        layoutInfo.uuid: "33053"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 13

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_33053

    LayoutText { // start_451b8
        id: layoutText_451b8
        layoutInfo.uuid: "451b8"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 13

        text: "Acceleration Rate (RPM/s)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_451b8

    LayoutSGInfoBox { // start_d3ebf
        id: layoutSGInfoBox_d3ebf
        layoutInfo.uuid: "d3ebf"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 16

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_d3ebf

    LayoutSGInfoBox { // start_c31f8
        id: layoutSGInfoBox_c31f8
        layoutInfo.uuid: "c31f8"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 19

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_c31f8




    LayoutText { // start_b87f9
        id: layoutText_b87f9
        layoutInfo.uuid: "b87f9"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 16

        text: "Sampling Freq (Hz)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_b87f9

    LayoutText { // start_db3ed
        id: layoutText_db3ed
        layoutInfo.uuid: "db3ed"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 19

        text: "LP Filter Cutoff Freq (Hz)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_db3ed

    LayoutSGInfoBox { // start_4c1a9
        id: layoutSGInfoBox_4c1a9
        layoutInfo.uuid: "4c1a9"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 26

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_4c1a9

    LayoutSGSwitch { // start_5ce22
        id: layoutSGSwitch_5ce22
        layoutInfo.uuid: "5ce22"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 29

        checked: true
        checkedLabel: "On"
        uncheckedLabel: "Off"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
        }
    } // end_5ce22

    LayoutSGInfoBox { // start_90ed2
        id: layoutSGInfoBox_90ed2
        layoutInfo.uuid: "90ed2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 32

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_90ed2

    LayoutSGSwitch { // start_830dc
        id: layoutSGSwitch_830dc
        layoutInfo.uuid: "830dc"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 35

        checked: true
        checkedLabel: "On"
        uncheckedLabel: "Off"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
        }
    } // end_830dc

    LayoutSGInfoBox { // start_9599e
        id: layoutSGInfoBox_9599e
        layoutInfo.uuid: "9599e"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 38

        text: "100"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        onAccepted: {
           console.log("Accepted:", text)
        }
    } // end_9599e

    LayoutText { // start_96a85
        id: layoutText_96a85
        layoutInfo.uuid: "96a85"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 26

        text: "Software OCP (A)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_96a85

    LayoutText { // start_65a38
        id: layoutText_65a38
        layoutInfo.uuid: "65a38"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 29

        text: "Software OCP Enable"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_65a38

    LayoutText { // start_6229d
        id: layoutText_6229d
        layoutInfo.uuid: "6229d"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 32

        text: "Vin OVP Limit (V)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_6229d

    LayoutText { // start_70467
        id: layoutText_70467
        layoutInfo.uuid: "70467"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 35

        text: "Software OVP Enable"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_70467

    LayoutText { // start_00a13
        id: layoutText_00a13
        layoutInfo.uuid: "00a13"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 38

        text: "MOSFET OTP Limit (C)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_00a13
} // end_uibase