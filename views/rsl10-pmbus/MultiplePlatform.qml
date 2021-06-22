import QtQuick 2.0
import "qrc:/js/navigation_control.js" as NavigationControl

Item{

    property string class_id
    property string eeprom_ID: "d4937f24-219a-4648-a711-2f6e902b6f1c"
    property string partNumber:"<b> FD6000/A </b>"
    property string title: "<b> DCX-LLC demoboard </b>"
    property string warningHVVinLable: "70V"
    property string warningLVVinLable: "30V"
    property string opn: "STR-PWRFD6000-R0-GEVK"
    property var minVin: 30
    property var nominalVin: 60
    property var vinScale: 100
    property var iinScale: 20
    property var voutScale: 20
    property var ioutScale: 100
    property var poutScale: 1000
    property var pdissScale: 500
    property bool showDecimal: true
    property var poutStep: 100
    property var pdissStep: 50
    property bool dio12: true
    property bool lowpowerDCDC: true
    property string pdiss: "W"
    property string current: "A"

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
            poutScale = 1500
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
            poutScale = 1500
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
