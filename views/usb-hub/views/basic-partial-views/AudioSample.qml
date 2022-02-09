/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../../sgwidgets"

Item {
    id: root
    property var value

    Rectangle{
        id:valueRectangle
        anchors.left:parent.left
        anchors.leftMargin:2
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:parent.right
        anchors.rightMargin: 2
        height: root.height * root.value
        radius:width/2
        color:"black"

    }

//    ParallelAnimation{
//        id:updateValueRectSize
//        PropertyAnimation{
//            target:valueRectangle
//            property:"height"
//            to:root.height * root.value
//            duration: audioSampleTransitionSpeed
//        }
//        PropertyAnimation{
//            target:valueRectangle
//            property:"x"
//            to:root.height - (root.height * root.value)/2
//            duration: audioSampleTransitionSpeed
//        }
//    }

//    onValueChanged: {
//        updateValueRectSize.start()
//    }

//    onHeightChanged: {
//        //so static value will resize when transitioning basic->advanced screen
//        updateValueRectSize.start()
//    }
}
