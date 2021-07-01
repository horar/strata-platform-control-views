import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import tech.strata.sgwidgets 1.0
//import tech.strata.sgwidgets 0.9 as Widget09
import "images"
import "qrc:/js/help_layout_manager.js" as Help



Item {
    id: testPage
    Layout.fillHeight: true
    Layout.fillWidth: true

//    var dcs_1 = new Array(36)
//    var dcs_2 = new Array(36)

    property real ratioCalc: testPage.width / 1200
    property real initialAspectRatio: 0.8
    property real pictureRatio: 1541/872

    property real orignalPicWidth:    1541
    property real orignalPicHeight:    872


    property real testPX:    1290
    property real testPY:     562

    property real ledAPX101:     99
    property real ledAPY101:    100
    property real ledAPX102:    282
    property real ledAPY102:    135
    property real ledAPX103:    452
    property real ledAPY103:    145
    property real ledAPX104:    652
    property real ledAPY104:    146
    property real ledAPX105:    147
    property real ledAPY105:    309
    property real ledAPX106:    260
    property real ledAPY106:    497
    property real ledAPX107:    461
    property real ledAPY107:    623
    property real ledAPX108:    649
    property real ledAPY108:    690
    property real ledAPX109:    730  //725   //705
    property real ledAPY109:    350
    property real ledAPX110:    730  //725   //705
    property real ledAPY110:    508
    property real ledAPX111:    730  //725   //705
    property real ledAPY111:    429
    property real ledAPX112:    643  //649   //629
    property real ledAPY112:    429

    property real ledAPX201:    513   //523
    property real ledAPY201:    429
    property real ledAPX202:    599  //604
    property real ledAPY202:    508
    property real ledAPX203:    683
    property real ledAPY203:    508
    property real ledAPX204:    599  //604
    property real ledAPY204:    429
    property real ledAPX205:    599  //604
    property real ledAPY205:    350
    property real ledAPX206:    653
    property real ledAPY206:    219
    property real ledAPX207:    413
    property real ledAPY207:    281
    property real ledAPX208:    420  //450
    property real ledAPY208:    429
    property real ledAPX209:    513   //523
    property real ledAPY209:    508
    property real ledAPX210:    683
    property real ledAPY210:    429
    property real ledAPX211:    513   //523
    property real ledAPY211:    350
    property real ledAPX212:    683
    property real ledAPY212:    350

    property real ledAPX301:    651
    property real ledAPY301:    293
    property real ledAPX302:    362
    property real ledAPY302:    374
    property real ledAPX303:    556 //554
    property real ledAPY303:    350
    property real ledAPX304:    264
    property real ledAPY304:    203
    property real ledAPX305:    651
    property real ledAPY305:    624
    property real ledAPX306:    314
    property real ledAPY306:    440
    property real ledAPX307:    462
    property real ledAPY307:    550
    property real ledAPX308:    651
    property real ledAPY308:    576
    property real ledAPX309:    556  //554
    property real ledAPY309:    508
    property real ledAPX310:    468  //501
    property real ledAPY310:    424
    property real ledAPX311:    208
    property real ledAPY311:    269
    property real ledAPX312:    449
    property real ledAPY312:    217


    property real ledBPX101:    861
    property real ledBPY101:    164
    property real ledBPX102:   1066
    property real ledBPY102:    236
    property real ledBPX103:   1235
    property real ledBPY103:    363
    property real ledBPX104:   1351
    property real ledBPY104:    508
    property real ledBPX105:   1430
    property real ledBPY105:    714
    property real ledBPX106:   1231
    property real ledBPY106:    700
    property real ledBPX107:   1033
    property real ledBPY107:    700
    property real ledBPX108:    851
    property real ledBPY108:    700
    property real ledBPX109:    773   //793
    property real ledBPY109:    350
    property real ledBPX110:    773   //793
    property real ledBPY110:    508
    property real ledBPX111:    773   //793
    property real ledBPY111:    429
    property real ledBPX112:    856   //870
    property real ledBPY112:    429

    property real ledBPX201:    816
    property real ledBPY201:    350
    property real ledBPX202:    898  //892
    property real ledBPY202:    350
    property real ledBPX203:    980   //968
    property real ledBPY203:    350
    property real ledBPX204:    898  //892
    property real ledBPY204:    429
    property real ledBPX205:    816
    property real ledBPY205:    429
    property real ledBPX206:    816
    property real ledBPY206:    508
    property real ledBPX207:    980   //968
    property real ledBPY207:    429
    property real ledBPX208:    898  //892
    property real ledBPY208:    508
    property real ledBPX209:    980   //968
    property real ledBPY209:    508
    property real ledBPX210:    1062   //1045
    property real ledBPY210:    429
    property real ledBPX211:    858
    property real ledBPY211:    227
    property real ledBPX212:   1052
    property real ledBPY212:    280

    property real ledBPX301:    850
    property real ledBPY301:    624
    property real ledBPX302:   1036
    property real ledBPY302:    629
    property real ledBPX303:    857
    property real ledBPY303:    297
    property real ledBPX304:    848
    property real ledBPY304:    576
    property real ledBPX305:   1142
    property real ledBPY305:    508
    property real ledBPX306:   1085
    property real ledBPY306:    575
    property real ledBPX307:   1250
    property real ledBPY307:    634
    property real ledBPX308:   1031
    property real ledBPY308:    357
    property real ledBPX309:    938  //945
    property real ledBPY309:    508
    property real ledBPX310:   1021   //1018
    property real ledBPY310:    451  //443
    property real ledBPX311:   1188
    property real ledBPY311:    422
    property real ledBPX312:   1290
    property real ledBPY312:    562

    property var chip13: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    property var chip46: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    height:  parent.height
    width:   (parent.width / parent.height) < initialAspectRatio ? (parent.width * initialAspectRatio)  :  parent.width


    Component.onCompleted: {
        adcPeriodSet.value = 2000

//        platformInterface.commands.pwm_setting.update(pwmRecoverySetTest.cmd_autor_Test,pwmSettingButtonStripTest.cmd_pwm_freq_test, pwmFrequencyModeSetTest.cmd_pwm_linear_test)
//        platformInterface.commands.adc_setting.update(adcPeriodSet.cmd_adc_period_test, adcControlTest.cmd_adc_working_test)
        Help.registerTarget(navTabs, "    These tabs contain different user interface functionality of the \"Strata Multiple NCV7685 Chips for Rear Lighting Demo\" board. \n\n    \"Animation Demo\" page demonstrate seven kinds of animations and each one has configurable parameters. \n\n    \"Customized Test\" page shows one frame, which contains seventy-two LEDs. Each LED\'s intensity can be set individually to implement one pattern. The useful features of NCV7685 also can be enable or disable in this page.", 0, "TestPageHelp")
        Help.registerTarget(vContainer,"    The voltage gauge shows the input voltage of LED bus in real time.", 1, "TestPageHelp")
        Help.registerTarget(aContainer,  "    The current gauge shows the input current of LED bus in real time.", 2, "TestPageHelp")
        Help.registerTarget(settinglPanel, "    In this panel, setting parameters according to NCV7685’s key features. Configurable settings: \n\n    PWM Frequency:    300Hz \n    PWM Mode:           Logarithmic \n    Auto Recovery:       Off \n\n    ADC Sample Swtich: ON  \n    ADC Sample Period can changed by drag the slider.\n\n    LED Control:  All ON, All OFF, Seceted LEDs ON\n", 3, "TestPageHelp")
        Help.registerTarget(ledBoard, "    Hover on selected LEDs and drag the slider to set indensity.\n\n    The color of the slider's groove represents the color of the LED.", 4, "TestPageHelp")
//        Help.registerTarget(welcome_button, "    It shows \"Welcome\" animation, can be used as \"Leaving Home\" in the automotive lighting. \n\n    Configurable settings: One shot    Default: ON", 5, "TestPageHelp")
//        Help.registerTarget(brake_button, "    It shows \"Brake\" function. Intensity (PWM duty) can changed by drag the slider.\n\n    Configurable settings: PWM_DUTY    Default: 100 ", 6, "TestPageHelp")
//        Help.registerTarget(fading_button, "    It shows \"Fading\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 7, "TestPageHelp")
//        Help.registerTarget(leftturn_button, "    It shows \"Left Turn\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 8, "TestPageHelp")
//        Help.registerTarget(rightturn_button, "    It shows \"Right Turn\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 9, "TestPageHelp")
//        Help.registerTarget(warning_button, "    It shows \"Warning\" animation. Period and Cycle can changed by drag the slider.\n\n    Configurable settings: Period        Default: 1 \n                                    Cycle          Default: 4      \n                                    One shot     Default: ON", 10, "TestPageHelp")
//        Help.registerTarget(goodbye_button, "    It shows \"Goodbye\" animation, can be used as \"Going Home\" in the automotive lighting. \n\n    Configurable settings: One shot    Default: ON", 11, "TestPageHelp")
//        Help.registerTarget(setting_button, "    It shows \"Setting\" popup window to enable or disable the features of NCV7685.\n\nConfigurable settings: PWM Frequency: 300Hz \n                                PWM Mode: Logarithmic      \n                                Auto Recovery:  Off", 12, "TestPageHelp")
//        Help.registerTarget(pwmSettingContainer, "    Setting popup window, each control button has own paramets to configure. \n\nSend: send out commands according to the setting.\nExit:   exit the setting wiondow.", 13, "TestPageHelp")


        //            Help.registerTarget(name, "Place holder for Advanced control view help messages", 0, "AdvanceControlHelp")
    }

//    function calculatePositionX(xpos, radx){
//        if (boardBG.width/boardBG.height > orignalPicWidth/orignalPicHeight)
//            return   boardBG.width/2 - boardBG.height * orignalPicWidth/orignalPicHeight/2 +  xpos * boardBG.height * orignalPicWidth/orignalPicHeight/orignalPicWidth - radx/2
//        else
//            return xpos * boardBG.width/orignalPicWidth - radx/2
//    }

//    function calculatePositionY(ypos, rady){
//        if (boardBG.width/parent.height > orignalPicWidth/orignalPicHeight)
//            return   ypos * boardBG.height/orignalPicHeight - rady/2
//        else
//            return boardBG.height/2 - boardBG.width * orignalPicHeight / orignalPicWidth/2 +   ypos * boardBG.width * orignalPicHeight/orignalPicWidth/orignalPicHeight - rady/2
//   }

    function calculatePositionX(xpos, radx){
        if (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight)
//            return   ledBoard.width/2 - ledBoard.height * orignalPicWidth/orignalPicHeight/2 +  xpos * ledBoard.height * orignalPicWidth/orignalPicHeight/orignalPicWidth - radx/2
                    return   ledBoard.width/2 - ledBoard.height * orignalPicWidth/orignalPicHeight/2 +  xpos * ledBoard.height * orignalPicWidth/orignalPicHeight/orignalPicWidth
        else
//            return xpos * ledBoard.width/orignalPicWidth - radx/2
         return xpos * ledBoard.width/orignalPicWidth
    }

    function calculatePositionY(ypos, rady){
        if (ledBoard.width/parent.height > orignalPicWidth/orignalPicHeight)
            return   ypos * ledBoard.height/orignalPicHeight
//                    return   ypos * ledBoard.height/orignalPicHeight - rady/2
        else
            return ledBoard.height/2 - ledBoard.width * orignalPicHeight / orignalPicWidth/2 +   ypos * ledBoard.width * orignalPicHeight/orignalPicWidth/orignalPicHeight
//        return ledBoard.height/2 - ledBoard.width * orignalPicHeight / orignalPicWidth/2 +   ypos * ledBoard.width * orignalPicHeight/orignalPicWidth/orignalPicHeight - rady/2
   }

    Rectangle {
        id: boardBG
        width: parent.width
        height: parent.height*0.7
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#A2B5CD"
        //        color: "#ADD8E6"
        Image {
            id: ledBoard
            anchors.fill: parent
            //            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
//            source: "images/ledboard.png"
                        source: "images/ledboardv2.png"
            fillMode: Image.PreserveAspectFit

//            property real testPX:    1290
//            property real testPY:     562

//            LedNode {
//                id: led000
//                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  testPX * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((testPX * ledBoard.width/orignalPicWidth).toFixed(0))
//                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (testPY * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  testPY * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
//                redled :  true
//                onLedValueChanged: {
//                        console.log("onLedValueChanged:"+ledValue)
//                    }
//            }

            //-----------------------------------------------------------A01--START ------------------------------------------------------------------
            LedNode {
                id: ledA101
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX101 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX101 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY101 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY101 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled:  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    console.log("onLedValueChanged:"+ledValue)
                    chip13[0] = ledValue
                }
            }
            LedNode {
                id: ledA102
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX102 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX102 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY102 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY102 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
//                        console.log("onLedValueChanged:"+ledValue)
                        chip13[1] = ledValue
                    }
            }
            LedNode {
                id: ledA103
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX103 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX103 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY103 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY103 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    //                        console.log("onLedValueChanged:"+ledValue)
                    chip13[2] = ledValue
                }
            }
            LedNode {
                id: ledA104
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX104 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX104 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY104 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY104 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    //                    console.log("onLedValueChanged:"+ledValue)
                    chip13[3] = ledValue
                }
            }
            LedNode {
                id: ledA105
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX105 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX105 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY105 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY105 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[4] = ledValue
                }
            }
            LedNode {
                id: ledA106
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX106 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX106 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY106 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY106 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[5] = ledValue
                }
            }
            LedNode {
                id: ledA107
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX107 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX107 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY107 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY107 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[6] = ledValue
                }
            }
            LedNode {
                id: ledA108
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX108 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX108 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY108 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY108 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[7] = ledValue
                }
            }
            LedNode {
                id: ledA109
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX109 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX109 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY109 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY109 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[8] = ledValue
                }
            }
            LedNode {
                id: ledA110
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX110 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX110 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY110 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY110 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[9] = ledValue
                }
            }
            LedNode {
                id: ledA111
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX111 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX111 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY111 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY111 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[10] = ledValue
                }
            }
            LedNode {
                id: ledA112
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX112 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX112 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY112 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY112 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[11] = ledValue
                }
            }
        //-----------------------------------------------------------A01--END------------------------------------------------------------------

            LedNode {
                id: ledA201
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX201 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX201 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY201 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY201 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[12] = ledValue
                }
            }
            LedNode {
                id: ledA202
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX202 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX202 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY202 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY202 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[13] = ledValue
                }
            }
            LedNode {
                id: ledA203
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX203 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX203 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY203 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY203 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[14] = ledValue
                }
            }
            LedNode {
                id: ledA204
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX204 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX204 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY204 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY204 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                // ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip13[15] = ledValue
                }
            }
            LedNode {
                id: ledA205
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX205 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX205 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY205 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY205 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[16] = ledValue
                }
            }
            LedNode {
                id: ledA206
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX206 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX206 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY206 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY206 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[17] = ledValue
                }
            }
            LedNode {
                id: ledA207
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX207 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX207 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY207 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY207 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[18] = ledValue
                }
            }
            LedNode {
                id: ledA208
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX208 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX208 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY208 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY208 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                // ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip13[19] = ledValue
                }
            }
            LedNode {
                id: ledA209
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX209 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX209 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY209 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY209 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[20] = ledValue
                }
            }
            LedNode {
                id: ledA210
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX210 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX210 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY210 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY210 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[21] = ledValue
                }
            }
            LedNode {
                id: ledA211
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX211 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX211 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY211 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY211 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[22] = ledValue
                }
            }
            LedNode {
                id: ledA212
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX212 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX212 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY212 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY212 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip13[23] = ledValue
                }
            }
          //-----------------------------------------------------------A02--END------------------------------------------------------------------
            LedNode {
                id: ledA301
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX301 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX301 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY301 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY301 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[24] = ledValue
                }
            }
            LedNode {
                id: ledA302
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX302 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX302 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY302 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY302 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[25] = ledValue
                }
            }
            LedNode {
                id: ledA303
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX303 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX303 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY303 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY303 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[26] = ledValue
                }
            }
            LedNode {
                id: ledA304
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX304 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX304 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY304 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY304 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[27] = ledValue
                }
            }
            LedNode {
                id: ledA305
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX305 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX305 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY305 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY305 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[28] = ledValue
                }
            }
            LedNode {
                id: ledA306
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX306 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX306 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY306 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY306 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[29] = ledValue
                }
            }
            LedNode {
                id: ledA307
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX307 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX307 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY307 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY307 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[30] = ledValue
                    }
            }
            LedNode {
                id: ledA308
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX308 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX308 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY308 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY308 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[31] = ledValue
                }
            }
            LedNode {
                id: ledA309
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX309 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX309 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY309 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY309 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[32] = ledValue
                }
            }
            LedNode {
                id: ledA310
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX310 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX310 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY310 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY310 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[33] = ledValue
                }
            }
            LedNode {
                id: ledA311
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX311 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX311 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY311 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY311 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[34] = ledValue
                }
            }
            LedNode {
                id: ledA312
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledAPX312 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledAPX312 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledAPY312 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledAPY312 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip13[35] = ledValue
                    console.log("onLedValueChanged:"+ledValue)
                }
            }
          //-----------------------------------------------------------A03--END------------------------------------------------------------------

            LedNode {
                id: ledB101
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX101 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX101 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY101 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY101 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[0] = ledValue
                }
            }
            LedNode {
                id: ledB102
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX102 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX102 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY102 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY102 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[1] = ledValue
                }
            }
            LedNode {
                id: ledB103
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX103 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX103 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY103 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY103 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[2] = ledValue
                }
            }
            LedNode {
                id: ledB104
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX104 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX104 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY104 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY104 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[3] = ledValue
                }
            }
            LedNode {
                id: ledB105
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX105 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX105 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY105 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY105 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[4] = ledValue
                }
            }
            LedNode {
                id: ledB106
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX106 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX106 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY106 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY106 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[5] = ledValue
                }
            }
            LedNode {
                id: ledB107
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX107 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX107 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY107 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY107 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[6] = ledValue
                }
            }
            LedNode {
                id: ledB108
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX108 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX108 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY108 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY108 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[7] = ledValue
                }
            }
            LedNode {
                id: ledB109
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX109 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX109 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY109 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY109 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[8] = ledValue
                }
            }
            LedNode {
                id: ledB110
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX110 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX110 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY110 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY110 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[9] = ledValue
                }
            }
            LedNode {
                id: ledB111
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX111 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX111 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY111 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY111 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[10] = ledValue
                }
            }
            LedNode {
                id: ledB112
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX112 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX112 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY112 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY112 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[11] = ledValue
                }
            }

        //-----------------------------------------------------------B01--END------------------------------------------------------------------
            LedNode {
                id: ledB201
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX201 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX201 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY201 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY201 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[12] = ledValue
                }
            }
            LedNode {
                id: ledB202
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX202 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX202 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY202 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY202 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[13] = ledValue
                }
            }
            LedNode {
                id: ledB203
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX203 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX203 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY203 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY203 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[14] = ledValue
                }
            }
            LedNode {
                id: ledB204
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX204 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX204 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY204 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY204 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                // ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip46[15] = ledValue
                }
            }
            LedNode {
                id: ledB205
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX205 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX205 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY205 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY205 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[16] = ledValue
                }
            }
            LedNode {
                id: ledB206
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX206 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX206 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY206 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY206 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[17] = ledValue
                }
            }
            LedNode {
                id: ledB207
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX207 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX207 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY207 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY207 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[18] = ledValue
                }
            }
            LedNode {
                id: ledB208
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX208 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX208 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY208 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY208 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                // ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip46[19] = ledValue
                }
            }
            LedNode {
                id: ledB209
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX209 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX209 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY209 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY209 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                ledValue: 127
                color: "transparent"
                onLedValueChanged: {
                    chip46[20] = ledValue
                }
            }
            LedNode {
                id: ledB210
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX210 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX210 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY210 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY210 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  false
                // ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip46[21] = ledValue
                }
            }
            LedNode {
                id: ledB211
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX211 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX211 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY211 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY211 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                //               // ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip46[22] = ledValue
                }
            }
            LedNode {
                id: ledB212
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX212 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX212 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY212 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY212 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                //                ledValue :0
                color: "transparent"
                onLedValueChanged: {
                    chip46[23] = ledValue
                }
            }
          //-----------------------------------------------------------B02--END------------------------------------------------------------------
            LedNode {
                id: ledB301
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX301 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX301 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY301 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY301 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[24] = ledValue
                }
            }
            LedNode {
                id: ledB302
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX302 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX302 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY302 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY302 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[25] = ledValue
                }
            }
            LedNode {
                id: ledB303
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX303 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX303 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY303 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY303 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[26] = ledValue
                }
            }
            LedNode {
                id: ledB304
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX304 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX304 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY304 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY304 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[27] = ledValue
                }
            }
            LedNode {
                id: ledB305
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX305 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX305 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY305 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY305 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[28] = ledValue
                }
            }
            LedNode {
                id: ledB306
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX306 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX306 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY306 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY306 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[29] = ledValue
                }
            }
            LedNode {
                id: ledB307
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX307 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX307 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY307 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY307 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[30] = ledValue
                }
            }
            LedNode {
                id: ledB308
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX308 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX308 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY308 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY308 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[31] = ledValue
                }
            }
            LedNode {
                id: ledB309
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX309 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX309 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY309 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY309 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[32] = ledValue
                }
            }
            LedNode {
                id: ledB310
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX310 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX310 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY310 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY310 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[33] = ledValue
                }
            }
            LedNode {
                id: ledB311
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX311 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX311 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY311 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY311 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[34] = ledValue
                }
            }
            LedNode {
                id: ledB312
                x:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? ((   (ledBoard.width/2 - (ledBoard.height * orignalPicWidth/orignalPicHeight)/2) +  ledBPX312 * (ledBoard.height * orignalPicWidth/orignalPicHeight)/orignalPicWidth).toFixed(0))  :  ((ledBPX312 * ledBoard.width/orignalPicWidth).toFixed(0))
                y:  (ledBoard.width/ledBoard.height > orignalPicWidth/orignalPicHeight) ? (ledBPY312 * ledBoard.height/orignalPicHeight).toFixed(0) : (((ledBoard.height/2 - (ledBoard.width * orignalPicHeight / orignalPicWidth)/2) +  ledBPY312 * (ledBoard.width * orignalPicHeight/orignalPicWidth)/orignalPicHeight).toFixed(0))
                redled :  true
                color: "transparent"
                onLedValueChanged: {
                    chip46[35] = ledValue
                }
            }
          //-----------------------------------------------------------B02--END------------------------------------------------------------------
       }
    }

    Rectangle {
        id: controlPanel
        width: parent.width
        height: parent.height*0.3
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#A4D3EE"
        //        anchors.fill: parent
        //        color: "#A2B5CD"
        //         color: "#CAE1FF"
        //        color: "#B0E0E6"
        //        color: "#00FF00"

        Rectangle {
            id: vContainer
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width / 5
            height: width
            color: "transparent"

            Rectangle {
                id: voltageTcontainer
                color: "transparent"
                //            color: "#0000FF"
                anchors.fill: parent
                SGAlignedLabel {
                    id:voltageTLabel
                    target: voltageTGauge
                    anchors.centerIn: parent
                    alignment: SGAlignedLabel.SideBottomCenter
                    text: "LED Bus Voltage"
                    fontSizeMultiplier: ratioCalc * 2
                    font.bold : true
                    horizontalAlignment: voltageTcontainer.AlignHCenter
                    SGCircularGauge {
                        id: voltageTGauge
                        width: voltageTcontainer.width
                        height: voltageTcontainer.height -voltageTLabel.contentHeight
                        gaugeFillColor1: "#00CD66"
                        gaugeFillColor2: "#BCEE68"
                        unitText: "<b>V</b>"
                        unitTextFontSizeMultiplier: ratioCalc * 2.5
                        valueDecimalPlaces: 2
                        minimumValue:  0
                        maximumValue:  5
                        tickmarkStepSize: 1
                        value: 3.65

                        property var test_voltage_value: platformInterface.notifications.input_voltage_current.v_in
                        onTest_voltage_valueChanged: {
                            voltageTGauge.value = (test_voltage_value/1000).toFixed(2)
                        }

                    }
                }
            }
        }

        Rectangle {
            id: aContainer
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right:  parent.right
            anchors.rightMargin: 10
            width: parent.width / 5
            height: width
            color: "transparent"
            Rectangle {
                id: currentTcontainer
                color: "transparent"
                anchors.fill: parent
                SGAlignedLabel {
                    id:currentTLabel
                    target: currentTGauge
                    anchors.centerIn: parent
                    alignment: SGAlignedLabel.SideBottomCenter
                    text: "LED Bus Current"
                    fontSizeMultiplier: ratioCalc * 2
                    font.bold : true
                    horizontalAlignment: currentTcontainer.AlignHCenter
                    SGCircularGauge {
                        id: currentTGauge
                        width: currentTcontainer.width
                        height: currentTcontainer.height -currentTLabel.contentHeight
                        gaugeFillColor1: "#00CD66"
                        gaugeFillColor2: "#BCEE68"
                        unitText: "<b>A</b>"
                        unitTextFontSizeMultiplier: ratioCalc * 2.5
                        valueDecimalPlaces: 2
                        minimumValue:  0
                        maximumValue:  4
                        tickmarkStepSize: 1
                        value: 2.00
                        property var test_current_value: platformInterface.notifications.input_voltage_current.i_in
                        onTest_current_valueChanged: {
                            currentTGauge.value = (test_current_value/1000).toFixed(2)
                        }

                    }
                }
            }
        }

        Rectangle {
            id: settinglPanel
            width: parent.width * 0.5
            height: parent.height
            anchors.verticalCenter:  parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            //            color: "#00FF00"
            Rectangle {
                id: pwmSetting
                //                color: "#BCEE68"
                color: "transparent"
                border.color: Qt.lighter(color)
                radius: 10
                anchors.fill: parent

                Rectangle {
                    id: pwmColumnContainerTest
                    //                    color: "#FF0000"
                    color: "transparent"
                    width: parent.width * 0.7
                    height: parent.height * 0.9
                    anchors.verticalCenter:  parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -parent.width * 0.15
                    opacity: 1

                    Rectangle{
                        id: line1Test
                        width: parent.width
                        height: (parent.height)/5
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        anchors.top:  parent.top
                        anchors.topMargin: -4
                        color: "transparent"
                        SGText {
                            id: pwmFrequencyTextTest
                            text:" PWM Frequency(Hz):"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            //                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }

                    }

                    Rectangle{
                        id: line2Test
                        width: parent.width - 10
                        height: (parent.height)/5.5
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line1Test.bottom
                        anchors.topMargin: -6
                        color: "transparent"
                        ButttonStrip  {
                            id: pwmSettingButtonStripTest
                            width: parent.width
                            height: parent.height
                            //                            buttonColor: "#0cf"
                            buttonColor: "#E6E6FA"
                            //                            buttonColor: "#B0E2FF"
                            anchors.centerIn: parent.Center
                            model: ["150","300","600","1200"]
                            checkedIndices: 2
                            property int  cmd_pwm_freq_test:  300
                            onClicked: {
                                if(index === 0) {
                                    cmd_pwm_freq_test =  150
                                }
                                else if (index === 1){
                                    cmd_pwm_freq_test =  300
                                }
                                else if (index === 2){
                                    cmd_pwm_freq_test =  600
                                }
                                else  {
                                    cmd_pwm_freq_test =  1200
                                }

                                platformInterface.commands.pwm_setting.update(pwmRecoverySetTest.cmd_autor_Test,pwmSettingButtonStripTest.cmd_pwm_freq_test, pwmFrequencyModeSetTest.cmd_pwm_linear_test)
                            }

                        }

                    }

                    Rectangle{
                        id: line3Test
                        width: parent.width
                        height: (parent.height)/5
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line2Test.bottom
                        //                        anchors.topMargin: 8
                        color: "transparent"

                        SGText {
                            id: pwmFrequencyModeTest
                            text:" PWM Mode:"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            //                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }

                        SGText {
                            id: pwmRecoveryTest
                            text:"Auto Recovery:"
                            anchors.horizontalCenter:  parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            //                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }

                        SGText {
                            id: adcSwitchTest
                            text:"ADC Switch:"
                            anchors.right:  parent.right
                            anchors.rightMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            //                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold: true
                        }
                    }

                    Rectangle{
                        id: line4Test
                        width: parent.width
                        height: (parent.height)/5
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line3Test.bottom
                        anchors.topMargin: -12
                        color: "transparent"

                        SGSwitch  {
                            id: pwmFrequencyModeSetTest
                            width: parent.width /5
                            height:  parent.height/1.6
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            handleColor: "#F0F8FF"
                            grooveColor: "#E6E6FA"
                            grooveFillColor: "#0cf"
                            checked: true
                            checkedLabel: "Logarithmic"
                            uncheckedLabel: "Linear"
                            textColor: "black"

                            property bool cmd_pwm_linear_test:  false
                            onToggled:  {
                                if (checked){
                                    cmd_pwm_linear_test =  false
                                }
                                else{
                                    cmd_pwm_linear_test = true
                                }

                                platformInterface.commands.pwm_setting.update(pwmRecoverySetTest.cmd_autor_Test,pwmSettingButtonStripTest.cmd_pwm_freq_test, pwmFrequencyModeSetTest.cmd_pwm_linear_test)
                            }

                        }

                        SGSwitch {
                            id:  pwmRecoverySetTest
                            width: parent.width /5
                            height:  parent.height/1.6
                            anchors.horizontalCenter:  parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            handleColor: "#F0F8FF"
                            grooveColor: "#E6E6FA"
                            grooveFillColor: "#0cf"
                            //                    fontSizeMultiplier:  ratioCalc * 1.5
                            checked: false
                            checkedLabel: "ON"
                            uncheckedLabel: "Off"
                            textColor: "black"
                            property bool cmd_autor_Test:  false
                            onToggled:  {
                                if (checked){
                                    cmd_autor_Test = true
                                }
                                else{
                                    cmd_autor_Test = false
                                }

                                platformInterface.commands.pwm_setting.update(pwmRecoverySetTest.cmd_autor_Test,pwmSettingButtonStripTest.cmd_pwm_freq_test, pwmFrequencyModeSetTest.cmd_pwm_linear_test)
                            }
                        }

                        SGSwitch {
                            id:  adcControlTest
                            width: parent.width /5
                            height:  parent.height/1.6
                            anchors.right:  parent.right
                            anchors.rightMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            handleColor: "#F0F8FF"
                            grooveColor: "#E6E6FA"
                            grooveFillColor: "#0cf"
                            //                    fontSizeMultiplier:  ratioCalc * 1.5
                            checked: true
                            checkedLabel: "ON"
                            uncheckedLabel: "Off"
                            textColor: "black"
                            property bool cmd_adc_working_test:  true
                            onToggled:  {
                                if (checked){
                                    cmd_adc_working_test = true
                                }
                                else{
                                    cmd_adc_working_test = false
                                }

                                // {"cmd":"adc_setting","payload": {"working":true,"period": 1000 }}

                                platformInterface.commands.adc_setting.update(adcControlTest.cmd_adc_working_test, Number( ( adcPeriodSet.cmd_adc_period_test).toFixed(0) ) )
                            }
                        }
                    }

                    Rectangle{
                        id: line5Test
                        width: parent.width
                        //                        height: (parent.height)/5
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: line4Test.bottom
                        anchors.topMargin: 4
                        anchors.bottom: parent.bottom
                        color: "transparent"
                        //                        color: "#E6E6FA"

                        SGAlignedLabel {
                            id: adcPeriodSetting
                            target: adcPeriodSet
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            fontSizeMultiplier: ratioCalc * 1.2
                            font.bold : true
                            alignment: SGAlignedLabel.SideTopLeft
                            text: "ADC Sample Period(ms):"
                            color:  "#000000"
                            SGSlider {
                                id: adcPeriodSet
                                width: line5Test.width
                                fontSizeMultiplier: ratioCalc * 1.2
                                from: 500
                                to: 3000
                                stepSize: 100
                                property int cmd_adc_period_test:  1000
                                onUserSet: {
                                    cmd_adc_period_test = adcPeriodSet.value.toFixed(0)
                                    platformInterface.commands.adc_setting.update(adcPeriodSet.cmd_adc_period_test, adcControlTest.cmd_adc_working_test)
                                }
                            }
                        }
                    }

                }
            }

            Rectangle {
                id: ledOnContainer
                color: "transparent"
                width: parent.width/4
                height:  width/2
                anchors.top:  parent.top
                anchors.topMargin:  4
                anchors.right: parent.right
                //                anchors.rightMargin: 10
                opacity: 1

                SGButton {
                    id: ledOnButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    alternativeColorEnabled: true
                    text: "<b>All ON</b>"
                    fontSizeMultiplier: ratioCalc * 2
                    color: "#00CD66"
                    onClicked: {
                        ledA101.ledValue = 127
                        ledA102.ledValue = 127
                        ledA103.ledValue = 127
                        ledA104.ledValue = 127
                        ledA105.ledValue = 127
                        ledA106.ledValue = 127
                        ledA107.ledValue = 127
                        ledA108.ledValue = 127
                        ledA109.ledValue = 127
                        ledA110.ledValue = 127
                        ledA111.ledValue = 127
                        ledA112.ledValue = 127

                        ledA201.ledValue = 127
                        ledA202.ledValue = 127
                        ledA203.ledValue = 127
                        ledA204.ledValue = 127
                        ledA205.ledValue = 127
                        ledA206.ledValue = 127
                        ledA207.ledValue = 127
                        ledA208.ledValue = 127
                        ledA209.ledValue = 127
                        ledA210.ledValue = 127
                        ledA211.ledValue = 127
                        ledA212.ledValue = 127


                        ledA301.ledValue = 127
                        ledA302.ledValue = 127
                        ledA303.ledValue = 127
                        ledA304.ledValue = 127
                        ledA305.ledValue = 127
                        ledA306.ledValue = 127
                        ledA307.ledValue = 127
                        ledA308.ledValue = 127
                        ledA309.ledValue = 127
                        ledA310.ledValue = 127
                        ledA311.ledValue = 127
                        ledA312.ledValue = 127
                        platformInterface.commands.dcs_1.update(chip13)
                        delayTimer1.start()

                        ledB101.ledValue = 127
                        ledB102.ledValue = 127
                        ledB103.ledValue = 127
                        ledB104.ledValue = 127
                        ledB105.ledValue = 127
                        ledB106.ledValue = 127
                        ledB107.ledValue = 127
                        ledB108.ledValue = 127
                        ledB109.ledValue = 127
                        ledB110.ledValue = 127
                        ledB111.ledValue = 127
                        ledB112.ledValue = 127

                        ledB201.ledValue = 127
                        ledB202.ledValue = 127
                        ledB203.ledValue = 127
                        ledB204.ledValue = 127
                        ledB205.ledValue = 127
                        ledB206.ledValue = 127
                        ledB207.ledValue = 127
                        ledB208.ledValue = 127
                        ledB209.ledValue = 127
                        ledB210.ledValue = 127
                        ledB211.ledValue = 127
                        ledB212.ledValue = 127


                        ledB301.ledValue = 127
                        ledB302.ledValue = 127
                        ledB303.ledValue = 127
                        ledB304.ledValue = 127
                        ledB305.ledValue = 127
                        ledB306.ledValue = 127
                        ledB307.ledValue = 127
                        ledB308.ledValue = 127
                        ledB309.ledValue = 127
                        ledB310.ledValue = 127
                        ledB311.ledValue = 127
                        ledB312.ledValue = 127
//                        platformInterface.commands.dcs_2.update(chip46)
                    }

                    Timer {
                        id: delayTimer1;
                        interval: 300
                        repeat: false
                        onTriggered: {
                            delayTimer1.stop()
                            platformInterface.commands.dcs_2.update(chip46)
                        }
                    }
                }
            }
            Rectangle {
                id: ledOffContainer
                color: "transparent"
                width: parent.width/4
                height:  width/2
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                //                anchors.rightMargin: 10
                opacity: 1

                SGButton {
                    id: ledOffButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    alternativeColorEnabled: true
                    text: "<b>All Off</b>"
                    fontSizeMultiplier: ratioCalc * 2
                    color: "#00CD66"
                    onClicked: {
                        ledA101.ledValue = 0
                        ledA102.ledValue = 0
                        ledA103.ledValue = 0
                        ledA104.ledValue = 0
                        ledA105.ledValue = 0
                        ledA106.ledValue = 0
                        ledA107.ledValue = 0
                        ledA108.ledValue = 0
                        ledA109.ledValue = 0
                        ledA110.ledValue = 0
                        ledA111.ledValue = 0
                        ledA112.ledValue = 0

                        ledA201.ledValue = 0
                        ledA202.ledValue = 0
                        ledA203.ledValue = 0
                        ledA204.ledValue = 0
                        ledA205.ledValue = 0
                        ledA206.ledValue = 0
                        ledA207.ledValue = 0
                        ledA208.ledValue = 0
                        ledA209.ledValue = 0
                        ledA210.ledValue = 0
                        ledA211.ledValue = 0
                        ledA212.ledValue = 0


                        ledA301.ledValue = 0
                        ledA302.ledValue = 0
                        ledA303.ledValue = 0
                        ledA304.ledValue = 0
                        ledA305.ledValue = 0
                        ledA306.ledValue = 0
                        ledA307.ledValue = 0
                        ledA308.ledValue = 0
                        ledA309.ledValue = 0
                        ledA310.ledValue = 0
                        ledA311.ledValue = 0
                        ledA312.ledValue = 0
                        platformInterface.commands.dcs_1.update(chip13)
                        delayTimer2.start()

                        ledB101.ledValue = 0
                        ledB102.ledValue = 0
                        ledB103.ledValue = 0
                        ledB104.ledValue = 0
                        ledB105.ledValue = 0
                        ledB106.ledValue = 0
                        ledB107.ledValue = 0
                        ledB108.ledValue = 0
                        ledB109.ledValue = 0
                        ledB110.ledValue = 0
                        ledB111.ledValue = 0
                        ledB112.ledValue = 0

                        ledB201.ledValue = 0
                        ledB202.ledValue = 0
                        ledB203.ledValue = 0
                        ledB204.ledValue = 0
                        ledB205.ledValue = 0
                        ledB206.ledValue = 0
                        ledB207.ledValue = 0
                        ledB208.ledValue = 0
                        ledB209.ledValue = 0
                        ledB210.ledValue = 0
                        ledB211.ledValue = 0
                        ledB212.ledValue = 0


                        ledB301.ledValue = 0
                        ledB302.ledValue = 0
                        ledB303.ledValue = 0
                        ledB304.ledValue = 0
                        ledB305.ledValue = 0
                        ledB306.ledValue = 0
                        ledB307.ledValue = 0
                        ledB308.ledValue = 0
                        ledB309.ledValue = 0
                        ledB310.ledValue = 0
                        ledB311.ledValue = 0
                        ledB312.ledValue = 0
//                        platformInterface.commands.dcs_2.update(chip46)
                    }

                    Timer {
                        id: delayTimer2;
                        interval: 300
                        repeat: false
                        onTriggered: {
                            delayTimer2.stop()
                            platformInterface.commands.dcs_2.update(chip46)
                        }
                    }
                }
            }

            Rectangle {
                id:ledSettedContainer
                //                                        color: "#0000FF"
                color: "transparent"
                width: parent.width/4
                height:  width/2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                anchors.right: parent.right
                //                anchors.rightMargin: 10
                opacity: 1
                SGButton {
                    id: ledSettedButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    alternativeColorEnabled: true
                    text: "<b>Selected</b>"
                    fontSizeMultiplier: ratioCalc * 2
                    color: "#00CD66"
                    onClicked: {
                        platformInterface.commands.dcs_1.update(chip13)
                        delayTimer3.start()
//                        platformInterface.commands.dcs_2.update(chip46)
                    }
                    Timer {
                        id: delayTimer3;
                        interval: 300
                        repeat: false
                        onTriggered: {
                            delayTimer3.stop()
                            platformInterface.commands.dcs_2.update(chip46)
                        }
                    }
                }
            }

        } //END  settinglPanel
    } //END  controlPanel
} //END

