import QtQuick 2.12

import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.sgwidgets 1.0
import tech.strata.sglayout 1.0
import QtTest 1.1

UIBase { // start_uibase
    
    // ======================== General Settings ======================== //

    columnCount: 30
    rowCount: 50
    
    // ======================== UI Initialization ======================== //
    
    Component.onCompleted: {

        // ------------------------ Help Messages ------------------------ //

        // PWM Settings
        Help.registerTarget(cp_pwm_params_o_mode_help, "PWM output set to either bipolar or unipolar.", 0, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pwm_params_dt_help, "PWM deadtime received by the MOSFET gate driver. This may need to be adjusted based on the MOSFET selection to avoid cross conduction.", 1, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pwm_params_min_ls_help, "Minimum allowed low side MOSFET ON time.", 2, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pwm_params_freq_help, "PWM switching frequency received by the gate driver.", 3, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pwm_params_tr_delay_help, "Clock cycles to delay ADC sampling from midpoint of PWM on time.", 4, "ControlsAndParametersHelp")
        // PID Control Parameters
        Help.registerTarget(cp_pid_params_kx_help, "PID gain controls for proportional (Kp), integral (Ki), and derivative (Kd) gains. Set derivative gain to zero for only PI control.", 5, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pid_params_wd_help, "Derivative term low-pass filter cutoff frequency.", 6, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pid_params_lim_help, "Integral error term limit. Normally set to DC bus voltage.", 7, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pid_params_tau_sys_help, "System time constant for auto IMC-calculated PID gain.", 8, "ControlsAndParametersHelp")
        Help.registerTarget(cp_pid_params_mode_help, "PID control gain mode. Auto = calculated from motor params. Manual = manual settings above used.", 9, "ControlsAndParametersHelp")
        // Motor and Load Parameters
        Help.registerTarget(cp_motor_params_xs_help, "Motor line to line stator resistance and inductance.", 10, "ControlsAndParametersHelp")
        Help.registerTarget(cp_motor_params_jm_kv_help, "Motor/load inertia and viscous damping.", 11, "ControlsAndParametersHelp")
        Help.registerTarget(cp_motor_params_pp_help, "Number of motor pole pairs.", 12, "ControlsAndParametersHelp")
        Help.registerTarget(cp_motor_params_rpm_help, "Maximum RPM of the motor. Setting the maximum value will update the Target Speed slider maximum value on the left menu.", 13, "ControlsAndParametersHelp")
        Help.registerTarget(cp_motor_params_ke_help, "Motor back electromotive force (BEMF) constant.", 14, "ControlsAndParametersHelp")
        Help.registerTarget(cp_motor_params_rated_v_help, "Motor rated DC bus voltage.", 15, "ControlsAndParametersHelp")
        Help.registerTarget(cp_motor_params_hall_pol_help, "Hall sensor polarity set to active high/low.", 16, "ControlsAndParametersHelp")
        // Speed Loop Parameters
        Help.registerTarget(cp_spd_loop_params_mode_help, "Speed loop mode options.", 17, "ControlsAndParametersHelp")
        Help.registerTarget(cp_spd_loop_params_accel_help, "Acceleration applied when the motor is starting. Setting the value will update the Acceleration slider value on the left menu.", 18, "ControlsAndParametersHelp")
        Help.registerTarget(cp_spd_loop_params_fs_help, "Speed loop sampling frequency.", 19, "ControlsAndParametersHelp")
        Help.registerTarget(cp_spd_loop_params_fspd_filt_help, "Speed measurement low-pass filter cutoff frequency.", 20, "ControlsAndParametersHelp")
        // Protection Parameters
        Help.registerTarget(cp_protection_ocp_help, "Software over current protection (OCP) value and state. The status of an OCP event is shown on the left menu. A protection event will disable the motor.", 21, "ControlsAndParametersHelp")
        Help.registerTarget(cp_protection_ovp_help, "Hardware over voltage protection (OVP) value and state. The status of an OVP event is shown on the left menu. A protection event will disable the motor.", 22, "ControlsAndParametersHelp")
        Help.registerTarget(cp_protection_fet_otp_help, "MOSFET over temperature (OTP) value. The status of an OTP event is shown on the left menu. A protection event will disable the motor.", 23, "ControlsAndParametersHelp")
        Help.registerTarget(cp_save_load_parameters_help, "The parameters on this tab can be saved to disk and recalled for flexibility testing with motors, loads, etc. that have different specifications. Enter a name for the parameter set and click Save to write to disk. This will place the parameter set into the combo box. Select the desired parameter set and the combo box and click Load to recall. Select the desired parameter set to remove from the combo box and click Delete.\n\nThese parameters are saved as a .json file in '%APPDATA%\\Roaming\\ON Semiconductor\\Strata Developer Studio\\settings' directory and can be transfer between PCs if desired.", 24, "ControlsAndParametersHelp")

    }

    // ------------------------ Send Default Controls/Parameters to FW when Requested ------------------------ //
        
    Connections {
        target: platformInterface.notifications.request_params
        onNotificationFinished: {
            send_pwm_params()
            send_pid_params()
            send_motor_params()
            send_spd_loop_params()
            send_protection()
        }
    }

    // ======================== UI Objects ======================== //

    // ------------------------ General UI Setup and Titles ------------------------ //

    LayoutText { // start_8695e
        id: cp_title
        layoutInfo.uuid: "8695e"
        layoutInfo.columnsWide: 28
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 0

        text: platformInterface.notifications.title.caption
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

        text: platformInterface.notifications.subtitle.caption
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

    // ------------------------ PWM Parameters ------------------------ //

    function send_pwm_params() {
        platformInterface.commands.pwm_params.update(
            cp_pwm_params_dt.value / 10,
            cp_pwm_params_freq.value * 1000,
            cp_pwm_params_min_ls.value / 10,
            Number(cp_pwm_params_o_mode.checked),
            Number(cp_pwm_params_tr_delay.text)
        )
    }

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
            send_pwm_params()
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
            send_pwm_params()
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
            send_pwm_params()
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
            send_pwm_params()
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
            send_pwm_params()
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

    // ------------------------ PID Parameters ------------------------ //

    function send_pid_params() {
        platformInterface.commands.pid_params.update(
            Number(cp_pid_params_kd.text),
            Number(cp_pid_params_ki.text),
            Number(cp_pid_params_kp.text),
            Number(cp_pid_params_lim.text),
            Number(cp_pid_params_mode.checked),            
            Number(cp_pid_params_tau_sys.text),
            Number(cp_pid_params_wd.text)
        )
    }

    LayoutSGInfoBox { // start_4517c
        id: cp_pid_params_kp
        layoutInfo.uuid: "4517c"
        layoutInfo.columnsWide: 1
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 4
        layoutInfo.yRows: 33

        readOnly: false
        text: "50" 

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_pid_params()
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
        text: "50" 

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_pid_params()
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
        text: "50" 

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_pid_params()
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

        text: "1000"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_pid_params()
        }
    } // end_cd9bc

    LayoutSGInfoBox { // start_9ac57
        id: cp_pid_params_lim
        layoutInfo.uuid: "9ac57"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 39

        text: "24"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_pid_params()
        }
    } // end_9ac57

    LayoutSGInfoBox { // start_625e9
        id: cp_pid_params_tau_sys
        layoutInfo.uuid: "625e9"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 42

        text: "10"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_pid_params()
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
            send_pid_params()
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

    // ------------------------ Motor Parameters ------------------------ //

    function send_motor_params() {
        platformInterface.commands.motor_params.update(
            Number(cp_motor_params_hall_pol.checked),
            Number(cp_motor_params_jm.text),
            Number(cp_motor_params_jm_load.text),
            Number(cp_motor_params_ke.text),
            Number(cp_motor_params_kv.text),
            Number(cp_motor_params_kv_load.text),
            Number(cp_motor_params_ls.text),
            Number(cp_motor_params_max_rpm.text),
            Number(cp_motor_params_min_rpm.text),
            Number(cp_motor_params_pp.text),
            Number(cp_motor_params_rated_rpm.text),
            Number(cp_motor_params_rated_v.text),
            Number(cp_motor_params_rs.text)  
        )
    }

    LayoutSGInfoBox { // start_7b111
        id: cp_motor_params_rs
        layoutInfo.uuid: "7b111"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 9
        
        text: "0.5"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }

    } // end_7b111

    LayoutSGInfoBox { // start_b2002
        id: cp_motor_params_ls
        layoutInfo.uuid: "b2002"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 12

        text: "0.001"
        readOnly: false

        validator: DoubleValidator {
            decimals: 3
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_b2002

    LayoutSGInfoBox { // start_6bb67
        id: cp_motor_params_jm
        layoutInfo.uuid: "6bb67"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 15

        text: "0.000001"
        readOnly: false

        validator: DoubleValidator {
            decimals: 6
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_6bb67

    LayoutSGInfoBox { // start_c26b5
        id: cp_motor_params_jm_load
        layoutInfo.uuid: "c26b5"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 18

        text: "0.000001"
        readOnly: false

        validator: DoubleValidator {
            decimals: 6
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_c26b5

    LayoutSGInfoBox { // start_e7154
        id: cp_motor_params_kv
        layoutInfo.uuid: "e7154"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 21

        text: "0.000001"
        readOnly: false

        validator: DoubleValidator {
            decimals: 6
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_e7154

    LayoutSGInfoBox { // start_d33f4
        id: cp_motor_params_kv_load
        layoutInfo.uuid: "d33f4"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 24

        text: "0.000001"
        readOnly: false

        validator: DoubleValidator {
            decimals: 6
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_d33f4

    LayoutSGInfoBox { // start_9a955
        id: cp_motor_params_pp
        layoutInfo.uuid: "9a955"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 27

        text: "4"
        readOnly: false

        validator: IntValidator {
            top: 24
            bottom: 1
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_9a955

    LayoutSGInfoBox { // start_18fca
        id: cp_motor_params_max_rpm
        layoutInfo.uuid: "18fca"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 30

        text: "4200"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
            // Update Target Speed slider with maximum value
            platformInterface.notifications.target_speed.scales.index_0 = Number(cp_motor_params_max_rpm.text)
        }
    } // end_18fca

    LayoutSGInfoBox { // start_a85c0
        id: cp_motor_params_rated_rpm
        layoutInfo.uuid: "a85c0"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 33

        text: "3000"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_a85c0

    LayoutSGInfoBox { // start_16b29
        id: cp_motor_params_min_rpm
        layoutInfo.uuid: "16b29"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 36

        text: "60"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_16b29

    LayoutSGInfoBox { // start_cc444
        id: cp_motor_params_ke
        layoutInfo.uuid: "cc444"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 39

        text: "0.01"
        readOnly: false

        validator: DoubleValidator {
            decimals: 2
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
        }
    } // end_cc444

    LayoutSGInfoBox { // start_d3605
        id: cp_motor_params_rated_v
        layoutInfo.uuid: "d3605"
        layoutInfo.columnsWide: 3
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 17
        layoutInfo.yRows: 42

        text: "24"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onEditingFinished: {
            console.log("Accepted:", text)
            send_motor_params()
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
            send_motor_params()
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

    // ------------------------ Speed Loop Parameters ------------------------ //

    function send_spd_loop_params() {
        platformInterface.commands.spd_loop_params.update(
            Number(cp_spd_loop_params_accel.text),
            Number(cp_spd_loop_params_fs.text),
            Number(cp_spd_loop_params_fspd_filt.text),
            cp_spd_loop_params_mode.currentIndex
        )
    }

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
            send_spd_loop_params()
        }        
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
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onAccepted: {
            console.log("Accepted:", text)
            send_spd_loop_params()
            // Update Acceleration slider with set value
            platformInterface.notifications.acceleration.value = Number(text)
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

        text: "1000"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onAccepted: {
            console.log("Accepted:", text)
            send_spd_loop_params()
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
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onAccepted: {
            console.log("Accepted:", text)
            send_spd_loop_params()
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

    // ------------------------ Protection ------------------------ //

    function send_protection() {
        platformInterface.commands.protection.update(
            Number(cp_protection_fet_otp.text),
            Number(cp_protection_ocp.text),
            Number(cp_protection_ocp_en.checked),
            Number(cp_protection_ovp.text),
            Number(cp_protection_ovp_en.checked)
        )
    }

    LayoutSGInfoBox { // start_4c1a9
        id: cp_protection_ocp
        layoutInfo.uuid: "4c1a9"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 25

        text: "80"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onAccepted: {
            console.log("Accepted:", text)
            send_protection()
        }

    } // end_4c1a9

    LayoutSGSwitch { // start_5ce22
        id: cp_protection_ocp_en
        layoutInfo.uuid: "5ce22"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 28

        checked: true
        checkedLabel: "On"
        uncheckedLabel: "Off"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
            send_protection()
        }
    } // end_5ce22

    LayoutSGInfoBox { // start_90ed2
        id: cp_protection_ovp
        layoutInfo.uuid: "90ed2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 31

        text: "32"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onAccepted: {
           console.log("Accepted:", text)
           send_protection()
        }
    } // end_90ed2

    LayoutSGSwitch { // start_830dc
        id: cp_protection_ovp_en
        layoutInfo.uuid: "830dc"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 34

        checked: true
        checkedLabel: "On"
        uncheckedLabel: "Off"
        labelsInside: true

        onToggled: {
            console.log("onToggled:", checked)
            send_protection()
        }
    } // end_830dc

    LayoutSGInfoBox { // start_9599e
        id: cp_protection_fet_otp
        layoutInfo.uuid: "9599e"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 37

        text: "100"
        readOnly: false

        validator: DoubleValidator {
            decimals: 1
            bottom: 0.0
        }

        onAccepted: {
           console.log("Accepted:", text)
           send_protection()
        }
    } // end_9599e

    LayoutText { // start_96a85
        id: cp_protection_ocp_caption
        layoutInfo.uuid: "96a85"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 25

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
        layoutInfo.yRows: 28

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
        layoutInfo.yRows: 31

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
        layoutInfo.yRows: 34

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
        layoutInfo.yRows: 37

        text: "MOSFET OTP Limit (C)"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_00a13

    // ======================== Save and Load Parameters ======================== //

    function loadSettings(settingsName) {
        let config = sgUserSettings.readFile(settingsName, cp_save_button.subdirName)
        // PWM Settings
        if (config.hasOwnProperty('cp_pwm_params_o_mode')) {
            cp_pwm_params_o_mode_caption.text = config.cp_pwm_params_o_mode.caption
            cp_pwm_params_o_mode.enabled = config.cp_pwm_params_o_mode.states[0]
            cp_pwm_params_o_mode.checked = config.cp_pwm_params_o_mode.value
        }
        if (config.hasOwnProperty('cp_pwm_params_dt')) {
            cp_pwm_params_dt_caption.text = config.cp_pwm_params_dt.caption
            cp_pwm_params_dt.to = config.cp_pwm_params_dt.scales[0]
            cp_pwm_params_dt.from = config.cp_pwm_params_dt.scales[1]
            cp_pwm_params_dt.stepSize = config.cp_pwm_params_dt.scales[2]
            cp_pwm_params_dt.enabled = config.cp_pwm_params_dt.states[0]
            cp_pwm_params_dt.value = config.cp_pwm_params_dt.value
        }//
        if (config.hasOwnProperty('cp_pwm_params_min_ls')) {
            cp_pwm_params_min_ls_caption.text = config.cp_pwm_params_min_ls.caption
            cp_pwm_params_min_ls.to = config.cp_pwm_params_min_ls.scales[0]
            cp_pwm_params_min_ls.from = config.cp_pwm_params_min_ls.scales[1]
            cp_pwm_params_min_ls.stepSize = config.cp_pwm_params_min_ls.scales[2]
            cp_pwm_params_min_ls.enabled = config.cp_pwm_params_min_ls.states[0]
            cp_pwm_params_min_ls.value = config.cp_pwm_params_min_ls.value
        }
        if (config.hasOwnProperty('cp_pwm_params_freq')) {
            cp_pwm_params_freq_caption.text = config.cp_pwm_params_freq.caption
            cp_pwm_params_freq.to = config.cp_pwm_params_freq.scales[0]
            cp_pwm_params_freq.from = config.cp_pwm_params_freq.scales[1]
            cp_pwm_params_freq.stepSize = config.cp_pwm_params_freq.scales[2]
            cp_pwm_params_freq.enabled = config.cp_pwm_params_freq.states[0]
            cp_pwm_params_freq.value = config.cp_pwm_params_freq.value
        }
        if (config.hasOwnProperty('cp_pwm_params_tr_delay')) {
            cp_pwm_params_tr_delay_caption.text = config.cp_pwm_params_tr_delay.caption
            cp_pwm_params_tr_delay.enabled = config.cp_pwm_params_tr_delay.states[0]
            cp_pwm_params_tr_delay.text = config.cp_pwm_params_tr_delay.value
        }
        // PID Control Parameters
        if (config.hasOwnProperty('cp_pid_params_kp')) {
            cp_pid_params_kp_caption.text = config.cp_pid_params_kp.caption
            cp_pid_params_kp.enabled = config.cp_pid_params_kp.states[0]
            cp_pid_params_kp.text = config.cp_pid_params_kp.value
        }
        if (config.hasOwnProperty('cp_pid_params_ki')) {
            cp_pid_params_ki.text = config.cp_pid_params_ki.caption
            cp_pid_params_ki.enabled = config.cp_pid_params_ki.states[0]
            cp_pid_params_ki.text = config.cp_pid_params_ki.value
        }
        if (config.hasOwnProperty('cp_pid_params_kd')) {
            cp_pid_params_kd_caption.text = config.cp_pid_params_kd.caption
            cp_pid_params_kd.enabled = config.cp_pid_params_kd.states[0]
            cp_pid_params_kd.text = config.cp_pid_params_kd.value
        }
        if (config.hasOwnProperty('cp_pid_params_wd')) {
            cp_pid_params_wd_caption.text = config.cp_pid_params_wd.caption
            cp_pid_params_wd.enabled = config.cp_pid_params_wd.states[0]
            cp_pid_params_wd.text = config.cp_pid_params_wd.value
        }
        if (config.hasOwnProperty('cp_pid_params_lim')) {
            cp_pid_params_lim_caption.text = config.cp_pid_params_lim.caption
            cp_pid_params_lim.enabled = config.cp_pid_params_lim.states[0]
            cp_pid_params_lim.text = config.cp_pid_params_lim.value
        }
        if (config.hasOwnProperty('cp_pid_params_tau_sys')) {
            cp_pid_params_tau_sys_caption.text = config.cp_pid_params_tau_sys.caption
            cp_pid_params_tau_sys.enabled = config.cp_pid_params_tau_sys.states[0]
            cp_pid_params_tau_sys.text = config.cp_pid_params_tau_sys.value
        }
        if (config.hasOwnProperty('cp_pid_params_mode')) {
            cp_pid_params_mode_caption.text = config.cp_pid_params_mode.caption
            cp_pid_params_mode.enabled = config.cp_pid_params_mode.states[0]
            cp_pid_params_mode.checked = config.cp_pid_params_mode.value
        }
        // Motor and Load Parameters
        if (config.hasOwnProperty('cp_motor_params_rs')) {
            cp_motor_params_rs_caption.text = config.cp_motor_params_rs.caption
            cp_motor_params_rs.enabled = config.cp_motor_params_rs.states[0]
            cp_motor_params_rs.text = config.cp_motor_params_rs.value
        }
        if (config.hasOwnProperty('cp_motor_params_ls')) {
            cp_motor_params_ls_caption.text = config.cp_motor_params_ls.caption
            cp_motor_params_ls.enabled = config.cp_motor_params_ls.states[0]
            cp_motor_params_ls.text = config.cp_motor_params_ls.value
        }
        if (config.hasOwnProperty('cp_motor_params_jm')) {
            cp_motor_params_jm_caption.text = config.cp_motor_params_jm.caption
            cp_motor_params_jm.enabled = config.cp_motor_params_jm.states[0]
            cp_motor_params_jm.text = String(config.cp_motor_params_jm.value) // Convert to string to remove trailing zeros
        }
        if (config.hasOwnProperty('cp_motor_params_jm_load')) {
            cp_motor_params_jm_load_caption.text = config.cp_motor_params_jm_load.caption
            cp_motor_params_jm_load.enabled = config.cp_motor_params_jm_load.states[0]
            cp_motor_params_jm_load.text = String(config.cp_motor_params_jm_load.value) // Convert to string to remove trailing zeros
        }
        if (config.hasOwnProperty('cp_motor_params_kv')) {
            cp_motor_params_kv_caption.text = config.cp_motor_params_kv.caption
            cp_motor_params_kv.enabled = config.cp_motor_params_kv.states[0]
            cp_motor_params_kv.text = String(config.cp_motor_params_kv.value) // Convert to string to remove trailing zeros
        }
        if (config.hasOwnProperty('cp_motor_params_kv_load')) {
            cp_motor_params_kv_load_caption.text = config.cp_motor_params_kv_load.caption
            cp_motor_params_kv_load.enabled = config.cp_motor_params_kv_load.states[0]
            cp_motor_params_kv_load.text = String(config.cp_motor_params_kv_load.value) // Convert to string to remove trailing zeros
        }
        if (config.hasOwnProperty('cp_motor_params_pp')) {
            cp_motor_params_pp_caption.text = config.cp_motor_params_pp.caption
            cp_motor_params_pp.enabled = config.cp_motor_params_pp.states[0]
            cp_motor_params_pp.text = config.cp_motor_params_pp.value
        }
        if (config.hasOwnProperty('cp_motor_params_max_rpm')) {
            cp_motor_params_max_rpm_caption.text = config.cp_motor_params_max_rpm.caption
            cp_motor_params_max_rpm.enabled = config.cp_motor_params_max_rpm.states[0]
            cp_motor_params_max_rpm.text = config.cp_motor_params_max_rpm.value
        }
        if (config.hasOwnProperty('cp_motor_params_rated_rpm')) {
            cp_motor_params_rated_rpm_caption.text = config.cp_motor_params_rated_rpm.caption
            cp_motor_params_rated_rpm.enabled = config.cp_motor_params_rated_rpm.states[0]
            cp_motor_params_rated_rpm.text = config.cp_motor_params_rated_rpm.value
        }
        if (config.hasOwnProperty('cp_motor_params_min_rpm')) {
            cp_motor_params_min_rpm_caption.text = config.cp_motor_params_min_rpm.caption
            cp_motor_params_min_rpm.enabled = config.cp_motor_params_min_rpm.states[0]
            cp_motor_params_min_rpm.text = config.cp_motor_params_min_rpm.value
        }
        if (config.hasOwnProperty('cp_motor_params_ke')) {
            cp_motor_params_ke_caption.text = config.cp_motor_params_ke.caption
            cp_motor_params_ke.enabled = config.cp_motor_params_ke.states[0]
            cp_motor_params_ke.text = config.cp_motor_params_ke.value
        }
        if (config.hasOwnProperty('cp_motor_params_rated_v')) {
            cp_motor_params_rated_v_caption.text = config.cp_motor_params_rated_v.caption
            cp_motor_params_rated_v.enabled = config.cp_motor_params_rated_v.states[0]
            cp_motor_params_rated_v.text = config.cp_motor_params_rated_v.value
        }
        if (config.hasOwnProperty('cp_motor_params_hall_pol')) {
            cp_motor_params_hall_pol_caption.text = config.cp_motor_params_hall_pol.caption
            cp_motor_params_hall_pol.enabled = config.cp_motor_params_hall_pol.states[0]
            cp_motor_params_hall_pol.checked = config.cp_motor_params_hall_pol.value
        }
        // Speed Loop Parameters
        if (config.hasOwnProperty('cp_spd_loop_params_mode')) {
            cp_spd_loop_params_mode_caption.text = config.cp_spd_loop_params_mode.caption
            cp_spd_loop_params_mode.enabled = config.cp_spd_loop_params_mode.states[0]
            cp_spd_loop_params_mode.currentIndex = config.cp_spd_loop_params_mode.value
            cp_spd_loop_params_mode.model = config.cp_spd_loop_params_mode.values
        }
        if (config.hasOwnProperty('cp_spd_loop_params_accel')) {
            cp_spd_loop_params_accel_caption.text = config.cp_spd_loop_params_accel.caption
            cp_spd_loop_params_accel.enabled = config.cp_spd_loop_params_accel.states[0]
            cp_spd_loop_params_accel.text = config.cp_spd_loop_params_accel.value
        }
        if (config.hasOwnProperty('cp_spd_loop_params_fs')) {
            cp_spd_loop_params_fs_caption.text = config.cp_spd_loop_params_fs.caption
            cp_spd_loop_params_fs.enabled = config.cp_spd_loop_params_fs.states[0]
            cp_spd_loop_params_fs.text = config.cp_spd_loop_params_fs.value
        }
        if (config.hasOwnProperty('cp_spd_loop_params_fspd_filt')) {
            cp_spd_loop_params_fspd_filt_caption.text = config.cp_spd_loop_params_fspd_filt.caption
            cp_spd_loop_params_fspd_filt.enabled = config.cp_spd_loop_params_fspd_filt.states[0]
            cp_spd_loop_params_fspd_filt.text = config.cp_spd_loop_params_fspd_filt.value
        }
        // Protection Parameters
        if (config.hasOwnProperty('cp_protection_ocp')) {
            cp_protection_ocp_caption.text = config.cp_protection_ocp.caption
            cp_protection_ocp.enabled = config.cp_protection_ocp.states[0]
            cp_protection_ocp.text = config.cp_protection_ocp.value
        }
        if (config.hasOwnProperty('cp_protection_ocp_en')) {
            cp_protection_ocp_en_caption.text = config.cp_protection_ocp_en.caption
            cp_protection_ocp_en.enabled = config.cp_protection_ocp_en.states[0]
            cp_protection_ocp_en.checked = config.cp_protection_ocp_en.value
        }
        if (config.hasOwnProperty('cp_protection_ovp')) {
            cp_protection_ovp_caption.text = config.cp_protection_ovp.caption
            cp_protection_ovp.enabled = config.cp_protection_ovp.states[0]
            cp_protection_ovp.text = config.cp_protection_ovp.value
        }
        if (config.hasOwnProperty('cp_protection_ovp_en')) {
            cp_protection_ovp_en_caption.text = config.cp_protection_ovp_en.caption
            cp_protection_ovp_en.enabled = config.cp_protection_ovp_en.states[0]
            cp_protection_ovp_en.checked = config.cp_protection_ovp_en.value
        }
        if (config.hasOwnProperty('cp_protection_fet_otp')) {
            cp_protection_fet_otp_caption.text = config.cp_protection_fet_otp.caption
            cp_protection_fet_otp.enabled = config.cp_protection_fet_otp.states[0]
            cp_protection_fet_otp.text = config.cp_protection_fet_otp.value
        }
    }
    
    function saveSettings(settingsName) {
        sgUserSettings.writeFile(`${settingsName}.json`,
            {
                // PWM Settings
                "cp_pwm_params_o_mode": {
                    "caption": cp_pwm_params_o_mode_caption.text,
                    "scales": [],
                    "states": [cp_pwm_params_o_mode.enabled],
                    "value": cp_pwm_params_o_mode.checked,
                    "values": [],
                    "unit": ""
                },
                "cp_pwm_params_dt": {
                    "caption": cp_pwm_params_dt_caption.text,
                    "scales": [cp_pwm_params_dt.to, cp_pwm_params_dt.from, cp_pwm_params_dt.stepSize],
                    "states": [cp_pwm_params_dt.enabled],
                    "value": cp_pwm_params_dt.value,
                    "values": [],
                    "unit": ""
                },
                "cp_pwm_params_min_ls": {
                    "caption": cp_pwm_params_min_ls_caption.text,
                    "scales": [cp_pwm_params_min_ls.to, cp_pwm_params_min_ls.from, cp_pwm_params_min_ls.stepSize],
                    "states": [cp_pwm_params_min_ls.enabled],
                    "value": cp_pwm_params_min_ls.value,
                    "values": [],
                    "unit": ""
                },
                "cp_pwm_params_freq": {
                    "caption": cp_pwm_params_freq_caption.text,
                    "scales": [cp_pwm_params_freq.to, cp_pwm_params_freq.from, cp_pwm_params_freq.stepSize],
                    "states": [cp_pwm_params_freq.enabled],
                    "value": cp_pwm_params_freq.value,
                    "values": [],
                    "unit": ""
                },
                "cp_pwm_params_tr_delay": {
                    "caption": cp_pwm_params_tr_delay_caption.text,
                    "scales": [],
                    "states": [cp_pwm_params_tr_delay.enabled],
                    "value": Number(cp_pwm_params_tr_delay.text),
                    "values": [],
                    "unit": ""
                },
                // PID Control Parameters
                "cp_pid_params_kp": {
                    "caption": cp_pid_params_kp_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_kp.enabled],
                    "value": Number(cp_pid_params_kp.text),
                    "values": [],
                    "unit": ""
                },
                "cp_pid_params_ki": {
                    "caption": cp_pid_params_ki_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_ki.enabled],
                    "value": Number(cp_pid_params_ki.text),
                    "values": [],
                    "unit": ""
                },
                "cp_pid_params_kd": {
                    "caption": cp_pid_params_kd_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_kd.enabled],
                    "value": Number(cp_pid_params_kd.text),
                    "values": [],
                    "unit": ""
                },
                "cp_pid_params_wd": {
                    "caption": cp_pid_params_wd_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_wd.enabled],
                    "value": Number(cp_pid_params_wd.text),
                    "values": [],
                    "unit": ""
                },
                "cp_pid_params_lim": {
                    "caption": cp_pid_params_lim_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_lim.enabled],
                    "value": Number(cp_pid_params_lim.text),
                    "values": [],
                    "unit": ""
                },
                "cp_pid_params_tau_sys": {
                    "caption": cp_pid_params_tau_sys_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_tau_sys.enabled],
                    "value": Number(cp_pid_params_tau_sys.text),
                    "values": [],
                    "unit": ""
                },
                "cp_pid_params_mode": {
                    "caption": cp_pid_params_mode_caption.text,
                    "scales": [],
                    "states": [cp_pid_params_mode.enabled],
                    "value": cp_pid_params_mode.checked,
                    "values": [],
                    "unit": ""
                },
                // Motor and Load Parameters
                "cp_motor_params_rs": {
                    "caption": cp_motor_params_rs_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_rs.enabled],
                    "value": Number(cp_motor_params_rs.text),
                    "values": [],
                    "unit": ""
                },///
                "cp_motor_params_ls": {
                    "caption": cp_motor_params_ls_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_ls.enabled],
                    "value": Number(cp_motor_params_ls.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_jm": {
                    "caption": cp_motor_params_jm_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_jm.enabled],
                    "value": Number(cp_motor_params_jm.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_jm_load": {
                    "caption": cp_motor_params_jm_load_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_jm_load.enabled],
                    "value": Number(cp_motor_params_jm_load.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_kv": {
                    "caption": cp_motor_params_kv_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_kv.enabled],
                    "value": Number(cp_motor_params_kv.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_kv_load": {
                    "caption": cp_motor_params_kv_load_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_kv_load.enabled],
                    "value": Number(cp_motor_params_kv_load.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_pp": {
                    "caption": cp_motor_params_pp_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_pp.enabled],
                    "value": Number(cp_motor_params_pp.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_max_rpm": {
                    "caption": cp_motor_params_max_rpm_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_max_rpm.enabled],
                    "value": Number(cp_motor_params_max_rpm.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_rated_rpm": {
                    "caption": cp_motor_params_rated_rpm_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_rated_rpm.enabled],
                    "value": Number(cp_motor_params_rated_rpm.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_min_rpm": {
                    "caption": cp_motor_params_min_rpm_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_min_rpm.enabled],
                    "value": Number(cp_motor_params_min_rpm.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_ke": {
                    "caption": cp_motor_params_ke_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_ke.enabled],
                    "value": Number(cp_motor_params_ke.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_rated_v": {
                    "caption": cp_motor_params_rated_v_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_rated_v.enabled],
                    "value": Number(cp_motor_params_rated_v.text),
                    "values": [],
                    "unit": ""
                },
                "cp_motor_params_hall_pol": {
                    "caption": cp_motor_params_hall_pol_caption.text,
                    "scales": [],
                    "states": [cp_motor_params_hall_pol.enabled],
                    "value": cp_motor_params_hall_pol.checked,
                    "values": [],
                    "unit": ""
                },
                // Speed Loop Parameters
                "cp_spd_loop_params_mode": {
                    "caption": cp_spd_loop_params_mode_caption.text,
                    "scales": [],
                    "states": [cp_spd_loop_params_mode.enabled],
                    "value": cp_spd_loop_params_mode.currentIndex,
                    "values": cp_spd_loop_params_mode.model,
                    "unit": ""
                },
                "cp_spd_loop_params_accel": {
                    "caption": cp_spd_loop_params_accel_caption.text,
                    "scales": [],
                    "states": [cp_spd_loop_params_accel.enabled],
                    "value": Number(cp_spd_loop_params_accel.text),
                    "values": [],
                    "unit": ""
                },
                "cp_spd_loop_params_fs": {
                    "caption": cp_spd_loop_params_fs_caption.text,
                    "scales": [],
                    "states": [cp_spd_loop_params_fs.enabled],
                    "value": Number(cp_spd_loop_params_fs.text),
                    "values": [],
                    "unit": ""
                },
                "cp_spd_loop_params_fspd_filt": {
                    "caption": cp_spd_loop_params_fspd_filt_caption.text,
                    "scales": [],
                    "states": [cp_spd_loop_params_fspd_filt.enabled],
                    "value": Number(cp_spd_loop_params_fspd_filt.text),
                    "values": [],
                    "unit": ""
                },
                // Protection Parameters
                "cp_protection_ocp": {
                    "caption": cp_protection_ocp_caption.text,
                    "scales": [],
                    "states": [cp_protection_ocp.enabled],
                    "value": Number(cp_protection_ocp.text),
                    "values": [],
                    "unit": ""
                },
                "cp_protection_ocp_en": {
                    "caption": cp_protection_ocp_en_caption.text,
                    "scales": [],
                    "states": [cp_protection_ocp_en.enabled],
                    "value": cp_protection_ocp_en.checked,
                    "values": [],
                    "unit": ""
                },
                "cp_protection_ovp": {
                    "caption": cp_protection_ovp_caption.text,
                    "scales": [],
                    "states": [cp_protection_ovp.enabled],
                    "value": Number(cp_protection_ovp.text),
                    "values": [],
                    "unit": ""
                },
                "cp_protection_ovp_en": {
                    "caption": cp_protection_ovp_en_caption.text,
                    "scales": [],
                    "states": [cp_protection_ovp_en.enabled],
                    "value": cp_protection_ovp_en.checked,
                    "values": [],
                    "unit": ""
                }
            },
            cp_save_button.subdirName
        );
    }

    LayoutText { // start_36f96
        id: layoutText_36f96
        layoutInfo.uuid: "36f96"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 40

        text: "Save and Load Parameters"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_36f96

    LayoutDivider { // start_65192
        id: layoutDivider_65192
        layoutInfo.uuid: "65192"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 41
        thickness: 2
    } // end_65192

    LayoutSGInfoBox { // start_708bd
        id: cp_save_filename
        layoutInfo.uuid: "708bd"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 43

        placeholderText: "Enter parameter name"
        horizontalAlignment: Text.AlignLeft
        readOnly: false
    } // end_708bd

    LayoutButton { // start_912e7
        id: cp_save_button
        layoutInfo.uuid: "912e7"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 43

        property string subdirName: "mv-mdk"
        text: "Save"

        onClicked: {
            const valid_filename_regex = new RegExp(/^[^\\\/\:\*\?\"\<\>\|\.]+$/); // Validate filename
            if (valid_filename_regex.test(cp_save_filename.text)) {
                // Valid filename if not empty
                if (cp_save_filename.text.length > 0) {
                    saveSettings(cp_save_filename.text)
                    cp_load_filename.updateList()
                    cp_save_filename.placeholderText = "Enter parameter name"
                } else {
                    cp_save_filename.placeholderText = "Invalid filename"
                }
            } else {
                // Invalid filename
                cp_save_filename.placeholderText = "Invalid filename"
            }
            cp_save_filename.text = ""

            
        }
    } // end_912e7

    LayoutSGComboBox { // start_93f08
        id: cp_load_filename
        layoutInfo.uuid: "93f08"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 46

        // placeholderText: "Select Configuration" // TODO: why does this not work with LayoutSGComboBox but fine with SGComboBox
        dividers: true
        model: filesInDir.length > 0 ? filesInDir.map((file) => getFileNameFromFile(file)) : [];

        // This variable stores a list of paths for each file found in the base output directory for the current platform
        property var filesInDir: sgUserSettings.listFilesInDirectory(cp_save_button.subdirName);

        function getFileNameFromFile(file) {
            return file.slice(0, file.lastIndexOf('.'));
        }

        function updateList() {
            filesInDir = sgUserSettings.listFilesInDirectory(cp_save_button.subdirName);
            model = filesInDir.map((file) => getFileNameFromFile(file));
        }
    } // end_93f08

    LayoutButton { // start_e96bf
        id: cp_delete_button
        layoutInfo.uuid: "e96bf"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 47

        text: "Delete"

        onClicked: {
            sgUserSettings.deleteFile(cp_load_filename.currentText + '.json', cp_save_button.subdirName);
            cp_load_filename.updateList()
        }

    } // end_e96bf

    LayoutButton { // start_053a0
        id: cp_load_button
        layoutInfo.uuid: "053a0"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 27
        layoutInfo.yRows: 45

        text: "Load"

        onClicked: {
            if (cp_load_filename.currentIndex >= 0) {
                loadSettings(cp_load_filename.currentText + ".json")
            }
        }

    } // end_053a0


    // ======================== Help Message Helper Rectangles ======================== //

    // ------------------------ PWM Settings ------------------------ //

    LayoutRectangle { // start_972fd
        id: cp_pwm_params_o_mode_help
        layoutInfo.uuid: "972fd"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 9
        opacity: 0
    } // end_972fd

    LayoutRectangle { // start_c909f
        id: cp_pwm_params_dt_help
        layoutInfo.uuid: "c909f"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 4
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 12
        opacity: 0
    } // end_c909f

        LayoutRectangle { // start_57609
        id: cp_pwm_params_min_ls_help
        layoutInfo.uuid: "57609"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 4
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 17
        opacity: 0
    } // end_57609

    LayoutRectangle { // start_af100
        id: cp_pwm_params_freq_help
        layoutInfo.uuid: "af100"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 4
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 22
        opacity: 0
    } // end_af100

    LayoutRectangle { // start_29459
        id: cp_pwm_params_tr_delay_help
        layoutInfo.uuid: "29459"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 27
        opacity: 0
    } // end_29459

    // ------------------------ PID Control Parameters------------------------ //

    LayoutRectangle { // start_a2689
        id: cp_pid_params_kx_help
        layoutInfo.uuid: "a2689"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 33
        opacity: 0
    } // end_a2689

    LayoutRectangle { // start_a9c70
        id: cp_pid_params_wd_help
        layoutInfo.uuid: "a9c70"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 36
        opacity: 0
    } // end_a9c70

    LayoutRectangle { // start_72aab
        id: cp_pid_params_lim_help
        layoutInfo.uuid: "72aab"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 39
        opacity: 0
    } // end_72aab

    LayoutRectangle { // start_3e0c1
        id: cp_pid_params_tau_sys_help
        layoutInfo.uuid: "3e0c1"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 42
        opacity: 0
    } // end_3e0c1

    LayoutRectangle { // start_be538
        id: cp_pid_params_mode_help
        layoutInfo.uuid: "be538"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 45
        opacity: 0
    } // end_be538
        
    // ------------------------ Motor and Load Parameters ------------------------ //

    LayoutRectangle { // start_7b801
        id: cp_motor_params_xs_help
        layoutInfo.uuid: "7b801"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 5
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 9
        opacity: 0
    } // end_7b801

    LayoutRectangle { // start_32708
        id: cp_motor_params_jm_kv_help
        layoutInfo.uuid: "32708"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 11
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 15
        opacity: 0
    } // end_32708

    LayoutRectangle { // start_6f32d
        id: cp_motor_params_pp_help
        layoutInfo.uuid: "6f32d"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 27
        opacity: 0
    } // end_6f32d

    LayoutRectangle { // start_cc648
        id: cp_motor_params_rpm_help
        layoutInfo.uuid: "cc648"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 8
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 30
        opacity: 0
    } // end_cc648

    LayoutRectangle { // start_fada4
        id: cp_motor_params_ke_help
        layoutInfo.uuid: "fada4"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 39
        opacity: 0
    } // end_fada4

    LayoutRectangle { // start_1fd07
        id: cp_motor_params_rated_v_help
        layoutInfo.uuid: "1fd07"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 42
        opacity: 0
    } // end_1fd07

    LayoutRectangle { // start_e789f
        id: cp_motor_params_hall_pol_help
        layoutInfo.uuid: "e789f"
        layoutInfo.columnsWide: 10
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 10
        layoutInfo.yRows: 45
        opacity: 0
    } // end_e789f

    // ------------------------ Speed Loop Parameters ------------------------ //

    // 
    // 
    // 
    // 

    LayoutRectangle { // start_c1c77
        id: cp_spd_loop_params_mode_help
        layoutInfo.uuid: "c1c77"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 9
        opacity: 0
    } // end_c1c77

    LayoutRectangle { // start_c8d50
        id: cp_spd_loop_params_accel_help
        layoutInfo.uuid: "c8d50"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 13
        opacity: 0
    } // end_c8d50

    LayoutRectangle { // start_7b50c
        id: cp_spd_loop_params_fs_help
        layoutInfo.uuid: "7b50c"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 16
        opacity: 0
    } // end_7b50c

    LayoutRectangle { // start_4fc8b
        id: cp_spd_loop_params_fspd_filt_help
        layoutInfo.uuid: "4fc8b"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 19
        opacity: 0
    } // end_4fc8b

    
    // ------------------------ Protection Parameters ------------------------ //

    LayoutRectangle { // start_2e709
        id: cp_protection_ocp_help
        layoutInfo.uuid: "2e709"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 5
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 25
        opacity: 0
    } // end_2e709

    LayoutRectangle { // start_ee62d
        id: cp_protection_ovp_help
        layoutInfo.uuid: "ee62d"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 5
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 31
        opacity: 0
    } // end_ee62d

    LayoutRectangle { // start_55f56
        id: cp_protection_fet_otp_help
        layoutInfo.uuid: "55f56"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 37
        opacity: 0
    } // end_55f56

    // ------------------------ Save and Load Parameters ------------------------ //

    LayoutRectangle { // start_cf371
        id: cp_save_load_parameters_help
        layoutInfo.uuid: "cf371"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 8
        layoutInfo.xColumns: 21
        layoutInfo.yRows: 40
        opacity: 0
    } // end_cf371

} // end_uibase
