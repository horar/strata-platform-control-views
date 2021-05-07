import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item{

    property string class_id
    property string eeprom_ID
    property string partNumber
    property string title
    property string warningHVVinLable
    property string warningLVVinLable
    property string opn
    property real minVin
    property real nominalVin
    property real vinScale
    property real iinScale
    property real voutScale
    property real ioutScale
    property real poutScale
    property real pdissScale
    property bool showDecimal
    property real poutStep
    property real pdissStep
    property bool dio12
    property bool lowpowerDCDC
    property string pdiss
    property string current

    function check_class_id ()
    {

        if(class_id === "d4937f24-219a-4648-a711-2f6e902b6f1c") {
            eeprom_ID = "d4937f24-219a-4648-a711-2f6e902b6f1c"
            partNumber = "<b> FD6000/A </b>"
            title = "<b> DCX-LLC demoboard </b>"
            warningHVVinLable = "70V"
            warningLVVinLable = "30V"
            opn = "STR-PWRFD6000-R0-GEVK"
            minVin = 30
            nominalVin = 60
            vinScale = 100
            iinScale = 20
            voutScale = 20
            ioutScale = 100
            poutScale = 1000
            pdissScale = 500
            showDecimal = true
            poutStep = 100
            pdissStep = 50
            dio12 = true
            lowpowerDCDC = true
            pdiss = "W"
            current = "A"
        }

        else if(class_id === "057ec75e-e48f-42db-bea9-3d191ed8a736") {
            eeprom_ID = "d4937f24-219a-4648-a711-2f6e902b6f1c"
            partNumber = "<b> FD350X </b>"
            title = "<b> 48V/12V Full-Bridge demoboard </b>"
            warningHVVinLable = "70V"
            warningLVVinLable = "30V"
            opn = "STR-PWRFD350X-R0-GEVK"
            minVin = 30
            nominalVin = 60
            vinScale = 100
            iinScale = 20
            voutScale = 20
            ioutScale = 100
            poutScale = 1000
            pdissScale = 500
            showDecimal = true
            poutStep = 100
            pdissStep = 50
            dio12 = true
            lowpowerDCDC = true
            pdiss = "W"
            current = "A"
        }

        else  {
            console.log("unknown")
        }
    }
}
