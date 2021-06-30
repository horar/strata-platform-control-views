import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item{
    property string class_id
    property string partNumber
    property string title
    property string warningHVVinLable
    property string warningLVVinLable
    property string opn

    property var minVin
    property var nominalVin
    property var vinScale
    property var ioutScale:1500

    property var ot_warning
    property var ot_fault
    property var ov_warning
    property var ov_fault
    property var uv_warning
    property var uv_fault
    property var oc_warning
    property var oc_fault

    property var gainVolt
    property var offsetVolt

    property var gainCurrent
    property var offsetCurrent

    property var r25
    property var r2550
    property var r2580
    property var r25120

    property var overTemperatureFault
    property var overTemperatureWarning

    property var vinOVlimitFault
    property var vinOVlimitWarning

    property var vinUVlimitFault
    property var vinUVlimitWarning

    property var ioutOClimitFault
    property var ioutOClimitWarning

    function check_class_id ()
    {
        if(class_id === "a715b4d6-b9a3-4fdf-a1da-bcf629146232") {
            title =  "<b> SiC SSDC inverter gate driver for SSDC SiC module </b>"
            partNumber = " <b> Part of the Motor Development Kit Family </b>"
            warningHVVinLable = "800V"
            warningLVVinLable = "0V"
            opn = "STR-SiC-SSDC-INV-UCB-GEVK"

            minVin = 0
            nominalVin = 600
            vinScale = 800
            ioutScale = 1500

            gainVolt = 205.338
            offsetVolt = 0

            gainCurrent = 495.05
            offsetCurrent = -825.083

            r25 = 5147
            r2550 = 3340
            r2580 = 3360
            r25120 = 3364

            overTemperatureFault = 110
            overTemperatureWarning = 105

            vinOVlimitFault = 550
            vinOVlimitWarning = 525

            vinUVlimitFault = 0
            vinUVlimitWarning = 0

            ioutOClimitFault = 700
            ioutOClimitWarning = 650
        }

        else  {
            console.log("unknown")
        }
    }
}
