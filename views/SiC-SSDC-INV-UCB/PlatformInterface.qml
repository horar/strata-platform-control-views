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
                                      send: function () { CorePlatformInterface.send(this) },
                                      show: function () { CorePlatformInterface.show(this) }
                                  })

    property var read_motor_EN: ({ "cmd" : "read_motor_EN",
                                   update: function () {CorePlatformInterface.send(this)},
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }
                               })

    property var read_enable: ({ "cmd" : "read_enable",
                                   update: function () {CorePlatformInterface.send(this)},
                                   send: function () { CorePlatformInterface.send(this) },
                                   show: function () { CorePlatformInterface.show(this) }
                               })

    property var set_motor_EN: ({"cmd" : "set_motor_EN","payload": {"motor_EN_enable": " ",},
                                  update: function (motor_EN_enabled) {this.set(motor_EN_enabled)
                                      CorePlatformInterface.send(this)},
                                  set: function (motor_EN_enabled) {this.payload.motor_EN_enable = motor_EN_enabled;},
                                  send: function () { CorePlatformInterface.send(this) },
                                  show: function () { CorePlatformInterface.show(this) }
                              })

    property var set_direction: ({"cmd" : "set_direction","payload": {"direction": 0},
                                  update: function (direction) {this.set(direction)
                                      CorePlatformInterface.send(this)},
                                  set: function (direction) {this.payload.direction = direction;},
                                  send: function () { CorePlatformInterface.send(this) },
                                  show: function () { CorePlatformInterface.show(this) }
                              })

    property var set_enable: ({"cmd" : "set_enable","payload": {"enable": " ",},
                                  update: function (enabled) {this.set(enabled)
                                      CorePlatformInterface.send(this)},
                                  set: function (enabled) {this.payload.enable = enabled;},
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
