import QtQuick 2.12
import QtQml 2.12

import "qrc:/js/help_layout_manager.js" as Help
import tech.strata.sgwidgets 1.0
import tech.strata.sglayout 1.0
import tech.strata.commoncpp 1.0
import QtTest 1.1

UIBase { // start_uibase
    
    // ======================== General Settings ======================== //

    columnCount: 30
    rowCount: 50

    // ======================== Aliases ======================== //

    // ======================== UI Initialization ======================== //
    
    Component.onCompleted: {

        // ------------------------ Help Messages ------------------------ //

        // // Section 1
        // Help.registerTarget(cp_pwm_params_o_mode_help, "PWM output set to either bipolar or unipolar.", 0, "AdvancedControlHelp")
        // Help.registerTarget(cp_pwm_params_dt_help, "PWM deadtime received by the MOSFET gate driver. This may need to be adjusted based on the MOSFET selection to avoid cross conduction.\n\nThis slider and all subsequent sliders can be finely adjusted using the keyboard's left/right arrow keys when in focus.", 1, "AdvancedControlHelp")
        // Help.registerTarget(cp_pwm_params_min_ls_help, "Minimum allowed low side MOSFET on time.", 2, "AdvancedControlHelp")
        // Help.registerTarget(cp_pwm_params_freq_help, "PWM switching frequency received by the gate driver.", 3, "AdvancedControlHelp")
        // Help.registerTarget(cp_pwm_params_tr_delay_help, "Clock cycles to delay ADC sampling from midpoint of PWM on time.", 4, "AdvancedControlHelp")
        // // Section 2
        // Help.registerTarget(cp_pid_params_kx_help, "PID gain controls for proportional (Kp), integral (Ki), and derivative (Kd) gains. Set derivative gain to zero for PI control only.", 5, "AdvancedControlHelp")
        // Help.registerTarget(cp_pid_params_wd_help, "Derivative term low-pass filter cutoff frequency.", 6, "AdvancedControlHelp")
        // Help.registerTarget(cp_pid_params_lim_help, "Integral error term limit. Normally set to DC bus voltage. The voltage will be automatically adjusted based on the voltage variant connected but can be overridden by the user.", 7, "AdvancedControlHelp")
        // Help.registerTarget(cp_pid_params_tau_sys_help, "System time constant for auto IMC-calculated PID gain.", 8, "AdvancedControlHelp")
        // Help.registerTarget(cp_pid_params_mode_help, "PID control gain mode. Auto = calculated from motor parameters. Manual = manual settings above used.", 9, "AdvancedControlHelp")

        // -------------- Other Startup Tasks -------------- //
        // Such as synchronizing the UI and firmware
    
    }    

    // ======================== UI Objects ======================== //

    // -------- Title and Subtitle -------- //

    LayoutText { // start_8695e
        id: a_title
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
        id: a_subtitle
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

    // -------- Section Header and Divider -------- //

    LayoutText { // start_99acd
        id: layoutText_99acd
        layoutInfo.uuid: "99acd"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 6

        text: "Section Name"
        fontSizeMode: Text.Fit
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
        color: "#000000"
    } // end_99acd

    LayoutDivider { // start_578da
        id: divider_578da
        layoutInfo.uuid: "578da"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 7
        thickness: 2
    } // end_578da

    // -------- Switch -------- //

    LayoutSGSwitch { // start_d68f2
        id: a_switch
        layoutInfo.uuid: "d68f2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 9
 
        checkedLabel: "True"
        uncheckedLabel: "False"
        labelsInside: true

        checked: false

        onToggled: {
            console.log("Switch toggled:", checked)
            // platformInterface.commands.pwm_params.update(Number())Number())
        }
        
    } // end_d68f2

    LayoutText { // start_65728
        id: a_switch_caption
        layoutInfo.uuid: "65728"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 9

        text: "Switch"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_65728

    LayoutItem { // start_8991c
        id: a_switch_help
        layoutInfo.uuid: "8991c"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 9
    } // end_8991c

    // -------- Slider -------- //

    LayoutSGSlider { // start_b8761
        id: a_slider
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
            console.log("Slider value set:", value)
            // platformInterface.commands.pwm_params.update(Number())
        }
    } // end_b8761

    LayoutText { // start_01fc5
        id: a_slider_caption
        layoutInfo.uuid: "01fc5"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 12

        text: "Slider"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_01fc5

    LayoutItem { // start_1e325
        id: a_slider_help
        layoutInfo.uuid: "1e325"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 4
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 12
    } // end_1e325

    // -------- InfoBox Integer -------- //

    LayoutSGInfoBox { // start_61e5b
        id: a_infobox_integer
        layoutInfo.uuid: "61e5b"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 17

        text: "0"
        readOnly: false

        validator: IntValidator {
            bottom: 0
        }

        onEditingFinished : {
            console.log("InfoBox edit finished:", text)
            // platformInterface.commands.pwm_params.update(Number())
        }

    } // end_61e5b

    LayoutText { // start_bf582
        id: a_infobox_integer_caption
        layoutInfo.uuid: "bf582"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 17

        text: "InfoBox Integer"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter

    } // end_bf582

    LayoutItem { // start_a9997
        id: a_infobox_integer_help
        layoutInfo.uuid: "a9997"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 17
    } // end_a9997

    // -------- InfoBox Double -------- //

    LayoutSGInfoBox { // start_4d8a5
        id: a_infobox_double
        layoutInfo.uuid: "4d8a5"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 20

        text: "0"
        readOnly: false

        validator: IntValidator {
            bottom: 0
        }

        onEditingFinished : {
            console.log("InfoBox edit finished:", text)
            // platformInterface.commands.pwm_params.update(Number())
        }

    } // end_4d8a5

    LayoutText { // start_4d476
        id: a_infobox_double_caption
        layoutInfo.uuid: "4d476"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 20

        text: "InfoBox Double"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter

    } // end_4d476

    LayoutItem { // start_48507
        id: a_infobox_double_help
        layoutInfo.uuid: "48507"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 20
    } // end_48507

    // -------- InfoBox String -------- //

    LayoutSGInfoBox { // start_124d2
        id: a_infobox_string
        layoutInfo.uuid: "124d2"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 23

        text: "0"
        readOnly: false

        validator: IntValidator {
            bottom: 0
        }

        onEditingFinished : {
            console.log("InfoBox edit finished:", text)
            // platformInterface.commands.pwm_params.update(Number())
        }

    } // end_124d2

    LayoutText { // start_72d28
        id: a_infobox_string_caption
        layoutInfo.uuid: "72d28"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 23

        text: "InfoBox String"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter

    } // end_72d28

    LayoutItem { // start_002e6
        id: a_infobox_string_help
        layoutInfo.uuid: "002e6"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 23
    } // end_002e6

    // -------- ComboBox -------- //

    LayoutSGComboBox { // start_f5402
        id: a_combobox
        layoutInfo.uuid: "f5402"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 27

        model: ["Item 1", "Item 2", "Item 3"]
        currentIndex: 1
        
        onActivated: {
            console.log("ComboBox activated:", currentIndex, currentText)
            // platformInterface.commands.pwm_params.update(Number())
        }        
    } // end_f5402

    LayoutText { // start_b10f9
        id: a_combobox_caption
        layoutInfo.uuid: "b10f9"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 26

        text: "ComboBox"
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    } // end_b10f9

    LayoutItem { // start_26a27
        id: a_combobox_help
        layoutInfo.uuid: "26a27"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 3
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 26
    } // end_26a27

    // ======================== Save and Load Parameters ======================== //

    function loadSettings(config) {
        // PWM Parameters
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
        }
        if (config.hasOwnProperty('cp_pwm_params_tr_delay')) {
            cp_pwm_params_tr_delay_caption.text = config.cp_pwm_params_tr_delay.caption
            cp_pwm_params_tr_delay.enabled = config.cp_pwm_params_tr_delay.states[0]
            cp_pwm_params_tr_delay.text = config.cp_pwm_params_tr_delay.value
        }
        if (config.hasOwnProperty('cp_spd_loop_params_mode')) {
            cp_spd_loop_params_mode_caption.text = config.cp_spd_loop_params_mode.caption
            cp_spd_loop_params_mode.enabled = config.cp_spd_loop_params_mode.states[0]
            cp_spd_loop_params_mode.currentIndex = config.cp_spd_loop_params_mode.value
            cp_spd_loop_params_mode.model = config.cp_spd_loop_params_mode.values
        }
        // TODO: probably send cmd in each if statement
        // send_params()
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
                "cp_pwm_params_tr_delay": {
                    "caption": cp_pwm_params_tr_delay_caption.text,
                    "scales": [],
                    "states": [cp_pwm_params_tr_delay.enabled],
                    "value": Number(cp_pwm_params_tr_delay.text),
                    "values": [],
                    "unit": ""
                },
                "cp_spd_loop_params_mode": {
                    "caption": cp_spd_loop_params_mode_caption.text,
                    "scales": [],
                    "states": [cp_spd_loop_params_mode.enabled],
                    "value": cp_spd_loop_params_mode.currentIndex,
                    "values": cp_spd_loop_params_mode.model,
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
        layoutInfo.xColumns: 1
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
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 41
        thickness: 2
    } // end_65192

    LayoutSGInfoBox { // start_708bd
        id: cp_save_filename
        layoutInfo.uuid: "708bd"
        layoutInfo.columnsWide: 5
        layoutInfo.rowsTall: 2
        layoutInfo.xColumns: 1
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
        layoutInfo.xColumns: 7
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
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 46

        placeholderText: "Select Configuration"
        dividers: true
        textRole: "filename"
        model: ListModel {
            id: settingsModel            
            ListElement {
                filename: "Universal Configuration"
                default_setting: true
                location: ":/settings/Universal Configuration.json"
            }
            ListElement {
                filename: "Volcano Motor VOL-BL06C12"
                default_setting: true
                location: ":/settings/Volcano Motor VOL-BL06C12.json"
            }
            ListElement {
                filename: "ATO D110BLD1000-24A-30S"
                default_setting: true
                location: ":/settings/ATO D110BLD1000-24A-30S.json"
            }
            ListElement {
                filename: "ATO 110WD-M04030-48V"
                default_setting: true
                location: ":/settings/ATO 110WD-M04030-48V.json"
            }
            ListElement {
                filename: "ATO 110WD-M04030-96V"
                default_setting: true
                location: ":/settings/ATO 110WD-M04030-96V.json"
            }
            Component.onCompleted: {
                cp_load_filename.updateList()
            }
        }

        function getFileNameFromFile(file) {
            return file.slice(0, file.lastIndexOf('.'));
        }

        function updateList() {
            let filesInDir = sgUserSettings.listFilesInDirectory(cp_save_button.subdirName);
            for (let i = settingsModel.count - 1; i > -1; i--) {
                // remove all non-default settings
                if (settingsModel.get(i).default_setting === false) {
                    settingsModel.remove(i)
                }
            }

            for (let file of filesInDir) {
                settingsModel.append({
                    filename: getFileNameFromFile(file),
                    default_setting: false,
                    location: ""
                })
            }
        }
    } // end_93f08

    LayoutButton { // start_e96bf
        id: cp_delete_button
        layoutInfo.uuid: "e96bf"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 47

        text: "Delete"

        onClicked: {
            if (cp_load_filename.currentIndex >= 0) {
                let current_file = cp_load_filename.model.get(cp_load_filename.currentIndex)
                if (current_file.default_setting === false) {
                    sgUserSettings.deleteFile(current_file.filename + '.json', cp_save_button.subdirName);
                    cp_load_filename.updateList()
                } else {
                    console.log("can't delete default settings")
                }
            }
        }

    } // end_e96bf

    LayoutButton { // start_053a0
        id: cp_load_button
        layoutInfo.uuid: "053a0"
        layoutInfo.columnsWide: 2
        layoutInfo.rowsTall: 1
        layoutInfo.xColumns: 7
        layoutInfo.yRows: 45

        text: "Load"

        onClicked: {
            if (cp_load_filename.currentIndex >= 0) {
                let current_file = cp_load_filename.model.get(cp_load_filename.currentIndex)
                let config
                if (current_file.default_setting) {
                    config = SGUtilsCpp.readTextFileContent(current_file.location)
                    config = JSON.parse(config)
                } else {
                    config = sgUserSettings.readFile(current_file.filename + ".json", cp_save_button.subdirName)
                }
                loadSettings(config)
            }
        }
    } // end_053a0

    // ======================== Help Message Helper Rectangles ======================== //

    // ------------------------ PWM Settings ------------------------ //

    // ------------------------ PID Control Parameters------------------------ //

        
    // ------------------------ Motor and Load Parameters ------------------------ //

    // ------------------------ Speed Loop Parameters ------------------------ //

    
    // ------------------------ Protection Parameters ------------------------ //

    // ------------------------ Save and Load Parameters ------------------------ //

    LayoutRectangle { // start_cf371
        id: cp_save_load_parameters_help
        layoutInfo.uuid: "cf371"
        layoutInfo.columnsWide: 8
        layoutInfo.rowsTall: 8
        layoutInfo.xColumns: 1
        layoutInfo.yRows: 40
        opacity: 0
    } // end_cf371

} // end_uibase
