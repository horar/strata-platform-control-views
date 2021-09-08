import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import "qrc:/js/core_platform_interface.js" as CorePlatformInterface

Item {
    id: platformInterface

    // Periodic Notification Messages
    property var status_vi: {
        "t": 0,       // Target speed in RPM
        "a": 0,       // Actual speed in RPM
        "l": 0,       // Dc link Vin in Volts
        "u": 0,       // Winding Iout Iu (1) in Amps
        "v": 0,       // Winding Iout Iv (2) in Amps
        "w": 0,       // Winding Iout Iw (3) in Amps
        "U": 0,       // Winding temperature U (1) in °C
        "V": 0,       // Winding temperature V (2) in °C
        "W": 0,       // Winding temperature W (3) in °C
    }

    property var status_IO: {"motor_EN": ""}

    property var status_enable: {"enable": "","motor_EN_enable": ""}

    property var status_vin_good: {"vingood": ""}

    property var initial_status:{"enable_status":"","vin_mon_status":"","power_mode_status":"","motor_EN_status":""}

    // -------------------  end notification messages

    property var set_power_mode: ({"cmd":"set_power_mode","payload":{"low_power_mode": ""},
                                      update: function (low_power_mode) {this.set(low_power_mode)
                                          CorePlatformInterface.send(this)},
                                      set: function (low_power_mode) {this.payload.low_power_mode = low_power_mode;},
                                      send: function () {CorePlatformInterface.send(this)},
                                      show: function () {CorePlatformInterface.show(this)}
                                  })

    property var read_motor_EN: ({ "cmd" : "read_motor_EN",
                                   update: function () {CorePlatformInterface.send(this)},
                                   send: function () {CorePlatformInterface.send(this)},
                                   show: function () {CorePlatformInterface.show(this)}
                               })

    property var read_enable: ({ "cmd" : "read_enable",
                                   update: function () {CorePlatformInterface.send(this)},
                                   send: function () {CorePlatformInterface.send(this)},
                                   show: function () {CorePlatformInterface.show(this)}
                               })

    property var set_motor_EN: ({"cmd" : "set_motor_EN","payload": {"motor_EN_enable": " ",},
                                  update: function (motor_EN_enabled) {this.set(motor_EN_enabled)
                                      CorePlatformInterface.send(this)},
                                  set: function (motor_EN_enabled) {this.payload.motor_EN_enable = motor_EN_enabled;},
                                  send: function () {CorePlatformInterface.send(this)},
                                  show: function () {CorePlatformInterface.show(this)}
                              })

    property var set_direction: ({"cmd" : "set_direction","payload": {"direction": 0},
                                  update: function (direction) {this.set(direction)
                                      CorePlatformInterface.send(this)},
                                  set: function (direction) {this.payload.direction = direction;},
                                  send: function () {CorePlatformInterface.send(this)},
                                  show: function () {CorePlatformInterface.show(this)}
                              })

    property var set_enable: ({"cmd" : "set_enable","payload": {"enable": " ",},
                                  update: function (enabled) {this.set(enabled)
                                      CorePlatformInterface.send(this)},
                                  set: function (enabled) {this.payload.enable = enabled;},
                                  send: function () {CorePlatformInterface.send(this)},
                                  show: function () {CorePlatformInterface.show(this)}
                              })

    property var setT1_single: ({"cmd" : "set_t1_single","payload": {"t1_single_target": 0},
                                    update: function (t1_single) {this.set(t1_single)
                                        CorePlatformInterface.send(this)},
                                    set: function (t1_single) {this.payload.t1_single_target = t1_single;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setT1_double: ({"cmd" : "set_t1_double","payload": {"t1_double_target": 0},
                                    update: function (t1_double) {this.set(t1_double)
                                        CorePlatformInterface.send(this)},
                                    set: function (t1_double) {this.payload.t1_double_target = t1_double;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setT2_double: ({"cmd" : "set_t2_double","payload": {"t2_double_target": 0},
                                    update: function (t2_double) {this.set(t2_double)
                                        CorePlatformInterface.send(this)},
                                    set: function (t2_double) {this.payload.t2_double_target = t2_double;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setT3_double: ({"cmd" : "set_t3_double","payload": {"t3_double_target": 0},
                                    update: function (t3_double) {this.set(t3_double)
                                        CorePlatformInterface.send(this)},
                                    set: function (t3_double) {this.payload.t3_double_target = t3_double;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setT1_short: ({"cmd" : "set_t1_short","payload": {"t1_short_target": 0},
                                    update: function (t1_short) {this.set(t1_short)
                                        CorePlatformInterface.send(this)},
                                    set: function (t1_short) {this.payload.t1_short_target = t1_short;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setGainVolt: ({"cmd" : "set_gainVolt","payload": {"gainVolt_target": 0},
                                    update: function (gainVolt) {this.set(gainVolt)
                                        CorePlatformInterface.send(this)},
                                    set: function (gainVolt) {this.payload.gainVolt_target = gainVolt;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setOffsetVolt: ({"cmd" : "set_offsetVolt","payload": {"offsetVolt_target": 0},
                                    update: function (offsetVolt) {this.set(offsetVolt)
                                        CorePlatformInterface.send(this)},
                                    set: function (offsetVolt) {this.payload.offsetVolt_target = offsetVolt;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setGainCurrent: ({"cmd" : "set_gainCurrent","payload": {"gainCurrent_target": 0},
                                    update: function (gainCurrent) {this.set(gainCurrent)
                                        CorePlatformInterface.send(this)},
                                    set: function (gainCurrent) {this.payload.gainCurrent_target = gainCurrent;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setOffsetCurrent: ({"cmd" : "set_offsetCurrent","payload": {"offsetCurrent_target": 0},
                                    update: function (offsetCurrent) {this.set(offsetCurrent)
                                        CorePlatformInterface.send(this)},
                                    set: function (offsetCurrent) {this.payload.offsetCurrent_target = offsetCurrent;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setR25: ({"cmd" : "set_r25","payload": {"r25_target": 0},
                                    update: function (r25) {this.set(r25)
                                        CorePlatformInterface.send(this)},
                                    set: function (r25) {this.payload.r25_target = r25;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setR2550: ({"cmd" : "set_r2550","payload": {"r2550_target": 0},
                                    update: function (r2550) {this.set(r2550)
                                        CorePlatformInterface.send(this)},
                                    set: function (r2550) {this.payload.r2550_target = r2550;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setR2580: ({"cmd" : "set_r2580","payload": {"r2580_target": 0},
                                    update: function (r2580) {this.set(r2580)
                                        CorePlatformInterface.send(this)},
                                    set: function (r2580) {this.payload.r2580_target = r2580;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setR25120: ({"cmd" : "set_r25120","payload": {"r25120_target": 0},
                                    update: function (r25120) {this.set(r25120)
                                        CorePlatformInterface.send(this)},
                                    set: function (r25120) {this.payload.r25120_target = r25120;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })


    property var setFrequency: ({"cmd" : "set_frequency","payload": {"frequency_target": 0},
                                    update: function (frequency) {this.set(frequency)
                                        CorePlatformInterface.send(this)},
                                    set: function (frequency) {this.payload.frequency_target = frequency;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setDuty: ({"cmd" : "set_duty","payload": {"duty_target": 0},
                                    update: function (duty) {this.set(duty)
                                        CorePlatformInterface.send(this)},
                                    set: function (duty) {this.payload.duty_target = duty;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setPulses: ({"cmd" : "set_pulses","payload": {"pulses_target": 0},
                                    update: function (pulses) {this.set(pulses)
                                        CorePlatformInterface.send(this)},
                                    set: function (pulses) {this.payload.pulses_target = pulses;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setOverTemperatureFault: ({"cmd" : "set_overTemperatureFault","payload": {"overTemperatureFault_target": 0},
                                    update: function (overTemperatureFault) {this.set(overTemperatureFault)
                                        CorePlatformInterface.send(this)},
                                    set: function (overTemperatureFault) {this.payload.overTemperatureFault_target = overTemperatureFault;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setOverTemperatureWarning: ({"cmd" : "set_overTemperatureWarning","payload": {"overTemperatureWarning_target": 0},
                                    update: function (overTemperatureWarning) {this.set(overTemperatureWarning)
                                        CorePlatformInterface.send(this)},
                                    set: function (overTemperatureWarning) {this.payload.overTemperatureWarning_target = overTemperatureWarning;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setVinOVlimitFault: ({"cmd" : "set_vinOVlimitFault","payload": {"vinOVlimitFault_target": 0},
                                    update: function (vinOVlimitFault) {this.set(vinOVlimitFault)
                                        CorePlatformInterface.send(this)},
                                    set: function (vinOVlimitFault) {this.payload.vinOVlimitFault_target = vinOVlimitFault;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setVinOVlimitWarning: ({"cmd" : "set_vinOVlimitWarning","payload": {"vinOVlimitWarning_target": 0},
                                    update: function (vinOVlimitWarning) {this.set(vinOVlimitWarning)
                                        CorePlatformInterface.send(this)},
                                    set: function (vinOVlimitWarning) {this.payload.vinOVlimitWarning_target = vinOVlimitWarning;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setVinUVlimitFault: ({"cmd" : "set_vinUVlimitFault","payload": {"vinUVlimitFault_target": 0},
                                    update: function (vinUVlimitFault) {this.set(vinUVlimitFault)
                                        CorePlatformInterface.send(this)},
                                    set: function (vinUVlimitFault) {this.payload.vinUVlimitFault_target = vinUVlimitFault;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setVinUVlimitWarning: ({"cmd" : "set_vinUVlimitWarning","payload": {"vinUVlimitWarning_target": 0},
                                    update: function (vinUVlimitWarning) {this.set(vinUVlimitWarning)
                                        CorePlatformInterface.send(this)},
                                    set: function (vinUVlimitWarning) {this.payload.vinUVlimitWarning_target = vinUVlimitWarning;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setIoutOClimitFault: ({"cmd" : "set_ioutOClimitFault","payload": {"ioutOClimitFault_target": 0},
                                    update: function (ioutOClimitFault) {this.set(ioutOClimitFault)
                                        CorePlatformInterface.send(this)},
                                    set: function (ioutOClimitFault) {this.payload.ioutOClimitFault_target = ioutOClimitFault;},
                                    send: function () {CorePlatformInterface.send(this)},
                                    show: function () {CorePlatformInterface.show(this)}
                                })

    property var setIoutOClimitWarning: ({"cmd" : "set_ioutOClimitWarning","payload": {"ioutOClimitWarning_target": 0},
                                    update: function (ioutOClimitWarning) {this.set(ioutOClimitWarning)
                                        CorePlatformInterface.send(this)},
                                    set: function (ioutOClimitWarning) {this.payload.ioutOClimitWarning_target = ioutOClimitWarning;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var test: {"test" : ""} // Test: 1

    // set_test Command
    property var set_test: ({"cmd" : "set_test","payload": {"test": 0 ,},
                                     update: function (test) {this.set(test)
                                         CorePlatformInterface.send(this)},
                                     set: function (test) {this.payload.test = test;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var testResponse: {"testResponse" : ""} // "Single_Pulse","Double_Pulse","Burst","Short_Circuit"

    // testResponse_selection Command
    property var set_testResponse: ({"cmd" : "set_testResponse","payload": {"testResponse": 0 ,},
                                     update: function (testResponse) {this.set(testResponse)
                                         CorePlatformInterface.send(this)},
                                     set: function (testResponse) {this.payload.testResponse = testResponse;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var switchResponse: {"switchResponse" : ""} // "Q1","Q2","Q3","Q4","Q5","Q6"

    // switchResponse_selection Command
    property var set_switchResponse: ({"cmd" : "set_switchResponse","payload": {"switchResponse": 0 ,},
                                     update: function (switchResponse) {this.set(switchResponse)
                                         CorePlatformInterface.send(this)},
                                     set: function (switchResponse) {this.payload.switchResponse = switchResponse;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var constantResponse: {"constantResponse" : ""} // "Q1","Q2","Q3","Q4","Q5","Q6"

    // constantResponse_selection Command
    property var set_constantResponse: ({"cmd" : "set_constantResponse","payload": {"constantResponse": 0 ,},
                                     update: function (constantResponse) {this.set(constantResponse)
                                         CorePlatformInterface.send(this)},
                                     set: function (constantResponse) {this.payload.constantResponse = constantResponse;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    property var error:{"value":0} //Error Status

    property var system_mode: {"system_mode" : ""} // Stop: 2, Start: 3, Reset Error: 4

    property var  check_vin_good: ({"cmd":"check_vin_good",
                                       update: function () {CorePlatformInterface.send(this)},
                                       send: function () { CorePlatformInterface.send(this) },
                                       show: function () { CorePlatformInterface.show(this) }
                                   })

    property var  read_initial_status: ({"cmd":"read_initial_status",
                                            update: function () {CorePlatformInterface.send(this)},
                                            send: function () { CorePlatformInterface.send(this) },
                                            show: function () { CorePlatformInterface.show(this) }
                                        })

    property var setAcceleration: ({"cmd" : "set_acceleration","payload": {"acceleration_target": 0},
                                    update: function (acceleration) {this.set(acceleration)
                                        CorePlatformInterface.send(this)},
                                    set: function (acceleration) {this.payload.acceleration_target = acceleration;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setSpeed: ({"cmd" : "set_speed","payload": {"speed_target": 0},
                                    update: function (speed) {this.set(speed)
                                        CorePlatformInterface.send(this)},
                                    set: function (speed) {this.payload.speed_target = speed;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setPole_pairs: ({"cmd" : "set_pole_pairs","payload": {"pole_pairs_target": 0},
                                    update: function (pole_pairs) {this.set(pole_pairs)
                                        CorePlatformInterface.send(this)},
                                    set: function (pole_pairs) {this.payload.pole_pairs_target = pole_pairs;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setMax_motor_vout: ({"cmd" : "set_max_motor_vout","payload": {"max_motor_vout_target": 0},
                                    update: function (max_motor_vout) {this.set(max_motor_vout)
                                        CorePlatformInterface.send(this)},
                                    set: function (max_motor_vout) {this.payload.max_motor_vout_target = max_motor_vout;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setMax_motor_speed: ({"cmd" : "set_max_motor_speed","payload": {"max_motor_speed_target": 0},
                                    update: function (max_motor_speed) {this.set(max_motor_speed)
                                        CorePlatformInterface.send(this)},
                                    set: function (max_motor_speed) {this.payload.max_motor_speed_target = max_motor_speed;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setResistance: ({"cmd" : "set_resistance","payload": {"resistance_target": 0},
                                    update: function (resistance) {this.set(resistance)
                                        CorePlatformInterface.send(this)},
                                    set: function (resistance) {this.payload.resistance_target = resistance;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    property var setInductance: ({"cmd" : "set_inductance","payload": {"inductance_target": 0},
                                    update: function (inductance) {this.set(inductance)
                                        CorePlatformInterface.send(this)},
                                    set: function (inductance) {this.payload.inductance_target = inductance;},
                                    send: function () { CorePlatformInterface.send(this) },
                                    show: function () { CorePlatformInterface.show(this) }
                                })

    // system_mode_selection Command
    property var set_system_mode: ({"cmd" : "set_system_mode","payload": {"system_mode": 0 ,},
                                     update: function (system_mode) {this.set(system_mode)
                                         CorePlatformInterface.send(this)},
                                     set: function (system_mode) {this.payload.system_mode = system_mode;},
                                     send: function () { CorePlatformInterface.send(this) },
                                     show: function () { CorePlatformInterface.show(this) }
                                 })

    // This is a HACK implementation
    property var pause_periodic: ({"cmd" : "pause_periodic","payload": {"pause_flag": "",},
                                  set: function (pause_flag) {this.payload.pause_flag = pause_flag;},
                                  update: function (pause_flag) {this.set(pause_flag)
                                      CorePlatformInterface.send(this)},
                                  send: function () { CorePlatformInterface.send(this) },
                                  show: function () { CorePlatformInterface.show(this) }
                              })

    // -------------------------------------------------------------------

    // Connect to CoreInterface notification signals
    Connections {
        target: coreInterface
        onNotification: {
            CorePlatformInterface.data_source_handler(payload)
            pause_periodic = false
        }
    }

    //-----------------------------------------

    // add all syncrhonized controls here

    property int t1_single: 0
    onT1_singleChanged: {
        setT1_single.update(t1_single)
    }

    property int t1_double: 0
    onT1_doubleChanged: {
        setT1_double.update(t1_double)
    }

    property int t2_double: 0
    onT2_doubleChanged: {
        setT2_double.update(t2_double)
    }

    property int t3_double: 0
    onT3_doubleChanged: {
        setT3_double.update(t3_double)
    }

    property int frequency: 0
    onFrequencyChanged: {
        setFrequency.update(frequency)
    }

    property int duty: 0
    onDutyChanged: {
        setDuty.update(duty)
    }

    property int pulses: 0
    onPulsesChanged: {
        setPulses.update(pulses)
    }

    property int t1_short: 0
    onT1_shortChanged: {
        setT1_short.update(t1_short)
    }

    property int gainVolt: 0
    onGainVoltChanged: {
        setGainVolt.update(gainVolt)
    }

    property int offsetVolt: 0
    onOffsetVoltChanged: {
        setOffsetVolt.update(offsetVolt)
    }

    property int gainCurrent: 0
    onGainCurrentChanged: {
        setGainCurrent.update(gainCurrent)
    }

    property int offsetCurrent: 0
    onOffsetCurrentChanged: {
        setOffsetCurrent.update(offsetCurrent)
    }

    property int r25: 0
    onR25Changed: {
        setR25.update(r25)
    }

    property int r2550: 0
    onR2550Changed: {
        setR2550.update(r2550)
    }

    property int r2580: 0
    onR2580Changed: {
        setR2580.update(r2580)
    }

    property int r25120: 0
    onR25120Changed: {
        setR25120.update(r25120)
    }

    property int overTemperatureFault: 0
    onOverTemperatureFaultChanged: {
        setOverTemperatureFault.update(overTemperatureFault)
    }

    property int overTemperatureWarning: 0
    onOverTemperatureWarningChanged: {
        setOverTemperatureWarning.update(overTemperatureWarning)
    }

    property int vinOVlimitFault: 0
    onVinOVlimitFaultChanged: {
        setVinOVlimitFault.update(vinOVlimitFault)
    }

    property int vinOVlimitWarning: 0
    onVinOVlimitWarningChanged: {
        setVinOVlimitWarning.update(vinOVlimitWarning)
    }

    property int vinUVlimitFault: 0
    onVinUVlimitFaultChanged: {
        setVinUVlimitFault.update(vinUVlimitFault)
    }

    property int vinUVlimitWarning: 0
    onVinUVlimitWarningChanged: {
        setVinUVlimitWarning.update(vinUVlimitWarning)
    }

    property int ioutOClimitFault: 0
    onIoutOClimitFaultChanged: {
        setIoutOClimitFault.update(ioutOClimitFault)
    }

    property int ioutOClimitWarning: 0
    onIoutOClimitWarningChanged: {
        setIoutOClimitWarning.update(ioutOClimitWarning)
    }

    property int acceleration: 0
    onAccelerationChanged: {setAcceleration.update(acceleration)}

    property int speed: 0
    onSpeedChanged: {setSpeed.update(speed)}

    property int pole_pairs: 0
    onPole_pairsChanged: {setPole_pairs.update(pole_pairs)}

    property int max_motor_vout: 0
    onMax_motor_voutChanged: {setMax_motor_vout.update(max_motor_vout)}

    property int max_motor_speed: 0
    onMax_motor_speedChanged: {setMax_motor_speed.update(max_motor_speed)}

    property int resistance: 0
    onResistanceChanged: {setResistance.update(resistance)}

    property int inductance: 0
    onInductanceChanged: {setInductance.update(inductance)}

    // -------------------------------------------------------------------

    //property to sync the views and set the initial state
    property bool enabled: false
    property bool motor_EN_enabled: false
    property bool power_mode: false
    property bool advertise
    property int system_mode_state
}
