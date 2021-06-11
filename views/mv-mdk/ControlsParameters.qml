import QtQuick 2.12

import tech.strata.sgwidgets 1.0

UIBase { // start_uibase
    
    // General settings    
    columnCount: 30
    rowCount: 50
    
    // Objects shared between QML files
    // property alias cp_title: cp_title
    // property alias cp_subtitle: cp_subtitle

    // UI objects
    LayoutText { // start_8695e
        id: cp_title
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
        id: cp_subtitle
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
        id: cp_pwm_params_o_mode
        layoutInfo.uuid: "d68f2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 9
 
        checkedLabel: "Bipolar"
        uncheckedLabel: "Unipolar"
        labelsInside: true

        checked: true

        onToggled: {
            console.log("onToggled:", checked)
            platformInterface.commands.pwm_params.update(
                cp_pwm_params_dt.value / 10,
                cp_pwm_params_freq.value * 1000,
                cp_pwm_params_min_ls.value / 10,
                Number(checked),
                Number(cp_pwm_params_tr_delay.text)
            )
        }
        
    } // end_d68f2

    LayoutText { // start_65728
        id: cp_pwm_params_o_mode_caption
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
        id: cp_pwm_params_dt
        layoutInfo.uuid: "b8761"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 13

        from: 60
        to: 10000
        stepSize: 10
        live: false
        inputBox.readOnly: true

        value: 100

        onUserSet: {
            console.log("onUserSet:", value)
            platformInterface.commands.pwm_params.update(
                value / 10,
                cp_pwm_params_freq.value * 1000,
                cp_pwm_params_min_ls.value / 10,
                Number(cp_pwm_params_o_mode.checked),
                Number(cp_pwm_params_tr_delay.text)
            )
        }

    } // end_b8761

    LayoutText { // start_855ec
        id: cp_pwm_params_dt_caption
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
        id: cp_pwm_params_min_ls
        layoutInfo.uuid: "547f7"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 18

        from: 100
        to: 10000
        stepSize: 10
        live: false
        inputBox.readOnly: true
        
        value: 100

        onUserSet: {
            console.log("onUserSet:", value)
            platformInterface.commands.pwm_params.update(
                cp_pwm_params_dt.value / 10,
                cp_pwm_params_freq.value * 1000,
                value / 10,
                Number(cp_pwm_params_o_mode.checked),
                Number(cp_pwm_params_tr_delay.text)
            )
        }

    } // end_547f7

    LayoutText { // start_62f6b
        id: cp_pwm_params_min_ls_caption
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
        id: cp_pwm_params_freq_caption
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
        id: cp_pwm_params_freq
        layoutInfo.uuid: "b15e0"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 23

        from: 10
        to: 50
        stepSize: 1
        live: false

        value: 20

        onUserSet: {
            console.log("onUserSet:", value)
            platformInterface.commands.pwm_params.update(
                cp_pwm_params_dt.value / 10,
                value * 1000,
                cp_pwm_params_min_ls.value / 10,
                Number(cp_pwm_params_o_mode.checked),
                Number(cp_pwm_params_tr_delay.text)
            )
        }

    } // end_b15e0

    LayoutSGInfoBox { // start_61e5b
        id: cp_pwm_params_tr_delay
        layoutInfo.uuid: "61e5b"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 27

        text: "0"
        readOnly: false

        validator: IntValidator {
            bottom: 0
        }

        onEditingFinished : {
            console.log("Accepted:", text)
            platformInterface.commands.pwm_params.update(
                cp_pwm_params_dt.value / 10,
                cp_pwm_params_freq.value * 1000,
                cp_pwm_params_min_ls.value / 10,
                Number(cp_pwm_params_o_mode.checked),
                Number(text)
            )
        }

    } // end_61e5b

    LayoutText { // start_bf582
        id: cp_pwm_params_tr_delay_caption
        layoutInfo.uuid: "bf582"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 27

        text: "TR Delay (ns)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter

    } // end_bf582

    LayoutSGInfoBox { // start_4517c
        id: cp_pid_params_kp
        layoutInfo.uuid: "4517c"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 4
        layoutInfo.yRows: 33

        readOnly: false
        text: "50.0" 

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            platformInterface.commands.pid_params.update(
                Number(text),
                Number(cp_pid_params_ki.text),
                Number(cp_pid_params_kd.text),
                Number(cp_pid_params_wd.text),
                Number(cp_pid_params_lim.text),
                Number(cp_pid_params_tau_sys.text),
                Number(cp_pid_params_mode.checked)
            )
        }
    } // end_4517c

    LayoutSGInfoBox { // start_1d4dc
        id: cp_pid_params_ki
        layoutInfo.uuid: "1d4dc"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 6
        layoutInfo.yRows: 33

        readOnly: false
        text: "50.0" 

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            platformInterface.commands.pid_params.update(
                Number(cp_pid_params_kp.text),
                Number(text),
                Number(cp_pid_params_kd.text),
                Number(cp_pid_params_wd.text),
                Number(cp_pid_params_lim.text),
                Number(cp_pid_params_tau_sys.text),
                Number(cp_pid_params_mode.checked)
            )
        }

    } // end_1d4dc

    LayoutSGInfoBox { // start_4b295
        id: cp_pid_params_kd
        layoutInfo.uuid: "4b295"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 8
        layoutInfo.yRows: 33

        readOnly: false
        text: "50.0" 

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            platformInterface.commands.pid_params.update(
                Number(cp_pid_params_kp.text),
                Number(cp_pid_params_ki.text),
                Number(text),
                Number(cp_pid_params_wd.text),
                Number(cp_pid_params_lim.text),
                Number(cp_pid_params_tau_sys.text),
                Number(cp_pid_params_mode.checked)
            )
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
        id: cp_pid_params_kp_caption
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
        id: cp_pid_params_ki_caption
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
        id: cp_pid_params_kd_caption
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
        id: cp_pid_params_wd
        layoutInfo.uuid: "cd9bc"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 36

        text: "1000.0"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            platformInterface.commands.pid_params.update(
                Number(cp_pid_params_kp.text),
                Number(cp_pid_params_ki.text),
                Number(cp_pid_params_kd.text),
                Number(text),
                Number(cp_pid_params_lim.text),
                Number(cp_pid_params_tau_sys.text),
                Number(cp_pid_params_mode.checked)
            )
        }
    } // end_cd9bc

    LayoutSGInfoBox { // start_9ac57
        id: cp_pid_params_lim
        layoutInfo.uuid: "9ac57"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 39

        text: "24.0"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            platformInterface.commands.pid_params.update(
                Number(cp_pid_params_kp.text),
                Number(cp_pid_params_ki.text),
                Number(cp_pid_params_kd.text),
                Number(cp_pid_params_wd.text),
                Number(text),
                Number(cp_pid_params_tau_sys.text),
                Number(cp_pid_params_mode.checked)
            )
        }
    } // end_9ac57

    LayoutSGInfoBox { // start_625e9
        id: cp_pid_params_tau_sys
        layoutInfo.uuid: "625e9"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 42

        text: "10.0"
        readOnly: false // Set readOnly: false if you like to make SGInfoBox Editable

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            platformInterface.commands.pid_params.update(
                Number(cp_pid_params_kp.text),
                Number(cp_pid_params_ki.text),
                Number(cp_pid_params_kd.text),
                Number(cp_pid_params_wd.text),
                Number(cp_pid_params_lim.text),
                Number(text),
                Number(cp_pid_params_mode.checked)
            )
        }
    } // end_625e9

    LayoutSGSwitch { // start_b8452
        id: cp_pid_params_mode
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
            platformInterface.commands.pid_params.update(
                Number(cp_pid_params_kp.text),
                Number(cp_pid_params_ki.text),
                Number(cp_pid_params_kd.text),
                Number(cp_pid_params_wd.text),
                Number(cp_pid_params_lim.text),
                Number(cp_pid_params_tau_sys.text),
                Number(checked)
            )
        }
    } // end_b8452

    LayoutText { // start_cb3ed
        id: cp_pid_params_wd_caption
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
        id: cp_pid_params_lim_caption
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
        id: cp_pid_params_tau_sys_caption
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
        id: cp_pid_params_mode_caption
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
        id: cp_motor_params_rs
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
        id: cp_motor_params_ls
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
        id: cp_motor_params_jm
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
        id: cp_motor_params_jm_load
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
        id: cp_motor_params_kv
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
        id: cp_motor_params_kv_load
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
        id: cp_motor_params_pp
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
        id: cp_motor_params_max_rpm
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
        id: cp_motor_params_rated_rpm
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
        id: cp_motor_params_min_rpm
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
        id: cp_motor_params_ke
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
        id: cp_motor_params_rated_v
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
        id: cp_motor_params_hall_pol
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
        id: cp_motor_params_rs_caption
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
        id: cp_motor_params_ls_caption
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
        id: cp_motor_params_jm_caption
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
        id: cp_motor_params_jm_load_caption
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
        id: cp_motor_params_kv_caption
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
        id: cp_motor_params_kv_load_caption
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
        id: cp_motor_params_pp_caption
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
        id: cp_motor_params_max_rpm_caption
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
        id: cp_motor_params_rated_rpm_caption
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
        id: cp_motor_params_min_rpm_caption
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
        id: cp_motor_params_ke_caption
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
        id: cp_motor_params_rated_v_caption
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
        id: cp_motor_params_hall_pol_caption
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

    LayoutSGComboBox { // start_f5402
        id: cp_spd_loop_params_mode
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

        // TODO: mode_caption
        
    } // end_f5402

    LayoutText { // start_b10f9
        id: cp_spd_loop_params_mode_caption
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
        id: cp_spd_loop_params_accel
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
        id: cp_spd_loop_params_accel_caption
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
        id: cp_spd_loop_params_fs
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
        id: cp_spd_loop_params_fspd_filt
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
        id: cp_spd_loop_params_fs_caption
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
        id: cp_spd_loop_params_fspd_filt_caption
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
        id: cp_protection_ocp
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
        id: cp_protection_ocp_en
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
        id: cp_protection_ovp
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
        id: cp_protection_ovp_en
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
        id: cp_protection_fet_otp
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
        id: cp_protection_ocp_caption
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
        id: cp_protection_ocp_en_caption
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
        id: cp_protection_ovp_caption
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
        id: cp_protection_ovp_en_caption
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
        id: cp_protection_fet_otp_caption
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