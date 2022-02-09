/*
 * Copyright (c) 2018-2021 onsemi.
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

    /******************************************************************
      * NOTIFICATIONS
    ******************************************************************/

    // -------------------------------------------------------------------
    // Incoming Notification Messages
    //

    //Initial current and voltage values
    property double current: 0.7
    property double voltage: 10
    property bool current_on: false
    property bool voltage_on: false

    property var request_initial_values : {
        "current": 3,
        "voltage": 7
    }
    onRequest_initial_valuesChanged: {

        if(request_initial_values.current !== 0)
        {
            current = request_initial_values.current
            current_on = true
        }
        else
        {
            current = 0.7
            current_on = false

        }

        if(request_initial_values.voltage !== 0)
        {
            voltage = request_initial_values.voltage
            voltage_on = true
        }
        else
        {
            voltage = 10
            voltage_on = false
        }

    }

    /******************************************************************
      * COMMANDS
    ******************************************************************/

//    QtObject {
//        id: commands

        property var request_initial_values_command : ({
                "cmd" : "request_initial_values",
                "payload": {},

                update: function () {
                    this.send(this)
                },
                set: function () {
                },
                send: function () { CorePlatformInterface.send(this) },
                show: function () { CorePlatformInterface.show(this) }
            })

        // @command set_i_led
        // @property duty_cycle: double
        // @property status: bool
        property var set_i_led: ({
            "cmd": "set_i_led",
            "payload": {
                "current": 0.0,
                "status": false
            },
            update: function (current,status) {
                this.set(current,status)
                this.send(this)
            },
            set: function (current,status) {
                this.payload.current = current
                this.payload.status = status
            },
            send: function () { CorePlatformInterface.send(this) }
        })

        // @command set_v_out
        // @property duty_cycle: double
        // @property status: bool
        property var set_v_out: ({
            "cmd": "set_v_out",
            "payload": {
                "voltage": 0.0,
                "status": false
            },
            update: function (voltage,status) {
                this.set(voltage,status)
                this.send(this)
            },
            set: function (voltage,status) {
                this.payload.voltage = voltage
                this.payload.status = status
            },
            send: function () { CorePlatformInterface.send(this) }
        })

        // @command save_values
        // @property voltage: double
        // @property current: double
        property var save_values: ({
            "cmd": "save_values",
            "payload": {
                "voltage": 0.0,
                "current": 0.0
            },
            update: function (voltage, current) {
                this.set(voltage, current)
                this.send(this)
            },
            set: function (voltage, current) {
                this.payload.voltage = voltage
                this.payload.current = current
            },
            send: function () { CorePlatformInterface.send(this) }
        })

        // @command set_flash_pwm
        // @property on_time: double
        // @property status: bool
        property var set_flash_pwm: ({
            "cmd": "set_flash_pwm",
            "payload": {
                "on_time": 0.0,
                "status": false
            },
            update: function (on_time,status) {
                this.set(on_time,status)
                this.send(this)
            },
            set: function (on_time,status) {
                this.payload.on_time = on_time
                this.payload.status = status
            },
            send: function () { CorePlatformInterface.send(this) }
        })

    // -------------------------------------------------------------------
    // Listens to message notifications coming from CoreInterface.cpp
    // Forward messages to core_platform_interface.js to process

    Connections {
        target: coreInterface
        onNotification: {
            CorePlatformInterface.data_source_handler(payload)
        }
    }
}
