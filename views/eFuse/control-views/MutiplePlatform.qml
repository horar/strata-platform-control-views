/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item {

    property string class_id
    property string partNumber:  "NIS5020 eFuse"
    property var slewModel: [ "1ms", "5ms" ]



    function check_class_id(){
        if(class_id === "227"){
            partNumber =  "NIS5020 eFuse"
        }
        else if(class_id === "228") {
            partNumber = "NIS5820 eFuse"

        }
        else if(class_id === "229") {
            partNumber = "NIS5132 eFuse"
            slewModel = ["1.5ms", "8ms"]
        }
        else if(class_id === "230") {
            partNumber = "NIS5232 eFuse"
            slewModel = ["1.5ms", "8ms"]
        }
        else {
            console.log("platform undefined")
        }
    }

}
