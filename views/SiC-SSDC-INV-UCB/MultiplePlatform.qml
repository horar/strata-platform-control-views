import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item{
    property string class_id
    property string partNumber
    property string title
    property string warningHVVinLable
    property string warningLVVinLable
    property string opn
    property real minVin
    property real nominalVin
    property real vinScale
    property real ioutScale

    function check_class_id ()
    {
        if(class_id === "a715b4d6-b9a3-4fdf-a1da-bcf629146232") {
            title =  "<b> SiC SSDC inverter gate driver for SSDC SiC module </b>"
            partNumber = " <b> Part of the Motor Development Kit Family </b>"
            warningHVVinLable = "600V"
            warningLVVinLable = "0V"
            opn = "STR-SiC-SSDC-INV-UCB-GEVK"
            minVin = 0
            nominalVin = 600
            vinScale = 1000
            ioutScale = 1500
        }

        else  {
            console.log("unknown")
        }
    }
}
