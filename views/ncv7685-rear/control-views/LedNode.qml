/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import tech.strata.sgwidgets 1.0
//import tech.strata.sgwidgets 1.0 as SGWidgets
import QtGraphicalEffects 1.12


Rectangle {
    id: root    //ledbg

    implicitWidth:  8
    implicitHeight: implicitWidth

    property bool redled :  true
    property alias ledValue : ledSet.value
    property alias interval : ledTimer.interval

    Rectangle {
          id: led
          width: parent.width
          height: width
          radius: width/2
//          color: "#696969"
          color: "#4F4F4F"

          antialiasing: true

          MouseArea {
              id: led_mouse_area
              width: led.width * 1.2
              height: width
              anchors.verticalCenter: led.verticalCenter
              anchors.horizontalCenter: led.horizontalCenter
              hoverEnabled: true;
              onEntered: {  ledSet.visible = true ; ledTimer.start()}
              }
      }

      Rectangle {
          id: rgled
          width: led.width * 3
          height: width
          radius: width/2
          anchors.verticalCenter: led.verticalCenter
          anchors.horizontalCenter: led.horizontalCenter
          color: "transparent"
          visible: ledSet.value > 0 ? true : false
          RadialGradient {
                    anchors.fill: parent
                    angle: 0.0

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white" }
                        GradientStop { position: 0.1; color: root.redled ? Qt.rgba(0.5 + ledSet.value/254,0,0,1) : Qt.rgba(0.5 + ledSet.value/254,0.5 + ledSet.value/254,0,1)}
                        GradientStop { position: 0.5; color: root.redled ? Qt.rgba(0.01,0,0,1) : Qt.rgba(0.01,0.01,0,1)}
                        GradientStop { position: 1; color:  "transparent" }
                    }
          }

      }



      SGSlider {
          id: ledSet
          width:rgled.width * 5
          anchors.top : rgled.bottom
          anchors.horizontalCenter: rgled.horizontalCenter
          visible: false
          from: 0
          to: 127
          value: 0
          stepSize: 1
          fillColor: root.redled ? "#ff0000" : "#ffff00"
          //                    property int cmd_adc_period_test:  1000
          onUserSet: {
              ledTimer.restart()
          }
      }

      Timer {
          id: ledTimer;
          interval: 2000
          repeat: false
          //                    triggeredOnStart: true;
          onTriggered:{
              ledTimer.stop()
              ledSet.visible = false
//              ledText.visible = false
          }
      }


  }




