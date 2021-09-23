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
import QtQuick.Window 2.3
import "qrc:/js/core_platform_interface.js" as CorePlatformInterface

Item {
    id: platformInterface

    // -------------------
    // Notification Messages
    //
    // define and document incoming notification messages
    //  the properties of the message must match with the UI elements using them
    //  document all messages to clearly indicate to the UI layer proper names

    // @notification request_usb_power_notification
    // @description: shows relevant data for a single port.
    //
    property var request_usb_power_notification : {
        "port": 1,
        "device": "PD",      // or "non-PD", or "none" if disconnected
        "advertised_maximum_current": 0.0,
        "negotiated_current": 0.0,
        "negotiated_voltage": 0.0,
        "input_voltage": 0.0,
        "output_voltage":0.0,
        "input_current": 0.0,
        "output_current":0.0,
        "temperature": 0.0,
        "maximum_power":0.0
    }



    onRequest_usb_power_notificationChanged: {
//        console.log("output voltage=",request_usb_power_notification.output_voltage,
//                    "output current=",request_usb_power_notification.output_current,
//                    "power=",request_usb_power_notification.output_voltage * request_usb_power_notification.output_current);
    }


    //after the first run of boards was already out in the wild, it was discovered that the input and output
    //current readings weren't correct. If the firmware date is earlier than 6/11/2019, then the amplitude should
    //be multiplied by 1.33. This property will be true if that adjustment should be made, and will be set when the
    //firmware info changes
    property var adjust_current:false
    property var oldFirmwareScaleFactor: 1.333

    property var get_firmware_info:{
        "bootloader":"",
        "application":{
            "date":"0",
            "version":"0"
        }
    }

    //if the firmware is dated earlier than 6/11/2019, then set adjust_current to true;
    onGet_firmware_infoChanged: {
        console.log("get_firmware_info changed. firmware date is=",get_firmware_info.application.date);
        var year= get_firmware_info.application.date.substr(0,4);
        var month = get_firmware_info.application.date.substr(5,2);
        var day = get_firmware_info.application.date.substr(8,2);
        console.log("year=",year,"month=",month,"day=",day);
        if (year<=2019 && month<6 ){
            adjust_current = true;
            }
          else if (year<=2019 && month===6 && day<=11 ){
            adjust_current = true;
            }
          else{
            adjust_current = false;
            }

        console.log("adjust_current set to",adjust_current);

    }

    // @notification usb_pd_port_connect
    // @description: sent when a device is connected or disconnected
    //
    property var usb_pd_port_connect : {
        "port_id": "",
        "connection_state":"unknown"
    }
    onUsb_pd_port_connectChanged: {
        console.log("usb_pd_port_connect changed. port_id=",usb_pd_port_connect.port_id," connection_state=",usb_pd_port_connect.connection_state);
        //ask for a firmware version from the new device
         getFirmwareInfo.send();
    }

    property var usb_pd_port_disconnect:{
        "port_id": "unknown",
        "connection_state": "unknown"
    }

    property var usb_pd_protection_action:{
         "action":"shutdown"     // or "nothing" or "retry"
    }


   property var input_under_voltage_notification:{
          "state":"below",                                        // if the input voltage decreases to below the voltage limit, "above" otherwise.
          "minimum_voltage":0                                     // Voltage limit in volts
    }

//    onInput_under_voltage_notificationChanged: {
//        console.log("input voltage is",input_under_voltage_notification.state,
//                    " minimum voltage = ",input_under_voltage_notification.minimum_voltage);

//    }

    property var set_maximum_temperature_notification:{
            "maximum_temperature":0                         // degrees C
            }

   property var over_temperature_notification:{
           "port":"USB_C_port_1",                                // or any USB C port
           "state":"below",                                      // if the temperature crossed from under temperature to over temperature, "below" otherwise.
           "maximum_temperature":135                             // Temperature limit in degrees C
    }

        //consider the values held by this property to be the master ones, which will be current when needed for calling
        //the API to set the input voltage foldback
    property var foldback_input_voltage_limiting_event:{
            "input_voltage":0,
            "foldback_minimum_voltage":0,
            "foldback_minimum_voltage_power":0,
            "input_voltage_foldback_enabled":false,
            "input_voltage_foldback_active":true
    }

//  onFoldback_input_voltage_limiting_eventChanged: {
//        console.log("input voltage foldback values updated");
//        console.log("input voltage event notification. values are ",foldback_input_voltage_limiting_refresh.foldback_minimum_voltage,
//                                                                    foldback_input_voltage_limiting_refresh.foldback_minimum_voltage_power,
//                                                                    foldback_input_voltage_limiting_refresh.input_voltage_foldback_enabled,
//                                                                    foldback_input_voltage_limiting_refresh.input_voltage_foldback_active);
//        }

    property var foldback_input_voltage_limiting_refresh:{
            "input_voltage":0,
            "foldback_minimum_voltage":0,
            "foldback_minimum_voltage_power":0,
            "input_voltage_foldback_enabled":false,
            "input_voltage_foldback_active":true
    }

    //keep the refresh and event notification properties in synch
//    onFoldback_input_voltage_limiting_refreshChanged: {
//        //console.log("input voltage refresh notification. minimum voltage = ",foldback_input_voltage_limiting_refresh.foldback_minimum_voltage);

//            //update the variables for foldback limiting
//        platformInterface.foldback_input_voltage_limiting_event.input_voltage = foldback_input_voltage_limiting_refresh.input_voltage;

//        platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage = foldback_input_voltage_limiting_refresh.foldback_minimum_voltage;
//        console.log(" foldback minimum voltage = ",platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage);
//        platformInterface.foldback_input_voltage_limiting_event.foldback_minimum_voltage_power = foldback_input_voltage_limiting_refresh.foldback_minimum_voltage_power;
//        platformInterface.foldback_input_voltage_limiting_event.input_voltage_foldback_enabled = foldback_input_voltage_limiting_refresh.input_voltage_foldback_enabled;
//        platformInterface.foldback_input_voltage_limiting_event.input_voltage_foldback_active = foldback_input_voltage_limiting_refresh.input_voltage_foldback_active;
//    }

    //consider the values held by this property to be the master ones, which will be current when needed for calling
    //the API to set the input temperature foldback
    property var foldback_temperature_limiting_event:{
            "port":0,
            "current_temperature":0,
            "foldback_maximum_temperature":135,
            "foldback_maximum_temperature_power":15,
            "temperature_foldback_enabled":true,
            "temperature_foldback_active":true,
            "maximum_power":0
    }

    property var foldback_temperature_limiting_refresh:{
            "port":0,
            "current_temperature":0,
            "foldback_maximum_temperature":135,
            "foldback_maximum_temperature_power":15,
            "temperature_foldback_enabled":true,
            "temperature_foldback_active":true,
            "maximum_power":0
    }
    //keep the refresh and event notification properties in synch
//    onFoldback_temperature_limiting_refreshChanged: {
//        //update the corresponding variables
//        foldback_temperature_limiting_event.port = foldback_input_voltage_limiting_refresh.port;
//        foldback_temperature_limiting_event.current_temperature = foldback_temperature_limiting_refresh.current_temperature;
//        foldback_temperature_limiting_event.foldback_maximum_temperature = foldback_temperature_limiting_refresh.foldback_maximum_temperature;
//        foldback_temperature_limiting_event.foldback_maximum_temperature_power = foldback_temperature_limiting_refresh.foldback_maximum_temperature_power;
//        foldback_temperature_limiting_event.temperature_foldback_enabled = foldback_temperature_limiting_refresh.temperature_foldback_enabled;
//        foldback_temperature_limiting_event.temperature_foldback_active = foldback_temperature_limiting_refresh.temperature_foldback_active;
//        foldback_temperature_limiting_event.maximum_power = foldback_temperature_limiting_refresh.maximum_power;
//    }

    property var usb_pd_maximum_power:{
        "port":0,                            // up to maximum number of ports
        "current_max_power":0,               // 15 | 27 | 36 | 45 | 60 | 100
        "default_max_power":0,               // 15 | 27 | 36 | 45 | 60 | 100
        "commanded_max_power":0
    }

    property var request_over_current_protection_notification:{
        "port":0,                           // 1, 2, ... maximum port number
        "current_limit":0,                  // amps - output current  exceeds this level
        "exceeds_limit":false,              // or false
        "action":"nothing",                 // "retry" or "shutdown" or "nothing"
        "enabled":false                     // or false
    }

    property var get_cable_loss_compensation:{
        "port":0,                           // Same port as in the command above.
        "output_current":0,                 // Amps
        "bias_voltage":0,                   // Volts
    }

    property var usb_pd_advertised_voltages_notification:{
        "port":0,                            // The port number that this applies to
        "maximum_power":45,                  // watts
        "number_of_settings":7,              // 1-7
        "settings":[]                        // each setting object includes
                                             // "voltage":5,                // Volts
                                             // "maximum_current":3.0,      // Amps
    }

    property var request_reset_notification :{
         "reset_status":true                   // only one value : true since only sent at the start
    }

    //when the platform sends a reset notification, the host must make a platformId call to initialize communication
    //and a Refresh() command to synchronize settings with the platform
    onRequest_reset_notificationChanged: {
        console.log("Requesting Refresh")
        platformInterface.refresh.send() //ask the platform for all the current values
    }

    //this call doesn't exist yet in the API. This is a placeholder
    property var power_negotiation :{
         "negotiation_type":"dynamic"           // or "first_come_first_served" or "priority"
    }

    property var sleep_mode :{
         "mode":"manual"           // or "automatic"
    }

    property var manual_sleep_mode :{
         "mode":"on"           // or "off"
    }

    property var sleep_state :{
         "state":"awake",    // or "asleep"
    }

    property var maximum_board_power :{
         "watts":200          // 30-300
    }


    property var ac_power_supply_connection:{
        "state":"disconnected",  // "disconnected" or "connected"
                "verbose_name":"ON AC PS 1.0",
                "platform_id":"SEC.2018.012.1.2.cbde0512-0e12-1111-abcd-abcd12345678",
                "parameters":""  // valid JSON string contained within quotes. Empty string if no parametric data.
    }

    property var assured_power_port:{
        "port":1,          // port to enable/disable for assured power
        "enabled":true,     // or 'false' if disabling assured port
        "power":100        // watts available to the port
    }

    property var usb_pd_negotiated_contract_notification:{
        "port":1,              // or any USB C port id
        "voltage":12,          // One of the available voltages
        "maximum_current":100  // in milliamps

    }

    property var output_current_exceeds_maximum:{
        "port":1,              // 1, 2, ... maximum port number
        "current_limit":6,    // amps - output current  exceeds this level
        "exceeds_limit":true,  // or false
        "action":"retry",      // "retry" or "shutdown" or "nothing"
        "enabled":true         // or false
    }


    // --------------------------------------------------------------------------------------------
    //          Commands
    //--------------------------------------------------------------------------------------------

    property var requestPlatformId:({
                 "cmd":"request_platform_id",
                 "payload":{
                  },
                 send: function(){
                      CorePlatformInterface.send(this)
                 }
     })

    property var getFirmwareInfo:({
                 "cmd":"get_firmware_info",
                 "payload":{
                  },
                 send: function(){
                      CorePlatformInterface.send(this)
                 }
     })


   property var refresh:({
                "cmd":"request_platform_refresh",
                "payload":{
                 },
                send: function(){
                     CorePlatformInterface.send(this)
                }
    })

    property var set_protection_action:({
                "cmd":"request_protection_action",
                "payload":{
                        "action":"shutdown"         // "shutdown" or "retry" or "nothing"
                     },
                update: function(protectionAction){
                    this.set(protectionAction)
                    CorePlatformInterface.send(this)
                },
                set: function(protectionAction){
                    this.payload.action = protectionAction;
                },
                send: function(){
                    CorePlatformInterface.send(this)
                },
                show: function(){
                    CorePlatformInterface.show(this)
                }
    })

    property var set_minimum_input_voltage:({
               "cmd":"request_set_minimum_voltage",
               "payload":{
                    "value":0    // 0 - 20v
               },
                update: function(minimumVoltage){
                    this.set(minimumVoltage)
                    CorePlatformInterface.send(this)
                },
                set: function(minimumVoltage){
                    this.payload.value = minimumVoltage;
                },
                send: function(){
                    CorePlatformInterface.send(this)
                },
                show: function(){
                    CorePlatformInterface.show(this)
                }
    })

    property var set_maximum_temperature :({
                "cmd":"request_set_maximum_temperature",
                "payload":{
                       "value":135    // 0 - 135 degrees C
                 },
                 update: function(maximumTemperature){
                      this.set(maximumTemperature)
                      CorePlatformInterface.send(this)
                      },
                 set: function(maximumTemperature){
                      this.payload.value = maximumTemperature;
                      },
                 send: function(){
                       CorePlatformInterface.send(this)
                      },
                show: function(){
                      CorePlatformInterface.show(this)
                      }
    })

    property var  set_input_voltage_foldback:({
                  "cmd":"request_voltage_foldback",
                  "payload":{
                        "enabled":false,  // or true
                        "voltage":0,    // in Volts
                         "power":45      // in Watts
                       },
                   update: function(enabled,voltage,watts){
                       console.log("input voltage foldback update: enabled=",enabled,"voltage=",voltage,"watts=",watts);
                       //set the notification property values, as the platform won't send a notification in response to this
                       //command, and those properties are used by controls to see what the value of other controls should be.
                       foldback_input_voltage_limiting_event.input_voltage_foldback_enabled = enabled;
                       foldback_input_voltage_limiting_event.foldback_minimum_voltage = voltage;
                       foldback_input_voltage_limiting_event.foldback_minimum_voltage_power = watts;
                        this.set(enabled,voltage,watts)
                        CorePlatformInterface.send(this)
                        },
                   set: function(enabled,voltage,watts){
                        this.payload.enabled = enabled;
                        this.payload.voltage = voltage;
                        this.payload.power = watts;
                        },
                   send: function(){
                        CorePlatformInterface.send(this)
                        },
                   show: function(){
                        CorePlatformInterface.show(this)
                        }
    })

    property var  set_temperature_foldback:({
                  "cmd":"request_temperature_foldback",
                  "payload":{
                        "enabled":false,  // or true
                        "temperature":0,    // in °C
                        "power":45      // in Watts
                       },
                   update: function(enabled,temperature,watts){
                       //update the variables for this action
//                       foldback_temperature_limiting_event.foldback_maximum_temperature = temperature;
//                       foldback_temperature_limiting_event.foldback_maximum_temperature_power = watts;
//                       foldback_temperature_limiting_event.temperature_foldback_enabled = enabled;
                        this.set(enabled,temperature,watts)
                        CorePlatformInterface.send(this)
                        },
                   set: function(enabled,temperature,watts){
                        this.payload.enabled = enabled;
                        this.payload.temperature = temperature;
                        this.payload.power = watts;
                        },
                   send: function(){
                        CorePlatformInterface.send(this)
                        },
                   show: function(){
                        CorePlatformInterface.show(this)
                        }
    })

    property var set_usb_pd_maximum_power : ({
                    "cmd":"request_usb_pd_maximum_power",
                    "payload":{
                         "port":0,      // up to maximum number of ports
                         "watts":0      // 15 | 27 | 36 | 45 | 60 | 100
                         },
                    update: function (port, watts){
                        this.set(port,watts);
                        CorePlatformInterface.send(this);
                    },
                    set: function(port,watts){
                        this.payload.port = port;
                        this.payload.watts = watts;
                    },
                    send: function () { CorePlatformInterface.send(this) },
                    show: function () { CorePlatformInterface.show(this) }
    })

    property var request_over_current_protection:({
                    "cmd":"request_over_current_protection",
                    "payload":{
                        "port":0,                    // 1, 2, 3, ... up to maximum number of ports
                        "enabled":true,           // or false
                        "maximum_current":12,    // amps
                      },
                      update: function (port, maxCurrent){
                          this.set(port,maxCurrent);
                          CorePlatformInterface.send(this);
                          },
                      set: function(port,maxCurrent){
                           this.payload.port = port;
                           this.payload.enabled = true;    //the UI currently has no way to disable over current protection
                           this.payload.maximum_current = maxCurrent;
                                                  },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })

//    property var set_cable_compensation:({
//                     "cmd":"set_cable_loss_compensation",
//                     "payload":{
//                        "port":1,                   // 1, 2, 3, ... up to maximum number of ports
//                         "output_current":0,         // amps
//                          "bias_voltage":0,            // Volts
//                       },
//                      update: function (portNumber, outputCurrent, biasVoltage){
//                          this.set(portNumber,outputCurrent,biasVoltage);
//                          //console.log("sending set_cable_loss_compensation cmd ", JSON.stringify(this));
//                          CorePlatformInterface.send(this);
//                        },
//                      set: function(portNumber,outputCurrent,biasVoltage){
//                               this.payload.port = portNumber;
//                               this.payload.output_current = outputCurrent;
//                               this.payload.bias_voltage = biasVoltage;
//                        },
//})


    property var set_cable_compensation:({
                    "cmd":"set_cable_loss_compensation",
                    "payload":{
                        "port":1,                   // 1, 2, 3, ... up to maximum number of ports
                        "output_current":0,         // amps
                        "bias_voltage":0,            // Volts
                      },
                      update: function (portNumber, outputCurrent, biasVoltage){
                          //adding back these console messages will cause an error when the update function is called.
                          //console.log("set_cable_loss_compensation.port=",portNumber);
                          //console.log("set_cable_loss_compensation.output_current=",outputCurrent);
                          //console.log("set_cable_loss_compensation.bias_voltage=",biasVoltage);

                          this.set(portNumber,outputCurrent,biasVoltage);
                          //console.log("sending set_cable_loss_compensation cmd ", JSON.stringify(this));
                          CorePlatformInterface.send(this);
                          },
                      set: function(portNumber,outputCurrent,biasVoltage){
                           this.payload.port = portNumber;
                           this.payload.output_current = outputCurrent;
                           this.payload.bias_voltage = biasVoltage;
                          },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })


    property var set_power_negotiation:({
                    "cmd":"set_power_negotiation",
                    "payload":{
                    "negotiation_type":"dynamic",    // or firstComeFirstServed or priority
                      },
                      update: function (type){
                          this.set(type);
                          CorePlatformInterface.send(this);
                          },
                      set: function(type){
                           this.payload.negotiation_type = type;
                           },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })



    property var set_sleep_mode:({
                    "cmd":"set_sleep_mode",
                    "payload":{
                        "mode":"manual",    // or automatic
                      },
                      update: function (mode){
                          this.set(mode);
                          CorePlatformInterface.send(this);
                          },
                      set: function(mode){
                           this.payload.mode = mode;
                           },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })

    property var set_manual_sleep_mode:({
                    "cmd":"set_manual_sleep_mode",
                    "payload":{
                        "mode":"on",    // or off
                      },
                      update: function (mode){
                          this.set(mode);
                          CorePlatformInterface.send(this);
                          },
                      set: function(mode){
                           this.payload.mode = mode;
                           },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })

    property var set_maximum_board_power:({
                    "cmd":"set_maximum_board_power",
                    "payload":{
                        "watts":0      // value between 30 and 200
                      },
                      update: function (inPower){
                          this.set(inPower);
                          CorePlatformInterface.send(this);
                          },
                      set: function(power){
                           this.payload.watts = power;
                           },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })

    property var set_assured_power_port:({
                    "cmd":"set_assured_power_port",
                    "payload":{
                        "port":1,
                        "enabled":true
                      },
                      update: function (inEnabled, inPort){
                          console.log("setting assured port power to ",inEnabled,"on port",inPort);
                          this.set(inEnabled, inPort);
                          CorePlatformInterface.send(this);
                          },
                      set: function(inEnabled, inPort){
                           this.payload.enabled = inEnabled;
                           this.payload.port = inPort;
                           },
                      send: function () { CorePlatformInterface.send(this) },
                      show: function () { CorePlatformInterface.show(this) }
    })

    // -------------------  end commands

    // NOTE:
    //  All internal property names for PlatformInterface must avoid name collisions with notification/cmd message properties.
    //   naming convention to avoid name collisions;
    // property var _name


    // -------------------------------------------------------------------
    // Connect to CoreInterface notification signals
    //
    Connections {
        target: coreInterface
        onNotification: {
            if (!payload.includes("request_usb_power_notification")){
                console.log("**** Notification",payload);
            }
            CorePlatformInterface.data_source_handler(payload)
        }
    }
}
