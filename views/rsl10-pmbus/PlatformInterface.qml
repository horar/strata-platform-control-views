/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12

import "qrc:/js/core_platform_interface.js" as CorePlatformInterface

Item {
    id: platformInterface

    /*
    * Output enabled state
    */
    property bool output_enabled: false

    /*
    * PWM state
    */
    property bool pwm_enabled:  false           /* PWM enable/disable */
    property int frequency:     0               /* PWM frequency in Hz */
    property int duty:          0               /* PWM duty cycle in % */

    /*
    * Telemetry values
    */
    property double vin:   0                    /* Input Voltage in Volts */
    property double iin:   0                    /* Input Current in Amperes */
    property double vout:  0                    /* Output Voltage in Volts */
    property double iout:  0                    /* Output Current in Amperes */
    property double btemp: 0                    /* Board Temperature in °C */
    property double ctemp: 0                    /* Chip Temperature in °C */

    /*
    * Status values
    */
    property bool off:              false       /* Output OFF for any reason*/
    property bool pgood:            false       /* Power Good (negated) */
    property int temp_status:       0           /* Over-temperature Warning/Fault */
    property int vout_ov_status:    0           /* VOUT Over-voltage Warning/Fault */
    property int vout_uv_status:    0           /* VOUT Under-voltage Warning/Fault */
    property int iout_oc_status:    0           /* IOUT Over-current Warning/Fault */
    property int vin_uv_status:     0           /* VIN Under-voltage Warning/Fault */
    property bool vin_low:          false       /* OFF due low VIN voltage */
    property bool cml:              false       /* Communication, Memory, Logic Fault */
    property bool vout_sthr:        false       /* VOUT higher than threshold on startup */
    property bool vinss_sthr:       false       /* VINSS higher than threshold on startup */
    property bool dcx_s:            false       /* DCX VOUT UVLO on startup */
    property bool ana_oc:           false       /* Analog OC Protection */
    property bool buck_duty:        false       /* Buck Duty Fault */
    property bool dig_ratio:        false       /* Digital Ratio Protection */
    property bool ana_ratio:        false       /* Analog Ratio Protection */

    /*
    * Fault config
    */
    property int temp_fault:        0
    property int temp_warn:         0
    property int vout_ov_fault:     0
    property int vout_ov_warn:      0
    property int vout_uv_fault:     0
    property int vout_uv_warn:      0
    property int iout_oc_fault:     0
    property int iout_oc_warn:      0

    property string vout_ov_response: ""
    property string vout_uv_response: ""
    property string iout_oc_response: ""


    /*
    * Read output state
    */
    onGet_outputChanged: {
        output_enabled = get_output.enabled
    }

    /*
    * Read telemetry
    */
    onGet_telemetryChanged: {
        vin = get_telemetry.vin
        iin = get_telemetry.iin
        vout = get_telemetry.vout
        iout = get_telemetry.iout
        btemp = get_telemetry.btemp
        ctemp = get_telemetry.ctemp
    }

    /*
    * Read status
    */
    onGet_statusChanged: {

        off =               false
        pgood =             false
        temp_status =       0
        vout_ov_status =    0
        vout_uv_status =    0
        iout_oc_status =    0
        vin_uv_status =     0
        vin_low =           false
        cml =               false
        vout_sthr =         false
        vinss_sthr =        false
        dcx_s =             false
        ana_oc =            false
        buck_duty =         false
        dig_ratio =         false
        ana_ratio =         false

        for (var i = 0; i < get_status.flags.length; i++)
        {
            var status = get_status.flags[i]

            switch (status)
            {
            case "off":
                off = true
                break
            case "/pgood":
                pgood = true
                break
            case "temp_w":
                temp_status = 1
                break
            case "temp_f":
                temp_status = 2
                break
            case "vout_ovf":
                vout_ov_status = 2
                break
            case "vout_ovw":
                vout_ov_status = 1
                break
            case "vout_uvw":
                vout_uv_status = 1
                break
            case "vout_uvf":
                vout_uv_status = 2
                break
            case "iout_ocw":
                iout_oc_status = 1
                break
            case "iout_ocf":
                iout_oc_status = 2
                break
            case "vout_ovf":
                vout_ov_status = 2
                break
            case "vout_ovw":
                vout_ov_status = 1
                break
            case "vin_uvf":
                vin_uv_status = 2
                break
            case "vin_uvw":
                vin_uv_status = 1
                break
            case "vin_low":
                vin_low = true
                break
            case "cml":
                cml = true
                break
            case "vout_sthr":
                vout_sthr = true
                break
            case "vinss_sthr":
                vinss_sthr = true
                break
            case "dcx_s":
                dcx_s = true
                break
            case "ana_oc":
                ana_oc = true
                break
            case "buck_duty":
                buck_duty = true
                break
            case "dig_ratio":
                dig_ratio = true
                break
            case "ana_ratio":
                ana_ratio = true
                break
            }
        }
    }

    /*
    * Read output state
    */
    onGet_pwmChanged:
    {
        pwm_enabled = get_pwm.enable
        frequency = get_pwm.frequency
        duty = get_pwm.duty
    }

    /*
    * Read output state
    */
    onGet_fault_configChanged:
    {
        temp_warn = get_fault_config.temperature.over_temperature.warning
        temp_fault = get_fault_config.temperature.over_temperature.fault

        vout_ov_warn = get_fault_config.vout.over_voltage.warning
        vout_ov_fault = get_fault_config.vout.over_voltage.fault
        vout_ov_response = get_fault_config.vout.over_voltage.response

        vout_uv_warn = get_fault_config.vout.under_voltage.warning
        vout_uv_fault = get_fault_config.vout.under_voltage.fault
        vout_uv_response = get_fault_config.vout.under_voltage.response

        iout_oc_warn = get_fault_config.iout.over_current.warning
        iout_oc_fault = get_fault_config.iout.over_current.fault
        iout_oc_response = get_fault_config.iout.over_current.response
    }

    onPwm_enabledChanged:
    {
        set_pwm1.update(pwm_enabled, frequency, duty)
        if (pwm_enabled === true)
        {
            sideBarLeft.pwm_enabled_side = true
        }
        else
        {
            sideBarLeft.pwm_enabled_side = false
        }
    }

    onFrequencyChanged: {
        set_pwm1.update(pwm_enabled, frequency, duty)
    }

    onDutyChanged: {
        set_pwm1.update(pwm_enabled, frequency, duty)
    }

    // -------------------------------------------------------------------------------------------
    // Commands
    // TO SEND A COMMAND DO THE FOLLOWING:
    // EXAMPLE: To send the motor speed: platformInterface.set_enable.update("on")

    // TO SYNCHRONIZE THE SPEED ON ALL THE VIEW DO THE FOLLOWING:
    // EXAMPLE: platformInterface.enabled

    // @command set_output
    // @property enable: bool
    property var set_output1: ({
                              "cmd" : "set_output",
                              "payload": {
                                  "enable": false
                              },

                              // Update will set and send in one shot
                              update: function (enable) {
                                  this.set(enable)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (enable) {
                                  this.payload.enable = enable
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })

    // @command get_output
    property var get_output: ({ "cmd" : "get_output",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // @command get_telemetry
    property var get_telemetry: ({ "cmd" : "get_telemetry",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // @command get_status
    property var get_status: ({ "cmd" : "get_status",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })


    // @command set_pwm
    // @property enable: bool
    // @property frequency: int
    // @property duty: int
    property var set_pwm1: ({
                              "cmd" : "set_pwm",
                              "payload": {
                                  "enable": false,
                                  "frequency": 0,
                                  "duty": 0
                              },

                              // Update will set and send in one shot
                              update: function (enable, frequency, duty) {
                                  this.set(enable, frequency, duty)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (enable, frequency, duty) {
                                  this.payload.enable = enable
                                  this.payload.frequency = frequency
                                  this.payload.duty = duty
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })

    // @command get_pwm
    property var get_pwm: ({ "cmd" : "get_pwm",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // @command get_fault_config
    property var get_fault_config: ({ "cmd" : "get_fault_config",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // @command set_fault_config_temp
    property var set_fault_config_temp: ({
                              "cmd" : "set_fault_config",
                              "payload": {
                                    "temperature": {
                                        "over_temperature": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                              },

                              // Update will set and send in one shot
                              update: function (warning,fault) {
                                  this.set(warning, fault)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (warning, fault) {
                                  this.payload.temperature.over_temperature.warning = warning
                                  this.payload.temperature.over_temperature.fault = fault
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })


    // @command set_fault_config_ov
    // @property warning: int
    // @property fault: int
    // @property reponse: string
    property var set_fault_config_ov: ({
                              "cmd" : "set_fault_config",
                              "payload": {
                                    "vout": {
                                        "over_voltage": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                              },

                              // Update will set and send in one shot
                              update: function (warning,fault,response) {
                                  this.set(warning, fault, response)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (warning, fault, response) {
                                  this.payload.vout.over_voltage.warning = warning
                                  this.payload.vout.over_voltage.fault = fault
                                  this.payload.vout.over_voltage.response = response
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })

    // @command set_fault_config_uv
    // @property warning: int
    // @property fault: int
    // @property reponse: string
    property var set_fault_config_uv: ({
                              "cmd" : "set_fault_config",
                              "payload": {
                                    "vout": {
                                        "under_voltage": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                              },

                              // Update will set and send in one shot
                              update: function (warning,fault,response) {
                                  this.set(warning, fault, response)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (warning, fault, response) {
                                  this.payload.vout.under_voltage.warning = warning
                                  this.payload.vout.under_voltage.fault = fault
                                  this.payload.vout.under_voltage.response = response
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })

    // @command set_fault_config_oc
    // @property warning: int
    // @property fault: int
    // @property reponse: string
    property var set_fault_config_oc: ({
                              "cmd" : "set_fault_config",
                              "payload": {
                                    "iout": {
                                        "over_current": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                              },

                              // Update will set and send in one shot
                              update: function (warning,fault,response) {
                                  this.set(warning, fault, response)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (warning, fault, response) {
                                  this.payload.iout.over_current.warning = warning
                                  this.payload.iout.over_current.fault = fault
                                  this.payload.iout.over_current.response = response
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })

    // @command set_fault_config
    // @property warning: int
    // @property fault: int
    // @property reponse: string
    property var set_fault_config_all: ({
                              "cmd" : "set_fault_config",
                              "payload": {
                                    "temperature": {
                                        "over_temperature": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                                    "vout": {
                                        "under_voltage": {
                                            "warning": 0,
                                            "fault": 0
                                        },
                                        "over_voltage": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                                    "iout": {
                                        "over_current": {
                                            "warning": 0,
                                            "fault": 0
                                        }
                                    },
                              },

                              // Update will set and send in one shot
                              update: function (temp_warning, temp_fault,
                                                vout_ov_warn, vout_ov_fault, vout_ov_response,
                                                vout_uv_warn, vout_uv_fault, vout_uv_response,
                                                iout_oc_warn, iout_oc_fault, iout_oc_response)
                              {
                                  this.set(temp_warning, temp_fault,
                                           vout_ov_warn, vout_ov_fault, vout_ov_response,
                                           vout_uv_warn, vout_uv_fault, vout_uv_response,
                                           iout_oc_warn, iout_oc_fault, iout_oc_response)
                                  this.send(this)
                              },
                              // Set can set single or multiple properties before sending to platform
                              set: function (temp_warning, temp_fault,
                                             vout_ov_warn, vout_ov_fault, vout_ov_response,
                                             vout_uv_warn, vout_uv_fault, vout_uv_response,
                                             iout_oc_warn, iout_oc_fault, iout_oc_response)
                              {

                                  this.payload.temperature.over_temperature.warning = temp_warning
                                  this.payload.temperature.over_temperature.fault = temp_fault

                                  this.payload.vout.over_voltage.warning = vout_ov_warn
                                  this.payload.vout.over_voltage.fault = vout_ov_fault
                                  this.payload.vout.over_voltage.response = vout_ov_response

                                  this.payload.vout.under_voltage.warning = vout_uv_warn
                                  this.payload.vout.under_voltage.fault = vout_uv_fault
                                  this.payload.vout.under_voltage.response = vout_uv_response

                                  this.payload.iout.over_current.warning = iout_oc_warn
                                  this.payload.iout.over_current.fault = iout_oc_fault
                                  this.payload.iout.over_current.response = iout_oc_response
                              },
                              send: function () { CorePlatformInterface.send(this) }
                          })

    // @command write_config_to_otp
    property var write_config_to_otp: ({ "cmd" : "write_config_to_otp",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // @command clear_faults
    property var clear_faults: ({ "cmd" : "clear_faults",

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })
       // -------------------------------------------------------------------------------------------
    // Periodic commands


    // @command start_periodic get_telemetry
    property var start_periodic_telemetry: ({   "cmd": "start_periodic",
                                                "payload": {
                                                    "function": "get_telemetry"
                                            },

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // @command start_periodic get_telemetry
    property var start_periodic_status: ({   "cmd": "start_periodic",
                                                "payload": {
                                                    "function": "get_status"
                                            },

                                   update: function () {
                                       this.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })

    // -------------------------------------------------------------------------------------------
    // Notification Messages
    //
    // define and document incoming notification messages
    //  the properties of the message must match with the UI elements using them
    //  document all messages to clearly indicate to the UI layer proper names

    // @notification read_voltage_current
    // @description: read values
    //

    property bool enabled: false
    property bool power_mode: false
    property bool advertise
    property int voutOVFaultResponse_state
    property int voutUVFaultResponse_state
    property int ioutOCFaultResponse_state

    property var status_voltage_current : {
        "vin": 0,		// in mVolts
        "vout": 0,      // in mVolts
        "iin":	0,    	// in mAmps
        "iout": 0,     	// in mAmps
    }

    property var status_predefined_values : {
        "OT_fault": 0,		// in degrees Celsius
        "OT_warning": 0,     // in degrees Celsius
        "OV_fault": 0,		// in Volts
        "OV_warning": 0,     // in Volts
        "UV_fault": 0,		// in Volts
        "UV_warning": 0,     // in Volts
        "OC_fault": 0,		// in Amps
        "OC_warning": 0,     // in Amps
    }

    property var status_word : {
        "b3": 0,		// 0 -> NO Alarm, 1 -> Alarm
        "b5": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b6": 0,    	// 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_vout : {
        "b3": 0,		// 0 -> NO Alarm, 1 -> Alarm
        "b4": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_iout : {
        "b5": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_input : {
        "b3": 0,		// 0 -> NO Alarm, 1 -> Alarm
        "b4": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b5": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_temperature : {
        "b6": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_cml : {
        "b5": 0,		// 0 -> NO Alarm, 1 -> Alarm
        "b6": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_mfr_specific1 : {
        "b0": 0,		// 0 -> NO Alarm, 1 -> Alarm
        "b1": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b2": 0,     	// 0 -> NO Alarm, 1 -> Alarm
        "b3": 0,		// 0 -> NO Alarm, 1 -> Alarm
        "b4": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b5": 0,     	// 0 -> NO Alarm, 1 -> Alarm
        "b6": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_mfr_specific2 : {
        "b4": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b5": 0,     	// 0 -> NO Alarm, 1 -> Alarm
        "b6": 0,        // 0 -> NO Alarm, 1 -> Alarm
        "b7": 0,     	// 0 -> NO Alarm, 1 -> Alarm
    }

    property var status_IO: {
        "dio12": ""
    }

    // @notification read_temperature_sensor
    // @description: Read temperature
    //
    property var status_temperature_sensor : {
        "temperature": 0 // I2C temperature from NCT375 sensor in Motherboard. Room Temperature.
    }

    property var status_temperature_pmbus : {
        "temperature_pmbus": 0 // PMBus: 0x8D READ_TEMPERATURE_1 Returns the chip sensed temperature in degrees Celsius.
    }

    property var status_enable: {
        "enable": "",
        "dio12_enable": ""
    }

    property var status_vin_good: {
        "vingood": ""
    }

    property var initial_status:{
        "enable_status":"",
        "vin_mon_status":"",
        "power_mode_status":"",
        "dio12_status":""
    }

    // -------------------  end notification messages


    // -------------------
    // Commands
    // TO SEND A COMMAND DO THE FOLLOWING:
    // EXAMPLE: To send the motor speed: platformInterface.set_enable.update("on")

    // TO SYNCHRONIZE THE SPEED ON ALL THE VIEW DO THE FOLLOWING:
    // EXAMPLE: platformInterface.enabled

    property var set_power_mode: ({
                                      "cmd":"set_power_mode",
                                      "payload":{
                                          "low_power_mode": ""	// on or off (string) (slide switch)
                                      },

                                      // Update will set and send in one shot
                                      update: function (low_power_mode) {
                                          this.set(low_power_mode)
                                          CorePlatformInterface.send(this)
                                      },
                                      // Set can set single or multiple properties before sending to platform
                                      set: function (low_power_mode) {
                                          this.payload.low_power_mode = low_power_mode;
                                      },
                                      send: function () { CorePlatformInterface.send(this) },
                                      show: function () { CorePlatformInterface.show(this) }
                                  })



    property var read_enable: ({ "cmd" : "read_enable",

                                   update: function () {
                                       CorePlatformInterface.send(this)
                                   },
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }

                               })


    property var set_enable: ({
                                  "cmd" : "set_enable",
                                  "payload": {
                                      "enable": " ",
                                  },

                                  // Update will set and send in one shot
                                  update: function (enabled) {
                                      this.set(enabled)
                                      CorePlatformInterface.send(this)
                                  },
                                  // Set can set single or multiple properties before sending to platform
                                  set: function (enabled) {
                                      this.payload.enable = enabled;
                                  },
                                  send: function () { CorePlatformInterface.send(this) },
                                  show: function () { CorePlatformInterface.show(this) }
                              })


    property var set_mode: {
        "system_mode" : ""
    }

    property var dimmensional_mode: {
        "dimmensional_mode" : ""
    }


    property var  check_vin_good: ({

                                       "cmd":"check_vin_good",
                                       update: function () {
                                           CorePlatformInterface.send(this)
                                       },
                                       send: function () { CorePlatformInterface.send(this) },
                                       show: function () { CorePlatformInterface.show(this) }
                                   })

    property var  read_initial_status: ({

                                            "cmd":"read_initial_status",
                                            update: function () {
                                                CorePlatformInterface.send(this)
                                            },
                                            send: function () { CorePlatformInterface.send(this) },
                                            show: function () { CorePlatformInterface.show(this) }

                                        })

    property var setFrequency: ({
                                    "cmd" : "set_frequency",
                                    "payload": {
                                        "frequency_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (frequency) {
                                        this.set(frequency)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (frequency) {
                                        this.payload.frequency_target = frequency;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setPWM: ({
                                    "cmd" : "set_duty",
                                    "payload": {
                                        "duty_target": 100 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (duty) {
                                        this.set(duty)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (duty) {
                                        this.payload.pwm_target = duty;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setOverTemperatureFault: ({
                                    "cmd" : "set_overTemperatureFault",
                                    "payload": {
                                        "overTemperatureFault_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (overTemperatureFault) {
                                        this.set(overTemperatureFault)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (overTemperatureFault) {
                                        this.payload.overTemperatureFault_target = overTemperatureFault;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setOverTemperatureWarning: ({
                                    "cmd" : "set_overTemperatureWarning",
                                    "payload": {
                                        "overTemperatureWarning_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (overTemperatureWarning) {
                                        this.set(overTemperatureWarning)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (overTemperatureWarning) {
                                        this.payload.overTemperatureWarning_target = overTemperatureWarning;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setVoutOVlimitFault: ({
                                    "cmd" : "set_voutOVlimitFault",
                                    "payload": {
                                        "voutOVlimitFault_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (voutOVlimitFault) {
                                        this.set(voutOVlimitFault)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (voutOVlimitFault) {
                                        this.payload.voutOVlimitFault_target = voutOVlimitFault;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setVoutOVlimitWarning: ({
                                    "cmd" : "set_voutOVlimitWarning",
                                    "payload": {
                                        "voutOVlimitWarning_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (voutOVlimitWarning) {
                                        this.set(voutOVlimitWarning)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (voutOVlimitWarning) {
                                        this.payload.voutOVlimitWarning_target = voutOVlimitWarning;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setVoutUVlimitFault: ({
                                    "cmd" : "set_voutUVlimitFault",
                                    "payload": {
                                        "voutUVlimitFault_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (voutUVlimitFault) {
                                        this.set(voutUVlimitFault)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (voutUVlimitFault) {
                                        this.payload.voutUVlimitFault_target = voutUVlimitFault;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setVoutUVlimitWarning: ({
                                    "cmd" : "set_voutUVlimitWarning",
                                    "payload": {
                                        "voutUVlimitWarning_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (voutUVlimitWarning) {
                                        this.set(voutUVlimitWarning)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (voutUVlimitWarning) {
                                        this.payload.voutUVlimitWarning_target = voutUVlimitWarning;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setIoutOClimitFault: ({
                                    "cmd" : "set_ioutOClimitFault",
                                    "payload": {
                                        "ioutOClimitFault_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (ioutOClimitFault) {
                                        this.set(ioutOClimitFault)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (ioutOClimitFault) {
                                        this.payload.ioutOClimitFault_target = ioutOClimitFault;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setIoutOClimitWarning: ({
                                    "cmd" : "set_ioutOClimitWarning",
                                    "payload": {
                                        "ioutOClimitWarning_target": 0 // default value
                                    },

                                    // Update will set and send in one shot
                                    update: function (ioutOClimitWarning) {
                                        this.set(ioutOClimitWarning)
                                        CorePlatformInterface.send(this)
                                    },
                                    // Set can set single or multiple properties before sending to platform
                                    set: function (ioutOClimitWarning) {
                                        this.payload.ioutOClimitWarning_target = ioutOClimitWarning;
                                    },
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var reset_error: {"reset_error" : ""} // Reset Error: 1

    // reset_error_selection Command
    property var set_reset_error: ({"cmd" : "set_reset_error","payload": {"reset_error": 0 ,},
                                     update: function (reset_error) {this.set(reset_error)
                                         CorePlatformInterface.send(this)},
                                     set: function (reset_error) {this.payload.reset_error = reset_error;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var parameters: {"parameters" : ""} // Set: 1

    // set_parameters Command
    property var set_parameters: ({"cmd" : "set_parameters","payload": {"parameters": 0 ,},
                                     update: function (parameters) {this.set(parameters)
                                         CorePlatformInterface.send(this)},
                                     set: function (parameters) {this.payload.parameters = parameters;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var write: {"write" : ""} // Write: 1

    // set_write Command
    property var set_write: ({"cmd" : "set_write","payload": {"write": 0 ,},
                                     update: function (write) {this.set(write)
                                         CorePlatformInterface.send(this)},
                                     set: function (write) {this.payload.write = write  ;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var voutOVFaultResponse: {"voutOVFaultResponse" : ""} // Latch: 0, Retry: 1, Ignore: 2

    // voutOVFaultResponse_selection Command
    property var set_voutOVFaultResponse: ({"cmd" : "set_voutOVFaultResponse","payload": {"voutOVFaultResponse": 0 ,},
                                     update: function (voutOVFaultResponse) {this.set(voutOVFaultResponse)
                                         CorePlatformInterface.send(this)},
                                     set: function (voutOVFaultResponse) {this.payload.voutOVFaultResponse = voutOVFaultResponse;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var voutUVFaultResponse: {"voutUVFaultResponse" : ""} // Latch: 0, Retry: 1, Ignore: 2

    // voutUVFaultResponse_selection Command
    property var set_voutUVFaultResponse: ({"cmd" : "set_voutUVFaultResponse","payload": {"voutUVFaultResponse": 0 ,},
                                     update: function (voutUVFaultResponse) {this.set(voutUVFaultResponse)
                                         CorePlatformInterface.send(this)},
                                     set: function (voutUVFaultResponse) {this.payload.voutUVFaultResponse = voutUVFaultResponse;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var ioutOCFaultResponse: {"ioutOCFaultResponse" : ""} // Latch: 0, Retry: 1, Ignore: 2

    // ioutOCFaultResponse_selection Command
    property var set_ioutOCFaultResponse: ({"cmd" : "set_ioutOCFaultResponse","payload": {"ioutOCFaultResponse": 0 ,},
                                     update: function (ioutOCFaultResponse) {this.set(ioutOCFaultResponse)
                                         CorePlatformInterface.send(this)},
                                     set: function (ioutOCFaultResponse) {this.payload.ioutOCFaultResponse = ioutOCFaultResponse;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    /*
       system_mode_selection Command
     */
    property var system_mode_selection: ({
                                             "cmd" : "set_system_mode",
                                             "payload": {
                                                 "system_mode":" " // "automatic" or "normal"
                                             },

                                             // Update will set and send in one shot
                                             update: function (system_mode) {
                                                 this.set(system_mode)
                                                 CorePlatformInterface.send(this)
                                             },
                                             // Set can set single or multiple properties before sending to platform
                                             set: function (system_mode) {
                                                 this.payload.system_mode = system_mode;
                                             },
                                             send: function () { CorePlatformInterface.send(this) },
                                             show: function () { CorePlatformInterface.show(this) }
                                         })

    /*
       dimmensional_mode_selection Command
     */
    property var dimmensional_mode_selection: ({
                                             "cmd" : "set_dimmensional_mode",
                                             "payload": {
                                                 "dimmensional_mode":" " // "automatic" or "normal"
                                             },

                                             // Update will set and send in one shot
                                             update: function (dimmensional_mode) {
                                                 this.set(dimmensional_mode)
                                                 CorePlatformInterface.send(this)
                                             },
                                             // Set can set single or multiple properties before sending to platform
                                             set: function (dimmensional_mode) {
                                                 this.payload.dimmensional_mode = dimmensional_mode;
                                             },
                                             send: function () { CorePlatformInterface.send(this) },
                                             show: function () { CorePlatformInterface.show(this) }
                                         })

    // This is a HACK implementation//////////////////////////////
    property var pause_periodic: ({
                                      "cmd" : "pause_periodic",
                                      "payload": {
                                          "pause_flag": "",
                                      },

                                      // Set can set single or multiple properties before sending to platform
                                      set: function (pause_flag) {
                                          this.payload.pause_flag = pause_flag;
                                      },

                                      // Update will set and send in one shot
                                      update: function (pause_flag) {
                                          this.set(pause_flag)
                                          CorePlatformInterface.send(this)
                                      },
                                      send: function () { CorePlatformInterface.send(this) },
                                      show: function () { CorePlatformInterface.show(this) }
                                  })
    // -------------------  end commands

    // -------------------------------------------------------------------
    // Connect to CoreInterface notification signals
    // -------------------------------------------------------------------
    // Listens to message notifications coming from CoreInterface.cpp
    // Forward messages to core_platform_interface.js to process
    // -------------------------------------------------------------------

    Connections {
        target: coreInterface
        onNotification: {
            CorePlatformInterface.data_source_handler(payload)
            pause_periodic = false
        }
    }

    //-----------------------------------------
    // add all syncrhonized controls here
    //-----------------------------------------

    property bool systemMode: true
    onSystemModeChanged: {
        if(systemMode){
            console.log("Normal Operation")
            system_mode_selection.update("normal")
        }
        else{
            console.log("Load Transient")
            system_mode_selection.update("automatic")
        }
    }

    property bool dimmensionalMode: true
    onDimmensionalModeChanged: {
        if(dimmensionalMode){
            console.log("2D")
            dimmensional_mode_selection.update("2D")
        }
        else{
            console.log("3D")
            dimmensional_mode_selection.update("3D")
        }
    }

////    property int frequency: 0
//    onFrequencyChanged: {
//        setFrequency.update(frequency)
//    }

////    property int duty: 0
//    onDutyChanged: {
//        setPWM.update(duty)
//    }

    property int overTemperatureFault: 0
    onOverTemperatureFaultChanged: {
        setOverTemperatureFault.update(overTemperatureFault)
    }

    property int overTemperatureWarning: 0
    onOverTemperatureWarningChanged: {
        setOverTemperatureWarning.update(overTemperatureWarning)
    }

    property int voutOVlimitFault: 0
    onVoutOVlimitFaultChanged: {
        setVoutOVlimitFault.update(voutOVlimitFault)
    }

    property int voutOVlimitWarning: 0
    onVoutOVlimitWarningChanged: {
        setVoutOVlimitWarning.update(voutOVlimitWarning)
    }

    property int voutUVlimitFault: 0
    onVoutUVlimitFaultChanged: {
        setVoutUVlimitFault.update(voutUVlimitFault)
    }

    property int voutUVlimitWarning: 0
    onVoutUVlimitWarningChanged: {
        setVoutUVlimitWarning.update(voutUVlimitWarning)
    }

    property int ioutOClimitFault: 0
    onIoutOClimitFaultChanged: {
        setIoutOClimitFault.update(ioutOClimitFault)
    }

    property int ioutOClimitWarning: 0
    onIoutOClimitWarningChanged: {
        setIoutOClimitWarning.update(ioutOClimitWarning)
    }
    // -------------------------------------------------------------------

}
