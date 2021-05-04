import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item{

    property string class_id
    property string partNumber: "<b> Part of the Motor Development Kit Family </b>"
    property string title: "<b> 4kW 650V Industrial Motor Control with IPM & UCB </b>"
    property string warningHVVinLable: "400V"
    property string warningLVVinLable: "290V"
    property string opn: "SECO-MDK-4KW-65SPM31-GEVK"
    property real minVin: 200
    property real nominalVin: 410
    property real vinScale: 500
    property real ioutScale: 12

    function check_class_id ()
    {
        if(class_id === "a4e20d30-af03-43cf-98cf-b10cc5c7aa28") {
            title =  "<b> 4kW 650V Industrial Motor Control with IPM & UCB </b>"
            partNumber = " <b> Part of the Motor Development Kit Family </b>"
            warningHVVinLable = "400V"
            warningLVVinLable = "200V" //290
            opn = "SECO-MDK-4KW-65SPM31-GEVK"
            minVin = 200 //290
            nominalVin = 410
            vinScale = 500
            ioutScale = 12
        }
        else if(class_id === "d64c7dea-4509-45c6-8f99-02bf6e091366") {
            partNumber =  "<b> Part of the Motor Development Kit Family </b>"
            title =  "<b> 1kW 650V Industrial Motor Control with IPM & UCB</b> "
            warningHVVinLable = "265V"
            warningLVVinLable = "195V"
            opn = "SECO-1KW-MDK-GEVK"
            minVin = 195
            nominalVin = 265
            vinScale = 300
            ioutScale = 12
        }

        else  {
            console.log("unknown")
        }
    }
}
