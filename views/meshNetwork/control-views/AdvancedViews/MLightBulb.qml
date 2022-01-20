/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import tech.strata.sgwidgets 1.0

Image{
    id:lightBulbOff
    source: "../../images/lightBulbOff.svg"
    height:parent.height * .25
    fillMode: Image.PreserveAspectFit
    mipmap:true

    property alias onOpacity: lightBulbOn.opacity
    signal bulbClicked

    Image{
        id:lightBulbOn
        anchors.fill:lightBulbOff
        source: "../../images/lightBulbOn.svg"
        height:parent.height * .25
        fillMode: Image.PreserveAspectFit
        mipmap:true
        opacity:0

        Behavior on opacity {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutCubic
            }
        }

        MouseArea{
            id:bulbClickArea
            anchors.fill:parent

            onClicked:{
                lightBulbOff.bulbClicked()
            }


        }
    }
}
