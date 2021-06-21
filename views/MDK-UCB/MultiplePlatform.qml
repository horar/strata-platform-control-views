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
        if(class_id === "a4e20d30-af03-43cf-98cf-b10cc5c7aa28") {
            title =  "<b> 4kW 650V Industrial Motor Control with IPM & UCB </b>"
            partNumber = " <b> Part of the Motor Development Kit Family </b>"
            warningHVVinLable = "410V"
            warningLVVinLable = "290V"
            opn = "STR-MDK-4KW-65SPM31-GEVK"
            minVin = 290
            nominalVin = 410
            vinScale = 500
            ioutScale = 12
        }

        else if(class_id === "d64c7dea-4509-45c6-8f99-02bf6e091366") {
            partNumber =  "<b> Part of the Motor Development Kit Family </b>"
            title =  "<b> 1kW 650V Industrial Motor Control with IPM & UCB</b>"
            warningHVVinLable = "400V"
            warningLVVinLable = "340V"
            opn = "STR-1KW-MDK-GEVK"
            minVin = 340
            nominalVin = 400
            vinScale = 500
            ioutScale = 12
        }

        else if(class_id === "334aeac5-129f-4f31-83f1-461a5cfd7377") {
            partNumber =  "<b> Part of the Motor Development Kit Family </b>"
            title =  "<b> 8kW 650V Industrial Motor Control with TMPIM & UCB</b>"
            warningHVVinLable = "390V"
            warningLVVinLable = "200V"
            opn = "STR-TMPIM-MDK-GEVK"
            minVin = 200
            nominalVin = 390
            vinScale = 500
            ioutScale = 60
        }

        else  {
            console.log("unknown")
        }
    }
}
